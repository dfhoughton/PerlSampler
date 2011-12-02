#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use Data::Dumper;

## PARSER

my $xml_parser;
{
    use Regexp::Grammars;
    $xml_parser = qr{
   
   \A <root=element> \Z
   
   <rule: element>
      \< <tag=identifier> <[attributes=attribute]>* (*PRUNE)
      (?:
         >
         (?: <[children=element]>+ | <text> )? (*PRUNE)
         \</ <_end_tag=identifier> > (*PRUNE)
         (?: 
            <require:(?{ $MATCH{_end_tag} eq $MATCH{tag} }) >
            | 
            <error: unbalanced tags>
         )
         |
         /> (*PRUNE)
      )
   
   <token: identifier>
      \w++ (?: : \w++ )*+ (*PRUNE)
   
   <rule: attribute>
      <name=identifier> = <value> (*PRUNE)
   
   <token: value>
      (?:
         ' ((?: [^'\\] | \\. )*+) '
         | 
         " ((?: [^"\\] | \\. )*+) "
      )
      (*PRUNE)
      <MATCH= (?{$CAPTURE}) >
   
   <token: text>
      [^<>]++
   }xms;
}

## TEST THIS ALL OUT

my $xml = q{
<e>
   <a/>
   <a att="val\""><b/></a>
   <c att="val" other_att="hal">text</c>
</e>
};

# a little result beautification code
sub clean {
    my $m    = shift;
    my $type = ref $m;
    return unless $type;
    if ( $type eq 'HASH' ) {
        delete $m->{''};
        clean($_) for values %$m;
    }
    elsif ( $type eq 'ARRAY' ) {
        clean($_) for @$m;
    }
}

if ( $xml =~ $xml_parser ) {
    my %result = %/;    # %/ is magic match variable
    clean( \%result );
    print Dumper( \%result );
}
else {
    say "no match";
    say $_ for @!;
}
