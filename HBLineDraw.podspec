Pod::Spec.new do |s|
  s.name             = 'HBLineDraw'
  s.version          = '0.1.0'
  s.summary          = 'By far the most fantastic draw line which is form with 2 different points on any UIView.'

  s.description      = <<-DESC
  HBLineDraw is a swift replacement of HBLineDraw. 
                       DESC

  s.homepage         = 'https://github.com/Hitesh-Boricha/HBLineDraw'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hitesh Boricha' => 'hiteshboricha043@gmail.com' }
  s.source           = { :git => 'https://github.com/Hitesh-Boricha/HBLineDraw.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'HBLineDraw/**/*.swift'
  
  s.swift_version = '5.0'
  s.frameworks = 'UIKit'
end
