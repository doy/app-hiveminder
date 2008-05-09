#!/usr/bin/perl
package App::Hiveminder::Command::Priority;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks
                              update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Priority - Set the priority of tasks

=cut

sub command_names { qw/priority pri/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $priority = pop;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (priority => $priority) }) });
}

__PACKAGE__->meta()->make_immutable();
1;
