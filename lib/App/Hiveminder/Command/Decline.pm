#!/usr/bin/perl
package App::Hiveminder::Command::Decline;
use Moose;
use App::Hiveminder::Utils qw/parse_args display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Decline - Decline offered tasks

=cut

sub command_names { qw/decline/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my $ret = '';
    for my $task ($self->hm->get_tasks(%{ parse_args @_ })) {
        my $updated_task = $self->hm->update_task($task, accepted => 0);
        # we get a task hash with each field undef if it succeeds
        if (!defined $updated_task->{id}) {
            $ret .= "Declined " . display_tasks($self->hm, $task) . "\n";
        }
    }

    return $ret;
}

__PACKAGE__->meta()->make_immutable();
1;
