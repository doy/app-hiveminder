#!/usr/bin/perl
package App::Hiveminder::Command::Accept;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Accept - Accept open tasks

=cut

sub command_names { qw/accept take/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (accepted => 1) }) });
}

__PACKAGE__->meta()->make_immutable();
1;
