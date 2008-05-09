#!/usr/bin/perl
package App::Hiveminder::Command::Download;
use Moose;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Download - Download tasks to a local text file

=cut

sub command_names { qw/download down dl/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    # XXX: need a way to translate parameters given on the command line to the
    #      url syntax
    my $filename = shift;
    $self->hm->download_file($filename, "/owner/me/not/complete/accepted/starts/before/tomorrow/but_first/nothing");
    return $filename;
}

__PACKAGE__->meta()->make_immutable();
1;
