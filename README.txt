= ContinuedFractions

* http://rubygems.org/gems/continued_fractions

== Description:

Generates quotients and convergents for a given number.

== Features/Problems:

* Requires Ruby 1.9+
* Depends on Ruby 1.9's Rational class

== Synopsis:

  require 'continued_fractions'  
  include ContinuedFractions
  
  pi = Math::PI
  => 3.14159265358979
  
  cf = ContinuedFraction.new(pi,10)
  => #<ContinuedFractions::ContinuedFraction:0x00000101101368 @number=3.14159265358979, @limit=10,
          @quotients=[3, 7, 15, 1, 292, 1, 1, 1, 2, 1],
          @convergents=[[0, 1], [1, 0], [3, 1], [22, 7], [333, 106],
                        [355, 113], [103993, 33102], [104348, 33215], [208341, 66317], [312689, 99532], [833719, 265381], [1146408, 364913]]>
                       
  cf.convergents
  => [[3,1], [22,7], [333,106], [355,113], [103993,33102], [104348,33215], [208341,66317], [312689,99532], [833719,265381], [1146408,364913]]

  # Convergents are can be output as an array of Rationals too
  cf.convergents_as_rationals
  [(3/1), (22/7), (333/106), (355/113), (103993/33102), (104348/33215), (208341/66317), (312689/99532), (833719/265381), (1146408/364913)]
  
  cf.convergent(1)
  => [22,7]
  
  cf.quotients
  => [3, 7, 15, 1, 292, 1, 1, 1, 2, 1]
  
  # Add, subtract, multiply and divide continued fractions.  The limit of the result is the max limit of the operands.
  cf2 = ContinuedFraction.new(rand,20)
  => #<ContinuedFractions::ContinuedFraction:0x000001009dde50 @number=0.03834175394982653, @limit=20, @quotients=[0, 26, 12, 3, 4, 1, 2, 24, 5, 1, 1, 1, 2, 1, 2, 2, 1, 7, 1, 5], @convergents=[[0, 1], [1, 26], [12, 313], [37, 965], [160, 4173], [197, 5138], [554, 14449], [13493, 351914], [68019, 1774019], [81512, 2125933], [149531, 3899952], [231043, 6025885], [611617, 15951722], [842660, 21977607], [2296937, 59906936], [5436534, 141791479], [7733471, 201698415], [59570831, 1553680384], [67304302, 1755378799], [396092341, 10330574379]]>
  cf + cf2
  => #<ContinuedFractions::ContinuedFraction:0x000001009d2708 @number=3.1799344075396196, @limit=20, @quotients=[3, 5, 1, 1, 3, 1, 5, 3, 7, 25, 1, 2, 15, 6, 1, 1, 2, 3, 1, 2], @convergents=[[3, 1], [16, 5], [19, 6], [35, 11], [124, 39], [159, 50], [919, 289], [2916, 917], [21331, 6708], [536191, 168617], [557522, 175325], [1651235, 519267], [25326047, 7964330], [153607517, 48305247], [178933564, 56269577], [332541081, 104574824], [844015726, 265419225], [2864588259, 900832499], [3708603985, 1166251724], [10281796229, 3233335947]]>
  

== Requirements:

* Ruby 1.9+

== Install:

sudo gem install continued_fractions

== Developers:

* Ruby 1.9+
* RSpec required to run tests.
* Echoe required to run rake tasks.

== License:

  Copyright (c) 2010 Jose Hales-Garcia

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:
  
  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  