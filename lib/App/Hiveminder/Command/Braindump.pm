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
    my $self = shift;

    my $text = get_text_from_editor;
    return display_tasks($self->hm,
                         $self->hm->braindump($text, returns => 'tasks',
                                                     tokens  => [@_]))
        unless $text eq '';
    return '';
}

1;
