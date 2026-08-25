Pod::Spec.new do |spec|
  spec.name         = "LookinServerMCP"
  spec.version      = "1.0.1"
  spec.summary      = "The iOS framework of Lookin with MCP HTTP server support."
  spec.description  = "Embed this framework into your iOS project to enable Lookin mac app and lookin-mcp direct connection via HTTP."
  spec.homepage     = "https://github.com/eval3/LookinServer"
  spec.license      = "GPL-3.0"
  spec.author       = { "hepiao3" => "hp193220847@gmail.com" }
  spec.ios.deployment_target  = "9.0"
  spec.default_subspecs = 'Core'
  spec.source       = { :git => "https://github.com/eval3/LookinServer.git", :tag => "1.0.1"}
  spec.framework  = "UIKit"
  spec.requires_arc = true
    
  spec.subspec 'Core' do |ss|
    ss.source_files = ['Src/Main/**/*', 'Src/Base/**/*']
    ss.pod_target_xcconfig = {
       'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SHOULD_COMPILE_LOOKIN_SERVER=1',
       'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) SHOULD_COMPILE_LOOKIN_SERVER'
    }
  end

  spec.subspec 'Swift' do |ss|
    ss.dependency 'LookinServerMCP/Core'
    ss.source_files = 'Src/Swift/**/*'
    ss.pod_target_xcconfig = {
       'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) LOOKIN_SERVER_SWIFT_ENABLED=1',
       'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) LOOKIN_SERVER_SWIFT_ENABLED'
    }
  end

  spec.subspec 'NoHook' do |ss|
    ss.dependency 'LookinServerMCP/Core'
    ss.pod_target_xcconfig = {
       'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) LOOKIN_SERVER_DISABLE_HOOK=1',
    }
  end
  
  # CocoaPods 不支持多个 subspecs 和 configurations 并列
  # "pod 'LookinServer', :subspecs => ['Swift', 'NoHook'], :configurations => ['Debug']" is not supported by CocoaPods
  # https://github.com/QMUI/LookinServer/issues/134
  spec.subspec 'SwiftAndNoHook' do |ss|
    ss.dependency 'LookinServerMCP/Core'
    ss.source_files = 'Src/Swift/**/*'
    ss.pod_target_xcconfig = {
       'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) LOOKIN_SERVER_SWIFT_ENABLED=1 LOOKIN_SERVER_DISABLE_HOOK=1',
       'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) LOOKIN_SERVER_SWIFT_ENABLED'
    }
  end

end
