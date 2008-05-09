#!/usr/bin/perl
package App::Hiveminder::Command::List;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::List - List tasks

=cut

sub command_names { qw/list ls find/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    return display_tasks($self->hm,
                         $self->hm->get_tasks(%{ parse_args @_ }));
}

1;
