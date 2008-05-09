#!/usr/bin/perl
package App::Hiveminder::Command::Rename;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor_or_cmdline display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Rename - Change the summary of a task

=cut

sub command_names { qw/rename ren mv/ }

sub command {
    my $self = shift;
    my $locator = shift;
    my $task = $self->hm->read_task($locator);
    return "Invalid locator $locator" unless defined $task;
    my $text = get_text_from_editor_or_cmdline(@_);
    return display_tasks($self->hm,
                         $self->hm->update_task($locator, summary => $text));
}

1;
