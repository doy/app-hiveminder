#!/usr/bin/perl
package App::Hiveminder::Command::Comments;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Comments - Display the comments on tasks

=cut

sub command_names { qw/comments get-comments get_comments/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my $ret;
    my @tasks = $self->hm->get_tasks(%{ parse_args @_ });
    for my $task (@tasks) {
        my $desc = display_tasks($self->hm, $task);
        $ret .= "Comments for: $desc\n";
        $ret .= join "\n", ($self->hm->comments_on($task));
    }
    return $ret;
}

__PACKAGE__->meta()->make_immutable();
1;
