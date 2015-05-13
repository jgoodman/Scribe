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
    return {
        header_path => "$path/header.html",
        footer_path => "$path/footer.html",
        app_title   => 'Scribe',
        url         => $self->url,
        url_css     => $self->url_theme,
        url_js      => $self->url_js,
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
        css_step => $self->url_theme."/main.css",
        section => 'Main',
    }
}


1;
