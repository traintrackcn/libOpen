Pod::Spec.new do |s|
  s.name = 'libOpen'
  s.version = '0.1'
  s.platform = :ios, '5.0'
  s.license = 'MIT'
  s.summary = 'An Objective-C library'
  s.homepage = 'https://github.com/traintrackcn/libOpen'
  s.author = { 'traintrackcn' => 'traintrackcn@gmail.com' }
 # s.source = { :git => 'git://github.com/lukeredpath/libPusher.git', :tag => 'v1.3' }
  s.source_files = 'libOpen/*'
  s.requires_arc = true
 # s.dependency 'SocketRocket'
 # s.framework = 'ImageIO'
end