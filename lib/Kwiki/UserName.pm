package Kwiki::UserName;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-Base';
use Kwiki ':char_classes';
our $VERSION = '0.10';

const class_id => 'user_name';
const class_title => 'User Name';
const css_file => 'user_name.css';

sub register {
    my $registry = shift;
    $registry->add(preload => 'user_name');
    $registry->add(preference => 'user_name',
                   object => $self->user_name,
                  );
}

sub user_name {
    my $p = $self->new_preference('user_name');
    $p->query('Enter a KwikiUserName to identify yourself.');
    $p->type('input');
    $p->size(15);
    $p->edit('check_user_name');
    $p->default('');
    return $p;
}

sub check_user_name {
    my $preference = shift;
    my $value = $preference->new_value;
    return unless length $value;
    return $preference->error('Must be all alphanumeric characters.')
      unless $value =~ /^[$ALPHANUM]+$/;
    return $preference->error('Must be less than 30 characters.')
      unless length($value) < 30;
    $self->call_hooks;
}

sub call_hooks {
    my $hooks = $self->hub->registry->lookup->{user_name_hook}
      or return;
    for my $method (keys %$hooks) {
        my $class_id = $hooks->{$method}[0];
        $self->hub->load_class($class_id)->$method;
    }
}

1;
__DATA__

=head1 NAME 

Kwiki::UserName - Kwiki User Name Plugin

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Brian Ingerson <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2004. Brian Ingerson. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
__css/user_name.css__
div#user_name_title {
    font-size: small;
    float: right;
}
div#user_name_title a:visited {
    color: #d64;
}
__template/tt2/user_name_title.html__
<!-- BEGIN user_name_title.html -->
<div id="user_name_title">
<em>(You are 
<a href="[% script_name %]?action=user_preferences">
[% hub.preferences.user_name.value || 'an AnonymousGnome' %]
</a>)
</em>
</div>
<!-- END user_name_title.html -->
