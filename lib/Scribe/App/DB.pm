package Scribe::App::DB;

use strict;
use warnings;

use base qw(Scribe::App);
use CGI::Ex::Dump qw(debug);
use CGI::Ex::Die register => 1;

sub table { die 'table not overridden in subclass' }
sub name_module { 'scribe/db' }

sub hash_base {
    my $self = shift;
    my $hash = $self->SUPER::hash_base(@_);
    $hash->{'app_title'} .= 'DB';
    return $hash;
}

###---------------------------------------------------------------###
# main step

sub main_hash_swap {
    my $self  = shift;
    my $hash  = $self->SUPER::main_hash_swap(@_);
    my $table = $self->table;
    $hash->{'section'} = $self->table2pkg($table, ' ');
    return $hash;
}

###---------------------------------------------------------------###
# add step

sub add_hash_swap {
    my $self  = shift;
    my $table = $self->table;

    my $schema = $self->can('schema') ? $self->schema : schmea();
    my $pkg    = $self->table2pkg($table);
    my @cols;
    foreach my $col ($schema->source($pkg)->columns) {
        next if $col eq $table.'_id';
        push @cols, $col;
    }

    my $theme_path = $self->theme_path;
    return {
        css_step => "$theme_path/$table.css",
        section  => $self->table2pkg($table, ' ').' - Add',
        css_crud => "$theme_path/add.css",
        columns  => \@cols,
    }
}

sub add_hash_validation {
    my $self = shift;
    # TODO: Create validation here
    return { }
}

sub add_finalize {
    my $self  = shift;
    my $table = $self->table;
    my $form  = shift || $self->form;

    my %args;
    my $schema = $self->schema;
    my $pkg    = $self->table2pkg($table);
    foreach my $col ($schema->source($pkg)->columns) {
        my $value = $form->{$col};
        next unless defined $value;
        $args{$col} = $value;
    }
    $schema->resultset($pkg)->create(\%args);

    my $hash = {
        success => 1, #TODO place holder for now.
        error   => '', #errors go here
    };

    # TODO figure out and code below on what gets returned here
    $self->add_to_form($hash);
    my $c = $self->config;
    $self->cgix->location_bounce('http://'.$c->server_url.'/'.$c->app_dirname.'cgi/scribe/list');
    return 0;
}

###---------------------------------------------------------------###
# delete step

sub delete_hash_swap {
    my $self  = shift;
    my $table = $self->table;

    my $schema = $self->can('schema') ? $self->schema : schmea();
    my $pkg    = $self->table2pkg($table);
    my @cols   = $schema->source($pkg)->columns;

    my $theme_path = $self->theme_path;
    return {
        css_step => "$theme_path/$table.css",
        css_crud => "$theme_path/delete.css",
        section  => $self->table2pkg($table, ' ').' - Delete',
        columns  => \@cols,
    }
}

sub delete_hash_validation {
    my $self = shift;
    # TODO: Create validation here
    return { }
}

sub delete_finalize {
    my $self  = shift;
    my $table = $self->table;
    my $id = $table.'_id';
    my $form = $self->form;
    my $pkg  = $self->table2pkg($table);
    $self->schema->resultset($pkg)->find({ $id => $form->{$id} })->delete;
    my $hash = {
        success => 1, #TODO place holder for now.
        error   => '', #errors go here
    };

    # TODO figure out and code below on what gets returned here
    $self->add_to_form($hash);
    my $c = $self->config;
    $self->cgix->location_bounce('http://'.$c->server_url.'/'.$c->app_dirname.'cgi/scribe/list');
    return 0;
}

###---------------------------------------------------------------###
# list step

sub list_hash_validation {
    my $self = shift;
    # TODO: Create validation here
    return { }
}

sub list_hash_swap {
    my $self   = shift;
    my $table  = $self->table;
    my $schema = $self->can('schema') ? $self->schema : schmea();
    my $pkg    = $self->table2pkg($table);
    my $result = $schema->resultset($pkg)->search();
    my @cols   = $schema->source($pkg)->columns;
    my @rows;
    while (my $row = $result->next) {
        my @data;
        foreach my $col (@cols) { push @data, $row->$col }
        push @rows, \@data;
    }

    my $theme_path = $self->theme_path;
    return {
        css_step => "$theme_path/$table.css",
        css_crud => "$theme_path/list.css",
        rows     => \@rows,
        columns  => \@cols,
        section  => $self->table2pkg($table, ' ').' - List',
    }
}

###---------------------------------------------------------------###
# update step

sub update_hash_swap {
    my $self  = shift;
    my $table = $self->table;
    my $theme_path = $self->theme_path;
    return {
        css_step => "$theme_path/$table.css",
        css_crud => "$theme_path/list.css",
        section  => $self->table2pkg($table, ' ').' - Update',
    }
}

sub update_hash_validation {
    my $self = shift;
    # TODO: Create validation here
    return { }
}

sub update_finalize {
    my $self = shift;
    my $table = $self->table;
    my $id = $table.'_id';
    my $form = $self->form;
    die 'TODO: step not yet implemented'; # TODO
    my $pkg = $self->table2pkg($table);
    $self->schema->resultset($pkg)->find({ $id => $form->{$id} })->update;
    my $hash = {
        success => 1, #TODO place holder for now.
        error   => '', #errors go here
    };

    # TODO figure out and code below on what gets returned here
    $self->add_to_form($hash);
    my $c = $self->config;
    $self->cgix->location_bounce('http://'.$c->server_url.'/'.$c->app_dirname.'cgi/scribe/list');
    return 0;
}


1;