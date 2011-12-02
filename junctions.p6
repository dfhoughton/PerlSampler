#! perl6
use v6;

my @ar = <bar baz qux foo>;
my $any = any( @ar );
say 'any: ', $any;
my $all = all( @ar );
say 'all: ', $all;
say sprintf "'foo' eq any: %s", ( 'foo' eq $any ?? 'true' !! 'false' );
say sprintf "'foo' eq all: %s", ( 'foo' eq $all ?? 'true' !! 'false' );
say '';

my $funky_any = any( $any, $all );
say 'funy any: ', $funky_any;
my $funky_all = all( $any, $all );
say 'funky all: ', $funky_all;
say sprintf "'foo' eq funky any: %s", ( 'foo' eq $funky_any ?? 'true' !! 'false' );
say sprintf "'foo' eq funky all: %s", ( 'foo' eq $funky_all ?? 'true' !! 'false' );
say '';

$any = any( 1 .. 10 );
say 'any: ', $any;
$all = all( 1 .. 10 );
say 'all: ', $all;
say sprintf "5 < any: %s", ( 5 < $any ?? 'true' !! 'false' );
say sprintf "5 < all: %s", ( 5 < $all ?? 'true' !! 'false' );
say '';

 $funky_any = any( $any, $all );
say 'funky any: ', $funky_any;
 $funky_all = all( $any, $all );
say 'funky all: ', $funky_all;
say sprintf "5 < funky any: %s", ( 5 < $funky_any ?? 'true' !! 'false' );
say sprintf "5 < funky all: %s", ( 5 < $funky_all ?? 'true' !! 'false' );
say '';

my $bar = sub ($n) { $n % 2 };
my $baz = sub ($n) { $n < 2 };
my $qux = sub ($n) { $n**2 < 2 };
my $foo = sub ($n) { $n - 1 };

$any = any( $bar, $baz, $qux, $foo );
$all = all( $bar, $baz, $qux, $foo );

my $val = 1;
say $val;
say sprintf "any test: %s",  ( $any($val) ?? 'true' !! 'false' );
say sprintf "all tests: %s", ( $all($val) ?? 'true' !! 'false' );
say '';

$val = any( 1, 2 );
say $val;
say sprintf "any test: %s",  ( $any($val) ?? 'true' !! 'false' );
say sprintf "all tests: %s", ( $all($val) ?? 'true' !! 'false' );

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
