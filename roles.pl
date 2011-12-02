#!/usr/bin/perl

use common::sense;
use TryCatch;
use MooseX::Declare;

# we define some roles

role Name {
    has 'name' => ( isa => 'Str', is => 'ro' );
}

role Greeting(Str :$greeting ) {
    requires 'name';

      method greet {
        say ucfirst( $greeting ) 
          . "! I'm "
          . ( defined $self->name ? $self->name : 'nameless' ) . '!!!';
    }
}

role Curse(Str :$expletive = '@#$%@#' ) {
    method curse { say ucfirst( $expletive ) . '!!!' }
}

role KeepAccount(Num :$balance = 0 ) {
    requires 'name', 'curse';

    has 'account' => ( isa => 'Num', is => 'rw', default => $balance );

    method report {
        say $self->name . " has " . $self->account . " bars of latinum";
    }

    method paid(Num $amt) {
        say $self->name . " is paid $amt";
        $self->account( $self->account + $amt );
    }

     method pays(Num $amt) {
        die $self->name . " is short of funds"
          unless $amt <= $self->account;
        say $self->name . " pays $amt";
        $self->account( $self->account - $amt );
        $self->curse if $self->account < 20;
    }
}

# we do some class and role composition stuff

class Person {
    with 'Name';
    with 'Curse';
}

class Czech extends Person {
    with 'KeepAccount';
    with 'Greeting' => { greeting => "ahoj" };
}

class Finn extends Person {
    with 'Greeting' => { greeting => "hei" };
    with 'KeepAccount' => { balance => 100 };
    with 'Curse' => { expletive => "perkele" };
}

# we test it all out

my $milan = Czech->new( name => 'Milan' );
$milan->greet;      # we don't need parentheses here
my $merja = Finn->new( name => 'Merja' );
$merja->greet();    # but they don't hurt

$merja->report;
$merja->pays(10.0);

# exception handling syntactic sugar!
$milan->report;
try {
    $milan->pays(10.0);
} catch($e) {
    say $e;
}

$milan->report;
$milan->paid(20.0);
$milan->report;
$milan->pays(20.0);
$merja->report;
$merja->pays(90.0);
