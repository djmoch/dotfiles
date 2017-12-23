# This script lightly modified from the original, found at:
# https://github.com/ervandew/keyring/blob/master/irssi/scripts/keyring.pl
use strict;

use IPC::Open3;
use Irssi;
use Symbol;

Irssi::command_bind keyring => sub {
  my ($account) = @_;

  open(LOGIN, "$ENV{HOME}/.irssi/login");
  while (<LOGIN>) {
    chomp;
    my $command = $_;
    my @parts = split(/\s/, $command);
    my $username;
    my $chatnet;
    my $nick;
    my $username_alt;
    if ($parts[0] eq 'connect'){
      if (scalar(@parts) >= 5){
        $chatnet = "$parts[1]";
        $nick = "$parts[4]";
        $username = "$parts[4]\@$parts[1]";
      }
    }else{
      next;
    }

    # handle alternate username
    if ($command =~ m/.*<password:([^>]*)>.*/){
      $username_alt = $1;
      $username_alt =~ s/@/ /g;
    }

    # handle reset command
    if ($account eq 'reset'){
      Irssi::command("network modify -sasl_mechanism '' -sasl_username '' -sasl_password '' $chatnet");
      next
    }

    # just print available account names
    if ($account eq 'names') {
      if ($username){
        print $username;
      }elsif ($username_alt){
        print $username_alt;
      }
      next;
    }

    if ($account && $account ne $username && $account ne $username_alt){
      next;
    }

    if (!$username && !$username_alt){
      next;
    }

    my ($stdin, $stdout, $stderr);
    $stderr = gensym();
    if ($username_alt){
      $username = $username_alt;
    }
    my  $pid = open3($stdin, $stdout, $stderr, "secret-tool lookup $username");
    waitpid($pid, 0);

    my $status = $? >> 8;
    if ($status == 0){
      my $password = join('', <$stdout>);
      chomp($password);
      if ($parts[0] eq 'set'){
        print "keyring: setting $username";
        Irssi::settings_set_str($username, $password);
      }else{
        print "keyring: connecting $username";
        $command =~ s/<password(:[^>]*)?>/$password/;
        Irssi::command("network modify -sasl_mechanism PLAIN -sasl_username $nick -sasl_password $password $chatnet");
        Irssi::command("connect $chatnet");
      }
    }else{
      my $error = join('', <$stderr>);
      die "Error reading data from stderr: $!" if !eof($stderr);
      chomp($error);
      print "keyring: Error invoking keyring command: $error";
    }
  }
  close(LOGIN);
};
