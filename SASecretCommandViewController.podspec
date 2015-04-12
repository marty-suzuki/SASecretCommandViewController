#
# Be sure to run `pod lib lint SASecretCommandViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SASecretCommandViewController"
  s.version          = "1.1.0"
  s.summary          = "You can use secret command with swipe gesture and A, B button. Show a secret mode you want!"
  s.homepage         = "https://github.com/szk-atmosphere/SASecretCommandViewController"
  s.license          = 'MIT'
  s.author           = { "Taiki Suzuki" => "s1180183@gmail.com" }
  s.source           = { :git => "https://github.com/szk-atmosphere/SASecretCommandViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/SzkAtmosphere'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'SASecretCommandViewController/*.swift'
  s.frameworks = 'QuartzCore'
end
