#! perl6
use v6;

# we define some roles

role Named {
  has Str $.name is rw;
}

role Greeting[Str $greeting] {
   method greet {
      say $greeting.ucfirst 
         ~ "! I'm "
         ~ ( defined $.name ?? $.name !! 'nameless' )
         ~ '!';
   }
}

role Curse[Str $expletive = '@#$%@#'] {
   method curse () { say $expletive.ucfirst ~ '!!!' }
}

role KeepAccount[Numeric $baseline = 0] does Named {
   has Numeric $!account = $baseline;
   method report () { say "$.name has $!account bars of latinum" }
   method paid(Numeric $amt) {
      say "$.name is paid $amt";
      $!account += $amt;
   }
   method pays(Numeric $amt where { $amt <= $!account }) {
      say "$.name pays $amt";
      $!account -= $amt;
      $.curse if $!account < 20;
   }
}

# we do some class and role composition stuff

class Person 
   does Named 
   does Curse { }
class Czech 
   is Person 
   does Greeting['ahoj'] 
   does KeepAccount { }
class Finn 
   is Person 
   does Greeting['hei'] 
   does KeepAccount[100] 
   does Curse['perkele'] { }

# we test it all out

my Czech $milan = Czech.new( name => 'Milan' );
$milan.greet();
my Finn $merja = Finn.new( name => 'Merja' );
$merja.greet();

$merja.report;
$merja.pays(10);

# exception handling syntactic sugar!
$milan.report;
try {
   $milan.pays(10);
   CATCH {
      # is this the exception we were expecting?
      # (yes, if you're expecting it, it should be an exception)
      when /type\ check\ failed/ { say 'busted!' }
      default                    { say 'well, I didn\'t see that coming!' }
   }
}

$milan.report;
$milan.paid(20);
$milan.report;
$milan.pays(20);
$merja.report;
$merja.pays(90);
