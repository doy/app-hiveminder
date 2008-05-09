#!/usr/bin/perl
package App::Hiveminder::Command::Describe;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor_or_cmdline update_tasks
                              display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Describe - Add a description to a task

=cut

sub command_names { qw/describe add-description add_description/ }

sub command {
    my $self = shift;

    return unless @_ > 1;
    my $task = $self->hm->read_task(shift);
    my $description = get_text_from_editor_or_cmdline(@_);
    chomp $description;
    $task = update_tasks($self->hm, [$self->hm->id2loc($task->{id})],
                         sub { (description => $description) })->[0];
    my $display = display_tasks($self->hm, $task);
    return "Description for $display:\n$task->{description}\n";
}

__PACKAGE__->meta()->make_immutable();
1;
