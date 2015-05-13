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

sub url {
    my $self = shift;
    return $self->SUPER::url.'/db/'.$self->table.'.cgi';
}

sub url_list { return shift->url . '/list' }

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

    my $url_theme = $self->url_theme;
    return {
        section  => $self->table2pkg($table, ' ').' - Add',
        css_crud => "$url_theme/add.css",
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
    my $form  = $self->form;

    my %args;
    my $schema = $self->schema;
    my $pkg    = $self->table2pkg($table);
    foreach my $col ($schema->source($pkg)->columns) {
        my $value = $form->{$col};
        next unless defined $value && $value ne '';
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
    $self->cgix->location_bounce($self->url_list);
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

    my $url_theme = $self->url_theme;
    return {
        css_crud => "$url_theme/delete.css",
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
    $self->cgix->location_bounce($self->url_list);
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

    my %attr;
    my $source = $schema->source($pkg);
    my ($primary_key) = $source->primary_columns;
    $attr{'order_by'} = "$primary_key" if $primary_key;

    my @rows;
    my $result = $schema->resultset($pkg)->search(undef, \%attr);
    my @cols   = $source->columns;
    while (my $row = $result->next) {
        my @data;
        foreach my $col (@cols) { push @data, $row->$col }
        push @rows, \@data;
    }

    my $url_theme = $self->url_theme;
    return {
        css_crud => "$url_theme/list.css",
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
    my $url_theme = $self->url_theme;
    return {
        css_crud => "$url_theme/list.css",
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
    $self->cgix->location_bounce($self->url_list);
    return 0;
}


1;
