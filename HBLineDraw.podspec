Pod::Spec.new do |spec|
  spec.name         = 'HBLineDraw'
  spec.version      = '0.1.0'
  spec.summary          = 'By far the most fantastic draw line which is form with 2 different points on any UIView.'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/Hitesh-Boricha/HBLineDraw'
  spec.authors      = { 'Hitesh Boricha' => 'hiteshboricha043@gmail.com' }
  spec.source       = { :git => 'https://github.com/Hitesh-Boricha/HBLineDraw.git', :tag => '0.1.0' }
  spec.source_files = 'HBLineDraw/**/*.swift'
  spec.platform 	= :ios, '11.0'
  spec.swift_version = '5.2'
end
