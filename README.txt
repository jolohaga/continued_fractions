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
  
  real = Math::PI
  => 3.14159265358979
  
  cf = ContinuedFraction.new(real,10)
  => #<ContinuedFractions::ContinuedFraction:0x00000101101368 @number=3.14159265358979, @limit=10,
          @quotients=[3, 7, 15, 1, 292, 1, 1, 1, 2, 1],
          @convergents=[[0, 1], [1, 0], [3, 1], [22, 7], [333, 106],
                        [355, 113], [103993, 33102], [104348, 33215], [208341, 66317], [312689, 99532], [833719, 265381], [1146408, 364913]]>
                       
  cf.convergents
  => [[3,1], [22,7], [333,106], [355,113], [103993,33102], [104348,33215], [208341,66317], [312689,99532], [833719,265381], [1146408,364913]]
  
  cf.convergent(1)
  => [22,7]
  
  cf.quotients
  => [3, 7, 15, 1, 292, 1, 1, 1, 2, 1]

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
  