use inc::Module::Install;

name('Kwiki-UserName');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Kwiki User Name Plugin');
license('perl');
version_from('lib/Kwiki/UserName.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.34
    Kwiki::UserPreferences 0.12
));

check_nmake();

&WriteAll();
