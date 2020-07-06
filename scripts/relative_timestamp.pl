#!/usr/bin/perl

use Time::HiRes qw/tv_interval gettimeofday/;
use Term::ANSIColor qw(:constants);
use Statistics::Basic qw/stddev average/;

my $td = 0;

BEGIN {
    @lastcmdtime = gettimeofday();
    @cmdtime = gettimeofday();
    @deltas = [1];
}

@cmdtime = gettimeofday();

$td = tv_interval(\@lastcmdtime);

$avg = average(@deltas);
$stddev = stddev(@deltas);
push(@deltas, $td);


$tddev = abs($avg - $td);

if ($tddev < $avg) {
    print BRIGHT_GREEN
} elsif ($tddev <= $stddev) {
    print GREEN
} elsif ($tddev <= $stddev * 2) {
    print YELLOW
} elsif ($tddev <= $stddev * 4) {
    print RED
} elsif ($tddev > $stddev * 4) {
    print BRIGHT_RED
}

printf "%04.6f: ", $td;
print RESET;

@lastcmdtime = @cmdtime;
