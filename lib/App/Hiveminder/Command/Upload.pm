#!/usr/bin/perl
package App::Hiveminder::Command::Upload;
use Moose;
extends 'App::Hiveminder::Command';

=head2 NAME

App::Hiveminder::Command::Upload - Upload a previously downloaded file back to your todo list

=cut

sub command_names { qw/upload up ul/ }

sub command {
    my $self = shift;

    return unless @_ > 0;
    my $filename = shift;
    $self->hm->upload_file($filename);
    return $filename;
}

__PACKAGE__->meta()->make_immutable();
1;
