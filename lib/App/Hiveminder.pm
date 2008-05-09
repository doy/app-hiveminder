#!/usr/bin/perl
package App::Hiveminder;
use Moose;
extends 'MooseX::App::Cmd';

__PACKAGE__->meta()->make_immutable();
1;
