# CPU Hog

## Introduction

The CPU Hog application is intended to be a simple application useful for generating
CPU and memory load in order to force autoscaling events.

## Prerequisites

CPU Hog was tested on Ruby 2.5. Though significant backwards and forwards
compatibility is likely, it is not guaranteed.

The following Ruby gems are required to run the application. Versions
given are the tested versions and are not necessarily hard requirements:

* `gmp` - 0.7.43
* `sinatra` - 2.0.5

## Usage

1. Modify `config.json` to reflect values of interest to you.
2. Run `ruby main.rb` to start the web server
3. Make web calls against the url of the server on port 4567

`test.sh` provides a sane example of a load generation script that can
effectively drive load on the application.

### Config File
`config.json` can be used to set an arbitrary version number and message.
This is useful for setting off automatic deployments if you have such
a process in place.

Currently, the only setting in `config.json` that has a practical
impact on the application itself is `number_of_digits`. This
sets the number of digits of Pi for the application to calculate.
Since this application is single-threaded, the primary practical impact
of changing this value is how much memory the application will consume.

Table showing approximate Memory usage based on number of digits with
16 concurrent threads:

|Digits | Mem Consumption|
|-----|-----|
|1000 |370MB|
|1500 |450MB|
|2500 |2.5GB|

### Testing recommendations
For stability purposes, it is recommended not to use more than 32
concurrent threads. 64 simultaneous threads have been used,
but some instability at these levels has been observed with large
numbers of simultaneous threads.

## Shoutouts

### Aaron Tavistock and The Computer Language Benchmarks Game

Most of the code from pidigits.rb comes from a snippet submitted
by Aaron Tavistock to The Computer Language Benchmarks Game.

Ths code was modified into a class format and configured to
output data in a friendly format for consumption by other
programs.

The original code from this is preserved in pidigits.orig.rb

Link to benchmark game:
https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

Link to snippet contribution:
https://benchmarksgame-team.pages.debian.net/benchmarksgame/program/pidigits-yarv-5.html