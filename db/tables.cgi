#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw($Bin);

use cPanelUserConfig;

use base qw(Scribe::App);
use CGI::Ex::Die register => 1;
use CGI::Ex::Dump qw(debug);

__PACKAGE__->navigate;

sub name_module { 'scribe/db/tables' }

sub url { shift->SUPER::url.'/db' }

sub main_hash_swap {
    my $self = shift;
    my $hash = $self->SUPER::main_hash_swap;
    $hash->{'section'} = 'Tables';

    my @tables;
    opendir (my $DIR, $Bin) or die $!;
    while (my $file = readdir($DIR)) {
        next unless $file =~ m/^(\w+)\.cgi$/;
        my $table = $1;
        next if $table eq 'tables';
        push @tables, $table;
    }
    $hash->{'tables'} = [ sort @tables ];

    return $hash;
}