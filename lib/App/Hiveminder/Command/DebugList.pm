#!/usr/bin/perl
package App::Hiveminder::Command::DebugList;
use Moose;
use App::Hiveminder::Utils qw/parse_args/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::DebugList - Display the raw result of listing tasks

=cut

sub command_names { qw/debug-list debug/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my $tasks = [$self->hm->get_tasks(%{ parse_args @_ })];
    require Data::Dump::Streamer;
    return Data::Dump::Streamer::Dump($tasks)->Out();
}

__PACKAGE__->meta()->make_immutable();
1;
