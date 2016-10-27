Pod::Spec.new do |s|
  s.name         = 'XXKit'
  s.summary      = 'show FPS for application'
  s.version      = '0.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'rookie' => '1223352800@qq.com' }
  s.social_media_url = 'http://smartrookie.cn'
  s.homepage     = 'https://github.com/smartrookie/XXKit'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/smartrookie/XXKit.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'XXKit/**/*.{swift}'
  
  s.frameworks = 'UIKit'
end
