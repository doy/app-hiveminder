#!/usr/bin/perl
package App::Hiveminder::Command::WontComplete;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::WontComplete - Mark tasks as to never be completed

=cut

sub command_names { qw/wont-complete wont_complete wont-do wont_do/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (will_complete => 0) }) });
}

__PACKAGE__->meta()->make_immutable();
1;
