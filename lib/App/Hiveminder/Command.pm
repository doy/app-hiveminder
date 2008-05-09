#!/usr/bin/perl
package App::Hiveminder::Command;
use Moose;
use Net::Hiveminder;
extends 'MooseX::App::Cmd::Command';

has hm => (
    isa     => 'Net::Hiveminder',
    is      => 'ro',
    default => sub { Net::Hiveminder->new(use_config => 1) },
);

1;
