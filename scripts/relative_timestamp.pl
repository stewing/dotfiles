#!/usr/bin/perl

use Time::HiRes qw(tv_interval gettimeofday);

my $td = 0;

BEGIN {
    @lastcmdtime = gettimeofday();
    @cmdtime = gettimeofday();
}

@cmdtime = gettimeofday();

$td = tv_interval(\@lastcmdtime);

printf "%0.6f: ", $td;

@lastcmdtime = @cmdtime
