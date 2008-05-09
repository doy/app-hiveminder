#!/usr/bin/perl
package App::Hiveminder::Command::Starts;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Starts - Hide tasks until a certain date

=cut

sub command_names { qw/starts/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $starts = pop;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (starts => $starts) }) });
}

__PACKAGE__->meta()->make_immutable();
1;
