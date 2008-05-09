#!/usr/bin/perl
package App::Hiveminder::Command::Tag;
use Moose;
use App::Hiveminder::Utils qw/update_tasks parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Tag - Add a tag to tasks

=cut

sub command_names { qw/tag/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $tag = pop;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { (tags => shift->{tags} . " \"$tag\"") }) });
}

1;
