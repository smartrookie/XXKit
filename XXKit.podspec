Pod::Spec.new do |s|
  s.name         = 'XXKit'
  s.summary      = 'A collection of iOS components.'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'rookie' => '1223352800@qq.com' }
  s.social_media_url = 'http://smartrookie.cn'
  s.homepage     = 'https://github.com/ismartrookie/XXKit'
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/ismartrookie/XXKit.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'XXKit/**/*.{swift}'
  # s.public_header_files = 'YYKit/**/*.{h}'

  # non_arc_files = 'YYKit/Base/Foundation/NSObject+YYAddForARC.{h,m}', 'YYKit/Base/Foundation/NSThread+YYAdd.{h,m}'
  
  s.frameworks = 'UIKit'

end
