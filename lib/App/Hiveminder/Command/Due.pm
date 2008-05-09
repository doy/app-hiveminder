#!/usr/bin/perl
package App::Hiveminder::Command::Due;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Due - Set the due date for tasks

=cut

sub command_names { qw/due date/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $due = pop;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (due => $due) }) });
}

__PACKAGE__->meta()->make_immutable();
1;
