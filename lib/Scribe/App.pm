package Scribe::App;

use strict;
use warnings;

use Scribe::Schema;
use Scribe::_Config;

use base qw(CGI::Ex::App);
use CGI::Ex::Dump qw(debug);
use CGI::Ex::Die register => 1;

###---------------------------------------------------------------###
# APP SERVER SETTINGS

sub require_auth { 1 }

sub config { 'Scribe::_Config' }

sub app_path {
    my $self = shift;
    return $self->config->webroot.'/'.$self->config->app_dirname;
};

sub template_path { shift->app_path . '/tt' }

sub name_module { 'scribe' }

sub url {
    my $self = shift;
    return 'http://'. $self->config->server_url .'/'. $self->config->app_dirname;
}

sub theme { 'dark_sky' }

sub theme_path {
    my $self = shift;
    return $self->url.'/media/'.$self->theme;
}

###---------------------------------------------------------------###
# universal functions

our $SCHEMA;
sub schema {
    my $self = shift;
    return $SCHEMA ||= do {
        my $c = ref $self->can('config') ? $self->config : config() ;
        Scribe::Schema->connect('dbi:Pg:database='.$c->dbname.';host='.$c->dbhost.';port=5432', $c->dbuser, $c->dbpass);
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
    return {
        header_path => "$path/header.html",
        footer_path => "$path/footer.html",
        app_title   => 'Scribe',
        css         => $self->theme_path.'/style.css',
        url         => $self->url.'/cgi/scribe/',
    };
}

sub table2pkg {
    my $self = shift;
    my $table = shift or die 'table undef';
    my $join = shift;
    $join = '' unless defined $join;
    return join $join, map { ucfirst $_ } split '_', $table;
}

###---------------------------------------------------------------###
# main step

sub main_hash_swap {
    my $self  = shift;
    return {
        css_step => $self->theme_path."/main.css",
        section => 'Main',
    }
}


1;
