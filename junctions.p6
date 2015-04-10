#! perl6
use v6;

my @ar = <bar baz qux foo>;
my $any = any( @ar );
my $all = all( @ar );
say "'foo' eq $any: {'foo' ~~ $any}";
say "'foo' eq $all: {'foo' ~~ $all}\n";

my $funky_any = any( $any, $all );
say 'funy any: ', $funky_any;
my $funky_all = all( $any, $all );
say 'funky all: ', $funky_all;
say "'foo' eq $funky_any: { 'foo' ~~ $funky_any }";
say "'foo' eq $funky_all: { 'foo' ~~ $funky_all }\n";

$any = any( 1 .. 10 );
$all = all( 1 .. 10 );
say "5 < $any: { !!( 5 < $any ) }";
say "5 < $all: { !!( 5 < $all ) }\n";

$funky_any = any( $any, $all );
$funky_all = all( $any, $all );
say "5 < $funky_any: { !!( 5 < $funky_any ) }";
say "5 < $funky_all: { !!( 5 < $funky_all ) }\n";

my $bar = sub ($n) { $n % 2 };
my $baz = sub ($n) { $n < 2 };
my $qux = sub ($n) { $n**2 < 2 };
my $foo = sub ($n) { $n - 1 };

$any = any( $bar, $baz, $qux, $foo );
$all = all( $bar, $baz, $qux, $foo );

my $val = 1;
say $val;
say sprintf "$any test: { !!$any($val) }";
say sprintf "$all tests: { !!$all($val) }\n";

$val = any( 1, 2 );
say $val;
say sprintf "$any test: { !!$any($val) }";
say sprintf "$all tests: { !!$all($val) }\n";

say "\nsugar!";
$val = 1|2;
say "1|2 => $val";
$val = 1&2;
say "1&2 => $val";

say "\nmore junction types!";
$val = 1^2;
say "1^2 => $val";
$val = one( 1 .. 10 );
say "one( 1 .. 10 ) => $val";
$val = none( 1 .. 10 );
say "none( 1 .. 10 ) => $val";
