package Scribe::App;

use strict;
use warnings;

use Scribe::Schema;
use Scribe::_Config;

use base qw(CGI::Ex::App);
use CGI::Ex::Dump qw(debug);
use CGI::Ex::Die register => 1;

our $NO_ADD_MSG = 0;

###---------------------------------------------------------------###
# APP SERVER SETTINGS

sub require_auth { 1 }

sub config { 'Scribe::_Config' }

sub app_path {
    my $self = shift;
    my $conf = $self->config;
    return $conf->webroot.'/'.$conf->app_dirname;
};

sub template_path { shift->app_path . '/tt' }

sub name_module { 'scribe' }

sub url_base {
    my $self = shift;
    my $conf = $self->config;
    return 'http://'. $conf->server_url .'/'. $conf->app_dirname;
}

sub url { shift->url_base }

sub theme { 'dark_sky' }

sub url_theme {
    my $self = shift;
    return $self->url_base.'/media/'.$self->theme;
}

sub url_js { shift->url_base.'/js' }
sub url_cgi { shift->url_base.'/cgi' }

sub url_cgi_board {
    my $self = shift;
    my $project_id = $self->project_id;
    return $self->url_cgi.'/scene_board'.($project_id ? "/$project_id" : '');
}

sub url_cgi_project { shift->url_cgi.'/project' }

###---------------------------------------------------------------###
# login/authentication

sub auth_args {
    my $self = shift;
    # FIXME Not sure why below isn't working
    # I've played around with various template_include_path values
    # Still get a "wrapper.html not found"
#    my $hash = {
#        template_include_path => $self->template_path.'/scribe',
#        login_header => 'wrapper.html',
#        login_footer => 'footer.html',
#    };

    my $login_header;
    open my $fh, '<:encoding(UTF-8)', $self->template_path.'/scribe/wrapper.html';
    {
        local $/;
        $login_header = <$fh>;
    }
    close $fh;
    $login_header .= '<div style="margin:.5em;padding:.5em;">';

    my $login_footer;
    open $fh, '<:encoding(UTF-8)', $self->template_path.'/scribe/footer.html';
    {
        local $/;
        $login_footer = <$fh>;
    }
    close $fh;
    $login_footer .= '</div>'.$login_footer;
    my $hash = {
        login_header => \$login_header,
        login_footer => \$login_footer,
    };
    return $hash;
}

###---------------------------------------------------------------###
# universal functions

our $SCHEMA;
sub schema {
    my $self = shift;
    return $SCHEMA ||= do {
        my $conf = ref $self->can('config') ? $self->config : config() ;
        my $dbname = $conf->dbname;
        my $dbhost = $conf->dbhost;
        my $dbport = $conf->dbport;
        Scribe::Schema->connect("dbi:Pg:database=$dbname;host=$dbhost;port=$dbport", $conf->dbuser, $conf->dbpass);
    }
}

sub get_pass_by_user {
    my $self = shift;
    my $name = shift;
    my $user = $self->schema->resultset('AccessUser')->single({ name => $name });
    return $user->password;
}

sub hash_base {
    my $self = shift;
    my $path = $self->template_path . '/scribe';
    my $hash = {
        header_path => "$path/header.html",
        footer_path => "$path/footer.html",
        app_title   => 'Scribe',
        url         => $self->url,
        url_css     => $self->url_theme,
        url_js      => $self->url_js,
        url_cgi     => $self->url_cgi,
        url_base    => $self->url_base,
    };

    $hash->{'section'} = 'Login Required!' unless $self->is_authed;
    return $hash;
}

sub table2pkg {
    my $self = shift;
    my $table = shift or die 'table undef';
    my $join = shift;
    $join = '' unless defined $join;
    return join $join, map { ucfirst $_ } split '_', $table;
}

# query db with DBIx but convert and return
# results as an array of hashes instead of objects
sub flat_search {
    my $self = shift;
    my $pkg  = shift || die '$pkg missing';

    my $schema  = $self->schema;
    my @columns = $schema->source($pkg)->columns;

    my @rows;
    my $results_obj = $schema->resultset($pkg)->search(@_);
    while (my $row_obj = $results_obj->next) {
        my %row_flat;
        foreach my $col (@columns) {
            $row_flat{$col} = $row_obj->$col;
        }
        push @rows, \%row_flat;
    }

    return \@rows;
}

sub add_record {
    my $self = shift;
    my $pkg  = shift || die '$pkg missing';
    my $form = shift || { %{ $self->form } };

    my %args;
    my $schema = $self->schema;
    my $source = $schema->source($pkg);

    my @pc = $source->primary_columns;
    die 'TODO! Not sure how to handle multiple primary columns' if scalar @pc > 1;
    my $primary_col = $pc[0] || die 'primary column not found';

    foreach my $col ($source->columns) {
        my $value = $form->{$col};
        next unless defined $value;
        $args{$col} = $value;
    }

    my $row_obj = $schema->resultset($pkg)->create(\%args);

    if(my $id = $row_obj->$primary_col) {
        $self->set_success("$pkg #$id Added") unless $NO_ADD_MSG;
    }
    else {
        die "Failed to create $pkg";
    }

    return $row_obj;
}

sub project_id {
    my $self = shift;

    if(my $project_id = $self->form->{'project_id'}) {
        return $project_id;
    }

    $self->stash->{'project_id'} = shift if scalar @_;
    return $self->stash->{'project_id'};
}

###---------------------------------------------------------------###
# msg queue stuff

sub msg_queue_file { '.msg_queue' }

sub set_success {
    my $self = shift;
    my $msg  = shift;
    open(my $fh, '>>', $self->msg_queue_file) or return;
    print $fh "$msg\n";
    close $fh;
}

sub get_success {
    my $self = shift;
    my $file = $self->msg_queue_file;
    return unless -e $file;
    open(my $fh, '<', $file) or return;
    my @rows = <$fh>;
    close $fh;
    unlink $file;
    return join("<br />", @rows);
}


###---------------------------------------------------------------###
# main step

sub main_hash_swap {
    my $self  = shift;
    return {
        css_step => $self->url_theme."/main.css",
        section => 'Main',
    }
}

###---------------------------------------------------------------###
# common step: add

sub add_finalize_common {
    my $self = shift;
    my $pkg  = shift || '$pkg missing';
    $self->add_record($pkg, @_);
    $self->cgix->location_bounce($self->url);
    return 0;
}

1;
