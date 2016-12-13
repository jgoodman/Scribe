package Scribe::UpgradeDB;

use strict;
use warnings;

use FindBin;

use Getopt::Long;
use Pod::Usage;

use DBIx::Class::DeploymentHandler;

use Scribe::Schema;
use Scribe::_Config;

sub from_version {
    my $self = shift;
    return $self->{'from_version'} ||= do {
        # expected format of script name: 01_to_02.pl
        my $script = $0;

    };
}

sub _set_versions {
    my $self = shift;
}

sub new {
    my $class = shift;
    my $self  = shift || { };
    bless $self, $class;
}

sub upgrade {
    my $self = shift;


    my $c = 'Scribe::_Config';
    my $dsn = 'dbi:Pg:database='.$c->dbname.';host='.$c->dbhost.';port=5432';
    my $s = Scribe::Schema->connect($dsn, $c->dbuser, $c->dbpass);
     
    my $dh = DBIx::Class::DeploymentHandler->new({
      schema              => $s,
      databases           => 'PostgreSQL',
      script_directory    => "$FindBin::Bin/../../dbicdh",
      sql_translator_args => { add_drop_table => 0 },
    });
     
    $dh->prepare_deploy;
    $dh->prepare_upgrade({
      from_version => 1,
      to_version   => 2,
    });
     
    $dh->upgrade;
}

1;
