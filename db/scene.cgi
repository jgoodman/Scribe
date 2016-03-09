#!/usr/bin/perl

use strict;
use warnings;

eval { use cPanelUserConfig };

use base qw(Scribe::App::DB);
use CGI::Ex::Die register => 1;
use CGI::Ex::Dump qw(debug);

__PACKAGE__->navigate;

sub table { 'scene' }
