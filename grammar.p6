#! perl6
use v6;

grammar XML {
   regex TOP { ^ <.ws> <root=element> <.ws> $ }

   rule element { 
           \< (<tag=identifier>) <attribute>* 
           [
              \> [ <text> | <child=element>* ]? '</' $0 '>'
              |
              '/>'
           ]
        }
   token identifier { \w+ [ \: \w+ ]* }
   rule  attribute  { <name=identifier> \= <value> }
   token value      { \' <nonq> \' | \" <nonqq> \" }
   token text       { <-[<>]>+ }
   token nonq       { [ <.escape> | <-['\n]> ]* }
   token nonqq      { [ <.escape> | <-["\n]> ]* }
   token escape     { \\ . }
}

my $xml = q{
<e>
   <a/>
   <a att="val\""><b/></a>
   <c att="val" other_att="hal">text</c>
</e>
};

my $parse = XML.parse($xml);
if $parse {
   say 'matched';
} else {
   say 'invalid';
}
