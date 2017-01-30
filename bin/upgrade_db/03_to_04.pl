use strict;
use warnings;

use FindBin;

use Getopt::Long;
use Pod::Usage;

use DBIx::Class::DeploymentHandler;

use Scribe::Schema;
use Scribe::_Config;

my $c = 'Scribe::_Config';
my $s = Scribe::Schema->connect('dbi:Pg:database='.$c->dbname.';host='.$c->dbhost.';port=5432', $c->dbuser, $c->dbpass);

my $dh = DBIx::Class::DeploymentHandler->new({
  schema              => $s,
  databases           => 'PostgreSQL',
  script_directory    => "$FindBin::Bin/../../dbicdh",
  sql_translator_args => { add_drop_table => 0 },
});

$dh->prepare_deploy;
$dh->prepare_upgrade({
  from_version => 3,
  to_version   => 4,
});

$dh->upgrade;
