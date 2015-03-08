class people::bartvanremortele {
  notify { 'Running manifest for: bartvanremortele': }
  include sublime_text
  sublime_text::package { 'Emmet':
    source => 'sergeche/emmet-sublime'
  }
}
