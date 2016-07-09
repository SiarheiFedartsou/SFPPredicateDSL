#
# Be sure to run `pod lib lint SFPPredicateDSL.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SFPPredicateDSL'
  s.version          = '0.0.1'
  s.summary          = 'Typo-safe DSL for NSPredicate.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Typo-safe DSL for NSPredicate. Makes auto-completion and compile-time checks possible when writing NSPredicate's.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/SFPPredicateDSL'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Siarhei Fiedartsou' => 'siarhei.fedartsou@gmail.com' }
  s.source           = { :git => 'https://github.com/SiarheiFedartsou/SFPPredicateDSL.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SFPPredicateDSL/Classes/**/*'

  # s.resource_bundles = {
  #   'SFPPredicateDSL' => ['SFPPredicateDSL/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
