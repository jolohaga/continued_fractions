# ContinuedFractions

* http://rubygems.org/gems/continued_fractions

## Description

Generates quotients and convergents for a given number.

## Synopsis

    require 'continued_fractions'
  
    pi = Math::PI
    => 3.14159265358979
    
    cf = ContinuedFraction.new(pi,10)
    => 3.141592653589793, quotients: [3, 7, 15, 1, 292, 1, 1, 1, 2, 1], convergents: [(3/1), (22/7), (333/106), (355/113), (103993/33102), (104348/33215), (208341/66317), (312689/99532), (833719/265381), (1146408/364913)]
                         
    cf.convergents
    => [(3/1), (22/7), (333/106), (355/113), (103993/33102), (104348/33215), (208341/66317), (312689/99532), (833719/265381), (1146408/364913)]

    cf.convergent(1)
    => (22/7)
    
    cf.quotients
    => [3, 7, 15, 1, 292, 1, 1, 1, 2, 1]
    
    # Add, subtract, multiply and divide continued fractions.  The limit of the result is the max limit of the operands.
    cf2 = ContinuedFraction.new(rand,20)
    => 0.9465929215086878, quotients: [0, 1, 17, 1, 2, 1, 1, 1, 1, 1, 41, 1, 1, 2, 22, 1, 1, 11, 1, 3], convergents: [(0/1), (1/1), (17/18), (18/19), (53/56), (71/75), (124/131), (195/206), (319/337), (514/543), (21393/22600), (21907/23143), (43300/45743), (108507/114629), (2430454/2567581), (2538961/2682210), (4969415/5249791), (57202526/60429911), (62171941/65679702), (243718349/257469017)]
    cf + cf2
    => 4.088185575098481, quotients: [4, 11, 2, 1, 16, 1, 2, 1, 1, 1, 1, 25, 7, 1, 3, 1, 3], convergents: [(4/1), (45/11), (94/23), (139/34), (2318/567), (2457/601), (7232/1769), (9689/2370), (16921/4139), (26610/6509), (43531/10648), (1114885/272709), (7847726/1919611), (8962611/2192320), (34735559/8496571), (43698170/10688891), (165830069/40563244)]

## Install

sudo gem install continued_fractions

## Requirements/Dependencies

* Ruby 3.1+
* Depends on Ruby's Rational class

## Developers

* RSpec required to run tests
* Yard to compile documentation

## Contributors

* [Jose Hales-Garcia](https://github.com/jolohaga)