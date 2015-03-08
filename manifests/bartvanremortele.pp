class people::bartvanremortele {

  notify { 'Running manifest for: bartvanremortele': }
  
  $home = "/Users/${::boxen_user}"
  $myfiles = "/opt/boxen/repo/myfiles"  
  
  ########################################
  # --- BelgianCustom keyboard layout --- 
  ########################################
  file { "/Library/Keyboard Layouts/BelgianCustom.keylayout":
    ensure => present,
    source => "$myfiles/BelgianCustom.keylayout",
  }

  ########################################
  # --- Install bash profile --- 
  ########################################
  file { "$home/.bash_profile":
    ensure => present,
    source => "$myfiles/bash_profile",
  }

  ########################################
  # --- Java --- 
  ########################################
  # Install the default version of both the JDK and JRE
  include java
  include java6

  ########################################
  # --- Dropbox ---
  ########################################
  include dropbox

  ########################################
  # --- Sublime Text 3 ---
  ########################################
  include sublime_text
  sublime_text::package { 'Emmet':
    source => 'sergeche/emmet-sublime'
  }

  ########################################
  # --- Intellij Ultimate ---
  ########################################
  class { 'intellij':
    edition => 'ultimate',
      version => '14.0.3'
  }

  ########################################
  # --- SourceTree ---
  ########################################
  include sourcetree

  ########################################
  # --- Chrome ---
  ########################################
  include chrome

  ########################################
  # --- HipChat ---
  ########################################
  include hipchat
  
  ########################################
  # --- Spotify ---
  ########################################
  include spotify

  ########################################
  # --- FileZilla ---
  ########################################
  class { 'filezilla':
    version => '3.10.2'
  }

  ########################################
  # --- Yeoman ---
  ########################################
  nodejs::module { 'yo': node_version => 'v0.10' }
  nodejs::module { 'grunt-cli': node_version => 'v0.10' }
  nodejs::module { 'bower': node_version => 'v0.10' }

  ########################################
  # --- START OS X CONFIGURATION ---
  ########################################
  boxen::osx_defaults { 'Disable Dashboard':
    key    => 'mcx-disabled',
    domain => 'com.apple.dashboard',
    value  => 'YES',
  }
  boxen::osx_defaults { 'Disable reopen windows when logging back in':
    key    => 'TALLogoutSavesState',
    domain => 'com.apple.loginwindow',
    value  => 'false',
  }
  boxen::osx_defaults { 'Disable press-and-hold character picker':
    key    => 'ApplePressAndHoldEnabled',
    domain => 'NSGlobalDomain',
    value  => 'false',
  }
  boxen::osx_defaults { 'Display full POSIX path as Finder Window':
    key    => '_FXShowPosixPathInTitle',
    domain => 'com.apple.finder',
    value  => 'true',
  }
  boxen::osx_defaults { 'Secure Empty Trash':
    key    => 'EmptyTrashSecurely',
    domain => 'com.apple.finder',
    value  => 'true',
  }
  boxen::osx_defaults { 'Always use current directory in default search':
    key    => 'FXDefaultSearchScope',
    domain => 'com.apple.finder',
    value  => 'SCcf',
  }
  boxen::osx_defaults { 'Do not create .DS_Store':
    key    => 'DSDontWriteNetworkStores',
    domain => 'com.apple.dashboard',
    value  => 'true',
  }
  boxen::osx_defaults { "Disable 'natural scrolling'":
    key    => 'com.apple.swipescrolldirection',
    domain => 'NSGlobalDomain',
    value  => 'false',
  }
  boxen::osx_defaults { 'Disable the "Are you sure you want to open this application?" dialog':
    key    => 'LSQuarantine',
    domain => 'com.apple.LaunchServices',
    value  => 'true',
  }
  boxen::osx_defaults { 'fucking sane key repeat':
    domain => 'NSGlobalDomain',
    key    => 'KeyRepeat',
    value  => '0',
  }
  boxen::osx_defaults { 'Expand save panel by default':
      key    => 'NSNavPanelExpandedStateForSaveMode',
      domain => 'NSGlobalDomain',
      value  => 'true',
  }
  boxen::osx_defaults { 'Expand print panel by default':
      key    => 'PMPrintingExpandedStateForPrint',
      domain => 'NSGlobalDomain',
      value  => 'true',
  }
  boxen::osx_defaults { 'Minimize on Double-Click':
      key    => 'AppleMiniaturizeOnDoubleClick',
      domain => 'NSGlobalDomain',
      value  => 'true',
  }
  boxen::osx_defaults { 'Put my Dock on the bottom':
    key    => 'orientation',
    domain => 'com.apple.dock',
    value  => 'bottom',
  }
  boxen::osx_defaults { 'Make function keys do real things, and not apple things':
    key    => 'com.apple.keyboard.fnState',
    domain => 'NSGlobalDomain',
    value  => 'true',
  }
  boxen::osx_defaults { 'Make my mouse actually move when moved':
    key    => 'scaling',
    domain => 'com.apple.mouse',
    value  => '7.0',
  }
 
  # Disable GateKeeper
  exec { 'Disable Gatekeeper':
    command => 'sudo spctl --master-disable',
    unless  => 'spctl --status | grep disabled',
  }
 
  ########################################
  # --- END OS X CONFIGURATION ---
  ########################################

  notify {"Keyboard layout 'BelgianCustom' was installed. You will have to manually switch to this keyboard layout.":}
}
