# frozen_string_literal: true

Pod::Spec.new do |s|
  s.name          = 'MMActionSheet'
  s.version       = '11.1'
  s.summary       = 'MMActionSheet is an simple pop-up selection box(ActionSheet) written in pure Swift'
  s.homepage      = 'https://github.com/damoncoo/MMActionSheet'
  s.license       = 'MIT'
  s.author        = { 'gyh' => 'm12860gyh@gmail.com' }
  s.platform      = :ios, '8.0'
  s.source = { git: 'https://github.com/damoncoo/MMActionSheet.git', tag: "v#{s.version}" }
  s.source_files = 'Sources/MMActionSheet'
end
