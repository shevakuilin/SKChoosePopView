Pod::Spec.new do |s|
  s.name         = "SKChoosePopView"
  s.version      = "0.0.5"
  s.summary      = "A custom popup window for options"
  s.description  = <<-DESC
			SKChoosePopView是一个HUD风格的可定制化选项弹窗的快速解决方案，集成了上、下、左、右、中5个进场方向的6种动画效果，如果不能满足你对酷炫效果的需要，SKChoosePopView同样支持自定义动画，以及选择记录、动画的开闭、点击特效、行列数量控制等。如果你觉得还不错，star支持一下吧！
                   DESC

  s.homepage     = "https://github.com/shevakuilin/SKChoosePopView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "ShevaKuilin" => "shevakuilin@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/shevakuilin/SKChoosePopView.git", :tag => "0.0.5" }
  s.source_files  = "Source/SKChoosePopView/*.{h,m}"
  s.dependency "Masonry", "~> 1.0.2"
end
