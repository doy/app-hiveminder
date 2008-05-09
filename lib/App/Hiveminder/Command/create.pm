#!/usr/bin/perl
package App::Hiveminder::Command::create;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor_or_cmdline display_tasks
                              update_tasks/;
extends 'App::Hiveminder::Base';

sub run {
    my ($self, $opt, $args) = @_;
    print "Running create...\n";
    print "$_\n" for @$args;
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

    print $ret, "\n";
}

1;
