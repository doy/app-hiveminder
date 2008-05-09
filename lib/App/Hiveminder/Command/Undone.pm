#!/usr/bin/perl
package App::Hiveminder::Command::Undone;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Undone - Mark tasks as not being completed

=cut

sub command_names { qw/undone undo/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (complete => 0) }) });
}

1;
