
Pod::Spec.new do |s|
  s.name             = 'WTabbar'
  s.version          = '0.1.1'
  s.summary          = '自定义 WTabbar.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/qiuqixiang/WTabbar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qiuqixiang' => '739140860@qq.com' }
  s.source           = { :git => 'https://github.com/qiuqixiang/WTabbar.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.static_framework = true
  s.ios.deployment_target = '8.0'

  s.source_files = 'WTabbar/Classes/*'
  
end
