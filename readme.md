Oyster Card Challenge
=================

Overview
---------

This repo recreates the functionality of London's Oyster Card system in Object-Oriented Ruby. This was our Week 2 challenge at Makers Academy, and was principally an exercise in Object Oriented Development (OOP) and Test-Driven Development (TDD).

Features
---------

The software is run through the terminal and the following features are implemented:

* Oyster cards and Stations can be created, and are contained within their own classes (`OysterCard` and `Station` respectively).
* Use `top_up()` to add money to your card.
* You can `touch_in()` or `touch_out()` your oyster card at a station by adding the station name as an argument.
* A fare will be deducted for a successful touch in and out.
* A penalty fare is deducted for a double touch in or out (and for a double touch_in, you can continue your journey from the last touched in station)
* Exceptions are raised on `touch_in` if your card does not have the minimum fare, or if you attempt to top up with more than the maximum card capacity.
* A log of all your journeys is stored in journey objects within an accessible `history` variable on each card. This contains a `CardHistory` object which itself has a `total` number of journey and a `record`, which is an accessible array of `Journey` objects, containing attributes which store the `entry_station`, `end_station`, an `in_progress` marker, the `fare` and a `penalty` if deducted.

Installation and running
---------

The Oyster card system requires Ruby 2.5.0, as well as the bundle gemfile installer (to install bundle run `gem install bundler`)

1. Download the repo to your computer.
2. Open a terminal in the repo root and run `bundle install`
3. Bundle should install all the dependent gemfiles for the software to run.
4. In the root folder run `irb -r './lib/oyster_card.rb'`

Testing framework
---------

Running `rspec` in the root directory will run the tests written alongside development of the software.


Further features
---------

Each instance of the `Station` class holds a variable to store the zone of that station. The `fare` method in the journey class does not yet take this into account when calculating the fare, so could be usefully linked up.


Coding experience
---------

As an object-oriented project I was particularly concerned to encapsulate the correct methods and behaviour within the appropriate classes, and as code developed, to extract classes where necessary (such as for the `Journey` and `CardHistory` classes). It was also an important exercise in assessing the visibility of public and private methods and the accessibility of variables to ensure appropriate scoping.

It was instructive to drive development through reading user stories. Using these to inform feature tests in IRB and unit tests in RSpec meant that the code was shaped by the most important aspects of user behaviour. I was also keen to write all unit tests in advance of writing code and to follow the red-green-refactor process. I was also able to raise exceptions and properly test these exceptions.


Acknowledgements
---------

I worked on this code with a number of different pairs over the course of this week, and must acknowledge in particular the input of Jihin Ip, Andrew Kemp, and Irbe Krumina.
