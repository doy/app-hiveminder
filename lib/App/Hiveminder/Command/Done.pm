#!/usr/bin/perl
package App::Hiveminder::Command::Done;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Done - Mark tasks as being completed

=cut

sub command_names { qw/done complete d do/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my @tasks = $self->hm->get_tasks(%{ parse_args @_ });
    $self->hm->done(@tasks);
    map { $_->{complete} = 1 } @tasks;
    return display_tasks($self->hm, @tasks);
}

1;
