#
# Be sure to run `pod lib lint Thematic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Thematic'
  s.version          = '1.1.0'
  s.summary          = 'iOS 主题设置和动态切换库'
  s.homepage         = 'https://github.com/Pircate/Thematic'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gao497868860@163.com' => 'Pircate' }
  s.source           = { :git => 'https://github.com/Pircate/Thematic.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_versions = ['5.2']
  s.static_framework = true
  
  s.subspec 'Core' do |core|
    core.source_files  = "Thematic/Classes/Core/*.swift"
  end
  
  s.subspec 'Theme' do |theme|
    theme.source_files = "Thematic/Classes/Theme/*.swift"
    theme.dependency "Thematic/Core"
  end
  
end
