#!/usr/bin/perl
package App::Hiveminder::Command;
use Moose;
use Net::Hiveminder;
extends 'MooseX::App::Cmd::Command';

has hm => (
    isa     => 'Net::Hiveminder',
    is      => 'ro',
    default => sub { Net::Hiveminder->new(use_config => 1) },
);

sub run {
    my ($self, $opt, $args) = @_;

    my $result = $self->command($args);

    if (defined $result) {
        chomp $result;
        $result .= "\n" if length $result > 0;
        print $result;
    }
    else {
        die $self->usage->text;
    }
}

__PACKAGE__->meta()->make_immutable();
1;
