#!/usr/bin/perl
package App::Hiveminder::Command::Todo;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Todo - Display the current todo list

=cut

sub command {
    my ($self, $args) = @_;
    my %args = %{ parse_args @$args };
    $args{complete_not} = 0 if exists $args{complete} &&
                               $args{complete} == 1 &&
                               !exists $args{complete_not};
    $args{accepted_not} = 0 if exists $args{accepted} &&
                               $args{accepted} == 1 &&
                               !exists $args{accepted_not};
    $args{owner} = '' if exists $args{owner_not} && $args{owner_not} ne '';
    # XXX: fix for 'starts_before' and 'depends_on_count'
    return display_tasks($self->hm, $self->hm->todo_tasks(%args));
}

1;
