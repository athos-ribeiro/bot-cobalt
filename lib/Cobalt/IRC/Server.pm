package Cobalt::IRC::Server;

## A server context.

use strictures 1;
use 5.10.1;

use Moo;
use Cobalt::Common qw/:types/;

has 'name' => ( is => 'rw', isa => Str, required => 1 );

has 'prefer_nick' => ( is => 'rw', isa => Str, required => 1 );

has 'irc' => ( is => 'rw', isa => Object,
  predicate => 'has_irc',
  clearer   => 'clear_irc',
);

has 'connected' => ( is => 'rw', isa => Bool, lazy => 1,
  default => sub { 0 },
  clearer => 'clear_connected',
);

has 'connectedat' => ( is => 'rw', isa => Num, lazy => 1,
  default => sub { 0 },
);

has 'casemap' => ( is => 'rw', isa => Str, lazy => 1,
  default => sub { 'rfc1459' },
  coerce  => sub {
    $_[0] = lc($_[0]);
    $_[0] = 'rfc1459' unless $_[0] ~~ [qw/ascii rfc1459 strict-rfc1459/]
  },
); 

has 'maxmodes' => ( is => 'rw', isa => Int, lazy => 1,
  default => sub { 3 },
);


1;
__END__

=pod

=head1 NAME

Cobalt::IRC::Server - An IRC server context

=head1 SYNOPSIS

  ## Get a Cobalt::IRC::Server object from Cobalt::Core
  my $server = $core->get_irc_context( $context );  
  
  if ( $server->connected ) {
    my $casemap = $server->casemap;
    
    . . .
  }

=head1 DESCRIPTION

Represents an IRC server context. 

L<Cobalt::Core> stores a server context object for every configured 
context; it can be retrieved using B<get_irc_context>.

The following attributes are available:

=head2 name

The server name.

Note that this is the server we connected to or intend to connect to;
not necessarily the announced name of a connected server.

=head2 connected

A boolean value indicating whether or not this context is marked as 
connected.

In the case of core-managed contexts, this is set by L<Cobalt::IRC>.

=head2 connectedat

The time (epoch seconds) that the server context was marked as 
connected.

=head2 prefer_nick

The preferred/configured nickname for this context.

=head2 irc

The actual IRC object for this configured context; this will typically 
be a L<POE::Component::IRC> subclass.

=head2 casemap

The available CASEMAPPING value for this server.

See L<Cobalt::Manual::Plugins/get_irc_casemap>

=head2 maxmodes

The maximum number of modes allowed in a single mode change command.

If the server does not announce MAXMODES, the default is 3.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

L<http://www.cobaltirc.org>

=cut