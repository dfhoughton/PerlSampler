#!/usr/bin/perl

use common::sense;
use Quantum::Superpositions;

my @ar  = qw(bar baz qux foo);
my $any = any(@ar);
say 'any: ', $any;
my $all = all(@ar);
say 'all: ', $all;
printf "'foo' eq any: %s\n", ( 'foo' eq $any ? 'true' : 'false' );
printf "'foo' eq all: %s\n", ( 'foo' eq $all ? 'true' : 'false' );
say '';

my $funky_any = any( $any, $all );
say 'funy any: ', $funky_any;
my $funky_all = all( $any, $all );
say 'funky all: ', $funky_all;
printf "'foo' eq funky any: %s\n", ( 'foo' eq $funky_any ? 'true' : 'false' );
printf "'foo' eq funky all: %s\n", ( 'foo' eq $funky_all ? 'true' : 'false' );
say '';

$any = any( 1 .. 10 );
say 'any: ', $any;
$all = all( 1 .. 10 );
say 'all: ', $all;
printf "5 < any: %s\n", ( 5 < $any ? 'true' : 'false' );
printf "5 < all: %s\n", ( 5 < $all ? 'true' : 'false' );
say '';

$funky_any = any( $any, $all );
say 'funy any: ', $funky_any;
$funky_all = all( $any, $all );
say 'funky all: ', $funky_all;
printf "5 < funky any: %s\n", ( 5 < $funky_any ? 'true' : 'false' );
printf "5 < funky all: %s\n", ( 5 < $funky_all ? 'true' : 'false' );
say '';

my $bar = sub { $_[0] % 2 };
my $baz = sub { $_[0] < 2 };
my $qux = sub { $_[0]**2 < 2 };
my $foo = sub { $_[0] - 1 };

$any = any( $bar, $baz, $qux, $foo );
$all = all( $bar, $baz, $qux, $foo );

my $val = 1;
say $val;
printf "any test: %s\n",  ( $any->($val) ? 'true' : 'false' );
printf "all tests: %s\n", ( $all->($val) ? 'true' : 'false' );
say '';

$val = any( 1, 2 );
say $val;
printf "any test: %s\n",  ( $any->($val) ? 'true' : 'false' );
printf "all tests: %s\n", ( $all->($val) ? 'true' : 'false' );
