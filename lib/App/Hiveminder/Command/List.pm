#!/usr/bin/perl
package App::Hiveminder::Command::List;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::List - List tasks

=cut

sub command_names { qw/list ls/ }

sub command {
    my ($self, $args) = @_;

    return unless @_ > 0;
    return display_tasks($self->hm,
                         $self->hm->get_tasks(%{ parse_args @$args }));
}

1;
