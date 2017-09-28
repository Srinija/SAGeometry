#
# Be sure to run `pod lib lint SAGeometry.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SAGeometry'
  s.version          = '0.1.0'
  s.summary          = 'A geometry helper for core graphics written in swift.'

#  s.description      = <<-DESC
#TODO: Add long description of the pod here.

  s.homepage         = 'https://github.com/srinija/SAGeometry'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Srinija Ammapalli'
  s.source           = { :git => 'https://github.com/srinija/SAGeometry.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SAGeometry/Classes/**/*'

   s.frameworks = 'UIKit'
end
