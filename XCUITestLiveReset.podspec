#
# Be sure to run `pod lib lint XCUITestLiveReset.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XCUITestLiveReset'
  s.version          = '0.1.1'
  s.summary          = 'Continue testing without relaunch application'

  s.description      = <<-DESC
  XCUITestLiveReset using NetService technique to broadcast an http endpoint for testcase
  to reset the target application state before testing.
                       DESC

  s.homepage         = 'https://github.com/kinwahlai/XCUITestKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Darren Lai' => 'kinwah.lai@gmail.com' }
  s.source           = { 
    :git => 'https://github.com/kinwahlai/XCUITestKit.git', 
    :tag => 'LiveReset-' + s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/darrenkwlai'
  s.swift_versions = '5.0'
  s.ios.deployment_target = '12.0'

  s.source_files = 'XCUITestLiveReset/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XCUITestLiveReset' => ['XCUITestLiveReset/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.dependency 'XCUITestKit', '~> 0.1.0'
end
