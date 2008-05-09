#!/usr/bin/perl
package App::Hiveminder::Command::Delete;
use Moose;
use App::Hiveminder::Utils qw/display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Delete - Delete a task by locator

=cut

sub command_names { qw/delete rm del/ }

sub command {
    my $self = shift;
    # XXX: offer an interactive mode here, possibly
    my $ret = '';
    for my $locator (@_) {
        my $desc = display_tasks($self->hm->read_task($locator));
        $ret .= "Deleted $desc\n";
        eval { $self->hm->delete('Task', id => $self->hm->loc2id($locator)) };
        warn $@ unless $@ =~ /404 Not Found/;
    }
    chomp $ret;
    return $ret;
}

__PACKAGE__->meta()->make_immutable();
1;
