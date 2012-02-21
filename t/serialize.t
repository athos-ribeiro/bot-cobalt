use 5.12.1;
use Test::More tests => 7;

## Test JSON, YAML (Cobalt::Serializer)

BEGIN {
  use_ok( 'Cobalt::Serializer' );
}

my $hash = {
  Scalar => "A string",
  Int => 3,
  Array => [ "Item", "Another" ],
};

JSON: {
  my $js_ser = Cobalt::Serializer->new( 'JSON' );
  my $json = $js_ser->freeze($hash);
  ok( $json, 'JSON freeze');

  my $json_thawed = $js_ser->thaw($json);
  ok( $json_thawed, 'JSON thawed');

  is_deeply($hash, $json_thawed, 'JSON comparison' );
}

YAML: {
  my $yml_ser = Cobalt::Serializer->new();
  my $yml = $yml_ser->freeze($hash);
  ok( $yml, 'YAML freeze');

  my $yml_thawed = $yml_ser->thaw($yml);
  ok( $yml_thawed, 'YAML thawed');

  is_deeply($hash, $yml_thawed, 'YAML comparison' );
}