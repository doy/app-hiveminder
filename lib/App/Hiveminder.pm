#!/usr/bin/perl
package App::Hiveminder;
use Moose;
extends 'MooseX::App::Cmd';

use constant default_command => 'commands';

__PACKAGE__->meta()->make_immutable();
1;
