#!/usr/bin/perl
package App::Hiveminder::Command::Braindump;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor display_tasks/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Braindump - Create several tasks at once

=cut

sub command_names { qw/braindump bd/ }

sub command {
    my ($self, $args) = @_;

    my $text = get_text_from_editor;
    return display_tasks($self->hm->braindump($text, returns => 'tasks',
                                                     tokens  => [@$args]))
        unless $text eq '';
    return '';
}

1;
