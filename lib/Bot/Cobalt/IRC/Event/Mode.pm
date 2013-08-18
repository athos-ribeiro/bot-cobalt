package Bot::Cobalt::IRC::Event::Mode;
our $VERSION = '0.016002_1';

use Moo;
use strictures 1;

use Bot::Cobalt;

use Bot::Cobalt::Common qw/:types/;

use IRC::Utils qw/parse_mode_line eq_irc/;

extends 'Bot::Cobalt::IRC::Event';

has 'mode'   => ( is => 'rw', isa => Str, required => 1 );

has 'target' => ( is => 'rw', isa => Str, required => 1 );

has 'is_umode' => ( 
  lazy => 1,

  is  => 'ro', 
  isa => Bool, 

  default => sub {
    my ($self)  = @_;
    my $casemap = core->get_irc_casemap( $self->context );
    my $irc_obj = core->get_irc_object( $self->context );
    my $me = $irc_obj->nick_name;
    eq_irc($me, $self->target) ? 1 : 0
  },
);

has 'channel' => ( 
  lazy => 1,
  is  => 'rw',

  default => sub {
    my ($self) = @_;
    $self->is_umode ? undef : $self->target
  },
);

has 'args' => ( 
  lazy => 1,
  is  => 'rw', 
  isa => ArrayRef, 

  default   => sub {[]},
);

has 'hash' => (
  lazy => 1,
  is  => 'ro', 
  isa => HashRef, 

  predicate => 'has_hash',
  builder   => '_build_hash',
);

sub _build_hash {
  my ($self) = @_;
  parse_mode_line( $self->mode, @{ $self->args })
}

1;
__END__

=pod

=head1 NAME

Bot::Cobalt::IRC::Event::Mode - IRC Event subclass for mode changes

=head1 SYNOPSIS

  unless ( $mode_ev->is_umode ) {
    my $channel = $mode_ev->channel;
    my $modestr = $mode_ev->mode;
    my $args    = $mode_ev->args;
    my $parsed  = $mode_ev->hash;
  }

=head1 DESCRIPTION

This is the L<Bot::Cobalt::IRC::Event> subclass for mode changes, both user 
and channel.

=head2 mode

Returns the mode change as a string.

=head2 is_umode

Returns a boolean value indicating whether or not this appears to be a 
umode change on ourselves.

=head2 target

Returns the target of the mode change; this may be a channel or our 
nickname.

=head2 channel

If L</is_umode> is false, B<channel> will return the same value as 
L</target>.

=head2 args

Returns an array reference containing any parameters for the mode 
change.

=head2 hash

Returns the hashref generated by L<IRC::Utils/parse_mode_line>.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

L<http://www.cobaltirc.org>

=cut
