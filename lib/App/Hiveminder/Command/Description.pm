#!/usr/bin/perl
package App::Hiveminder::Command::Description;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Description - Get the description of tasks

=cut

sub command_names { qw/description get-description get_description/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my @tasks = $self->hm->get_tasks(%{ parse_args @_ });

    my $ret = '';
    for my $task (@tasks) {
        my $display = display_tasks($self->hm, $task);
        $ret .= "Description for $display:\n";
        $ret .= $task->{description} . "\n" if $task->{description};
    }

    return $ret;
}

__PACKAGE__->meta()->make_immutable();
1;
