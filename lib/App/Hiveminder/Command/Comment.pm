#!/usr/bin/perl
package App::Hiveminder::Command::Comment;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor_or_cmdline display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Comment - Add a comment to a task

=cut

sub command_names { qw/comment add-comment add_comment comment-on comment_on/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my $locator = shift;
    $self->hm->comment_on($self->hm->read_task($locator),
                          get_text_from_editor_or_cmdline(@_));
    my $task = $self->hm->read_task($locator);
    my $display = display_tasks($self->hm, $task);
    return "Comments for: $display\n" .
           (join "\n", $self->hm->comments_on($task));
}

__PACKAGE__->meta()->make_immutable();
1;
