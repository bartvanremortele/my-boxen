# Public: Install Java SE 6
#
# Examples
#
#  include java6
class java6 {
  package { 'Java6':
    provider => 'pkgdmg',
    source   => 'https://s3.amazonaws.com/burnsra/JavaForOSX2014-001.dmg',
  }
}
