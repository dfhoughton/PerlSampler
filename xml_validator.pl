#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

my @stack;
my $xmlParser = qr{
    
    \A \s*+ (?&element) \s*+ \Z

	      (?(DEFINE)
       (?<element>
          < \s*+ ((?&identifier)) \s*+ (?> (?&attribute) \s*+ )*+ 
          (?>
             > \s*+ (*PRUNE)
             (?{ push @stack, $^N }) 
             (?> (?>(?&element) \s*+)++ | (?&text) )?+ (*PRUNE)
             </ \s*+ ((?&identifier))
             (?(?{ $^N ne pop @stack })(*FAIL))
             \s*+ >
             |
             />
          ) (*PRUNE)
       )
       
       (?<tag_details>
          (?&identifier) \s*+ (?> (?&attribute) \s*+ )*+
       )
       
       (?<identifier>
          \w++ (?> : \w++ )*+
       )
       
       (?<attribute>
          (?&identifier) \s*+ = \s*+ (?&value)
       )
       
       (?<value>
          (?> 
             ' (?> [^'\\] | \\. )*+  '
             | 
             " (?> [^"\\] | \\. )*+ "
          )
       )
       
       (?<text>
          [^<>]++
       )
    )
   }xms;

## TEST THIS ALL OUT

my $xml = q{
<e>
   <a/>
   <a att="val\""><b/></a>
   <c att="val" other_att="hal">text</c>
</e>
};

say $xml =~ $xmlParser ? 'matched' : "didn't match";
