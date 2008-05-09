#!/usr/bin/perl
package App::Hiveminder::Command::Give;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Give - Offer tasks to other people

=cut

sub command_names { qw/give offer/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $email = pop;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (owner_id => $email) }) });
}

__PACKAGE__->meta()->make_immutable();
1;
