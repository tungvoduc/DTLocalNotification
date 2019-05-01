#
# Be sure to run `pod lib lint DTLocalNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DTLocalNotification'
  s.version          = '1.0.0'
  s.summary          = 'Custom control that makes displaying in-app notifications easier, cleaner and more efficient.'
  s.swift_version    = '5.0'
  s.description      = <<-DESC
DTLocalNotification offers you an fast and easy way to show popups and notifications in your app.
                       DESC

  s.homepage         = 'https://github.com/tungvoduc/DTLocalNotification'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tungvoduc' => 'tung98.dn@gmail.com' }
  s.source           = { :git => 'https://github.com/tungvoduc/DTLocalNotification.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DTLocalNotification/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DTLocalNotification' => ['DTLocalNotification/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
