platform :ios, '8.0'
target 'TestRacVc' do
	pod 'ReactiveCocoa', '2.5'
	  pod 'React', :path => './node_modules/react-native/', :subspecs => [
    'Core',
  'ART',
  'RCTActionSheet',
  'RCTAdSupport',
  'RCTGeolocation',
  'RCTImage',
  'RCTNetwork',
  'RCTPushNotification',
  'RCTSettings',
  'RCTText',
  'RCTVibration',
  'DevSupport', # 如果RN版本 >= 0.43，则需要加入此行才能开启开发者菜单
  'BatchedBridge',
  'RCTWebSocket',
  'RCTAnimation',
  'RCTLinkingIOS', # 这个模块是用于调试功能的
    # 在这里继续添加你所需要的模块
  ]
  pod "Yoga", :path => "./node_modules/react-native/ReactCommon/yoga"
end
