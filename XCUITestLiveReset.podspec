#
# Be sure to run `pod lib lint XCUITestLiveReset.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XCUITestLiveReset'
  s.version          = '0.1.0'
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
  s.platform = :ios
  s.ios.deployment_target = '12.0'
  s.cocoapods_version = '>= 1.4.0'
  s.static_framework = true
  s.default_subspec = 'Base'
  s.dependency 'gRPC-Swift', '1.0.0-alpha.14'

  s.subspec 'Base' do |base|
    base.source_files = "XCUITestLiveReset/Classes/Shared/**/*.{swift, m, h}"
  end

  s.dependency 'XCUITestKit', '~> 0.1.0'
  s.subspec 'Client' do |c|
    c.frameworks = 'XCTest'
    c.pod_target_xcconfig = { :prebuild_configuration => 'debug', 'ENABLE_BITCODE' => 'NO' }
    c.dependency 'XCUITestLiveReset/Base'
    c.source_files = "XCUITestLiveReset/Classes/Client/**/*.{swift, m, h}"
  end
  
  s.subspec 'Host' do |h|
    h.dependency 'XCUITestLiveReset/Base'
    h.source_files = "XCUITestLiveReset/Classes/Host/**/*.{swift, m, h}"
  end
end
