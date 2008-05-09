#!/usr/bin/perl
package App::Hiveminder::Command::Untag;
use Moose;
use App::Hiveminder::Utils qw/update_tasks parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Untag - Remove a tag from tasks

=cut

sub command_names { qw/untag/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $tag = pop;
    return display_tasks($self->hm,
        @{ update_tasks($self->hm, parse_args(@_),
                        sub { my $tags = shift->{tags};
                              $tags =~ s/\Q\"$tag\"//;
                              (tags => $tags) }) });
}

1;
