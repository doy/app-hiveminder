#!/usr/bin/perl
package App::Hiveminder::Command::Feedback;
use Moose;
use App::Hiveminder::Utils qw/get_text_from_editor_or_cmdline/;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Feedback - Give feedback to the Hiveminder team

=cut

sub command_names { qw/feedback/ }

sub command {
    my $self = shift;

    # XXX: no real way to test this...
    my $ret = $self->hm->act('SendFeedback', content =>
                             get_text_from_editor_or_cmdline(@_));

    return $ret->{message};
}

__PACKAGE__->meta()->make_immutable();
1;
