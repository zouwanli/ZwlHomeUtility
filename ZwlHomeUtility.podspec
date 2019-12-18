#
#  Be sure to run `pod spec lint ZwlCreateLib.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    #库名称
    s.name             = 'ZwlHomeUtility'
    #版本号
    s.version          = '1.0.0'
    #库简短介绍,以后search到简介
    s.summary          = 'iOS 测试库组件'
    #开源库描述,定义具体的描述
    s.description      = <<-DESC
   			 TODO: 这是一个Cocoapods制作自己的共有库的测试版本、
  			 DESC
    #开源库地址，或者是博客、社交地址等
    s.homepage      = "https://github.com/zouwanli/ZwlHomeUtility"
    #开源协议
    s.license       = { :type => 'MIT', :file => 'LICENSE' }
    #开源库GitHub的路径与tag值，GitHub路径后必须有.git,tag实际就是上面的版本
    s.source        = { :git => "https://github.com/zouwanli/ZwlHomeUtility.git", :tag => "#{s.version}" }
	
    #源库资源文件
    s.source_files  = 'SourceFiles'  
    s.exclude_files = "Classes/Exclude"

    #build的平台
    s.platform     = :ios, "10.0"
    #最低开发
    s.ios.deployment_target = "10.0"

    #开源库作者
    s.author        = { "Zouwanli" => "1205974695@qq.com" }
    #社交网址
    s.social_media_url = 'https://github.com/zouwanli'

    #引用库框架
    #s.frameworks = 'SomeFramework', 'AnotherFramework'

# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
# A list of resources included with the Pod. These are copied into the
# target bundle with a build phase script. Anything else will be cleaned.
# You can preserve files from being cleaned, please don't preserve
# non-essential files like tests, examples and documentation.
#

# s.resource = "icon.png"
# s.resources = "Resources/*.png"

# s.preserve_paths = "FilesToSave", "MoreFilesToSave"


# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
# Link your library with frameworks, or libraries. Libraries do not include
# the lib prefix of their name.
#

# s.framework = 'SomeFramework'
# s.frameworks = 'SomeFramework', 'AnotherFramework'

# s.library = 'iconv'
# s.libraries = 'iconv', 'xml2'


# ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
# If your library depends on compiler flags you can set them in the xcconfig hash
# where they will only apply to your library. If you depend on other Podspecs
# you can include multiple dependencies to ensure it works.

# s.requires_arc = true

# s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
# s.dependency 'JSONKit', '~> 1.4'



end