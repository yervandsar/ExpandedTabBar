Pod::Spec.new do |s|
s.name             = 'ExpandedTabBar'
s.version          = '3.0.1'
s.summary          = 'ExpandedTabBar is a very creative designed solution for "more" items in UITabBarController'

s.homepage         = 'https://github.com/yervandsar/ExpandedTabBar'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Yervand Saribekyan' => 'yervandsar@gmail.com' }
s.source           = { :git => 'https://github.com/yervandsar/ExpandedTabBar.git', :tag => s.version.to_s }

s.ios.deployment_target = '11.0'
s.source_files     = "Sources/ExpandedTabBar/*.swift", "Sources/ExpandedTabBar/*/*.swift"

end
