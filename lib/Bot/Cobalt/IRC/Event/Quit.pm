package Bot::Cobalt::IRC::Event::Quit;
our $VERSION = '0.008_02';

use Moo;
use strictures 1;
use Bot::Cobalt::Common qw/:types/;

extends 'Bot::Cobalt::IRC::Event';

has 'reason' => ( is => 'rw', isa => Str, lazy => 1, 
  default => sub {''},
);

has 'common' => ( is => 'rw', isa => ArrayRef, lazy => 1,
  default => sub {[]},
);

1;
__END__
=pod

=head1 NAME

Bot::Cobalt::IRC::Event::Quit - IRC Event subclass for user quits

=head1 SYNOPSIS

  my $reason = $quit_ev->reason;
  
  my $shared_chans = $quit_ev->common;

=head1 DESCRIPTION

This is the L<Bot::Cobalt::IRC::Event> subclass for user quit events.

=head2 reason

Returns the displayed reason for the quit.

=head2 common

Returns an arrayref containing the list of channels previously shared 
with the user.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

L<http://www.cobaltirc.org>

=cut
