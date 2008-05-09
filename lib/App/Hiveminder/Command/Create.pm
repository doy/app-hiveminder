#!/usr/bin/perl
package App::Hiveminder::Command::Create;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor_or_cmdline display_tasks
                              update_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Create - Create a new task

=cut

sub command {
    my ($self, $args) = @_;
    $args = join " ", @$args;

    my $text = get_text_from_editor_or_cmdline($args);
    return '' if $text eq '';
    my @text = split "\n", $text;

    my $task = $self->hm->create_task(shift @text);
    my $ret = display_tasks($self->hm, $task);

    if (@text > 0) {
        $ret = display_tasks($self->hm,
            @{ update_tasks($self->hm, [$self->hm->id2loc($task->{id})],
                            sub { (description => (join "\n", @text)) }) });
    }

    return $ret;
}

__PACKAGE__->meta()->make_immutable();
1;
