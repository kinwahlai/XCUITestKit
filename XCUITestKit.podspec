#
# Be sure to run `pod lib lint XCUITestKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XCUITestKit'
  s.version          = '0.1.0'
  s.summary          = 'XCUITestKit has all the common utility for UI tests'

  s.description      = <<-DESC
Gather all the utility and tool I built into XCUITestKit
                       DESC

  s.homepage         = 'https://github.com/kinwahlai/XCUITestKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Darren Lai' => 'kinwah.lai@gmail.com' }
  s.source           = { :git => 'https://github.com/kinwahlai/XCUITestKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/darrenkwlai'
  s.swift_versions = '5.0'
  s.ios.deployment_target = '12.0'

  s.source_files = 'XCUITestKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XCUITestKit' => ['XCUITestKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
