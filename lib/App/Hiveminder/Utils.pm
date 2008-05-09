#!/usr/bin/perl
package App::Hiveminder::Utils;
use strict;
use warnings;
use List::MoreUtils qw/any/;
use File::Temp qw/tempfile/;
use Fcntl qw/F_SETFD/;
require Exporter;
our @ISA = qw/Exporter/;
our @EXPORT_OK = qw/get_text_from_editor get_text_from_editor_or_cmdline in
                    parse_args update_tasks colorize display_tasks/;

sub get_text_from_editor { # {{{
    my $editor = $ENV{EDITOR} || $ENV{VISUAL} || '/bin/nano';
    my ($fh, $fn) = tempfile;
    my $device = '/dev/fd/' . fileno($fh);

    # use the filehandle if possible, fall back to the filename
    if (-w $device && -l $device && readlink($device) eq $fn) {
        fcntl($fh, F_SETFD, 0);
        system($editor, $device);
    }
    else {
        close $fh;
        system($editor, $fn);
        open $fh, '<', $fn or die "Couldn't reopen $fn";
    }

    local $/ = undef;
    my $text = <$fh>;
    unlink $fn;

    return $text;
} # }}}
sub get_text_from_editor_or_cmdline { # {{{
    return join ' ', @_ if @_ > 0;
    return get_text_from_editor;
} # }}}
sub in { # {{{
    my $word = shift;
    return any { $_ eq $word } @_;
} # }}}
sub parse_args { # {{{
    my $ret = {};

    # XXX: handle 'will complete' and 'sort by *'
    # XXX: support the new Net::Hiveminder capability of searching on multiple
    #      keys per value
    # XXX: currently, searching by 'q' doesn't work, but this is a limitation
    #      of the current hiveminder REST interface i believe
    my @filters = ('accepted', 'complete', 'completed', 'description', 'due',
                   'group', 'owner', 'pending', 'priority', 'q', 'requestor',
                   'starts', 'summary', 'tag', 'unaccepted', 'search', 'id');
    my @time_filters = ('completed', 'due', 'starts');
    my @num_filters = ('priority');
    my @arg_filters = ('completed', 'description', 'due', 'group', 'owner',
                       'priority', 'q', 'requestor', 'starts', 'summary',
                       'tag', 'id');

    my %filter = (
        name    => '',
        is_neg  => 0,
    );
    for my $word (@_) {
        if (!$filter{name}) {
            if ($word eq 'not') {
                $filter{is_neg} = 1;
                next;
            }
            elsif ($word =~ m{^/}) {
                $filter{name} = 'q';
                $word =~ s{^/(.*)}{$1};
                redo;
            }
            elsif (in($word, @filters)) {
                $word = 'q' if $word eq 'search';
                $filter{name} = $word;
                if (!in($filter{name}, @arg_filters)) {
                    if ($filter{is_neg}) {
                        $filter{name} .= '_not';
                    }
                    $ret->{$filter{name}} = 1;
                    $filter{is_neg} = 0;
                    $filter{name} = '';
                }
                next;
            }
            else {
                $filter{name} = 'id';
                redo;
            }
        }
        else {
            if ((in($filter{name}, @time_filters) &&
                 ($word eq 'after' || $word eq 'before')) ||
                (in($filter{name}, @num_filters) &&
                 ($word eq 'above' || $word eq 'below')) ||
                 $word eq 'not') {
                $filter{name} .= "_$word";
                next;
            }

            if (defined $ret->{$filter{name}}) {
                push @{ $ret->{$filter{name}} }, $word;
            }
            else {
                $ret->{$filter{name}} = [$word];
            }
            $filter{name} = '';
        }
    }

    return $ret;
} # }}}
sub update_tasks { # {{{
    my ($hm, $tasks, $updater) = @_;
    my @tasks = ();
    if (ref $tasks eq 'HASH') {
        @tasks = $hm->get_tasks(%$tasks);
    }
    elsif (ref $tasks eq 'ARRAY') {
        @tasks = @$tasks;
    }
    my $ret = [];
    for my $task (@tasks) {
        push @$ret, $hm->update_task($task, &$updater($task));
    }
    return $ret;
} # }}}
sub colorize { # {{{
    my %priorities = (
        lowest  => 34,
        low     => 36,
        high    => 33,
        highest => 31,
    );
    for my $line (@_) {
        if ($line =~ /^\*/) {
            $line = "\e[1;30;40m".$line."\e[0m";
            next;
        }
        my $task_color = "37";
        $task_color = "32" if
            $line =~ s/ (\[(?:\"[^"]+\" ?)+\])/ \e[32m$1\e[0m/;
        $task_color = "1;37" if
            $line =~ s/ (\[by: [^\]]+\])/ \e[1;37m$1\e[0m/;
        $task_color = "35" if
            $line =~ s/ (\[due: [^\]]+\])/ \e[35m$1\e[0m/;
        $task_color = "1;$priorities{$2}" if
            $line =~ s/ (\[priority: (\w+)\])/" \e[1;$priorities{$2}m$1\e[0m"/e;
        $task_color = "33" if
            $line =~ s/ (\[starts: [^\]]+\])/ \e[33m$1\e[0m/;
        $task_color = "1;30" if
            $line =~ s/ (\[done\])/ \e[1;30m$1\e[0m/;
        $line =~ s/^(#\w+)/\e[${task_color}m$1\e[0m/;
    }

    return join "\n", @_;
} # }}}
sub display_tasks { # {{{
    my $hm = shift;
    my @lines = $hm->display_tasks(@_);
    my $text;
    if (-t *STDOUT) {
        $text = colorize @lines;
    }
    else {
        $text = join "\n", @lines;
    }
    return $text;
} # }}}

1;
