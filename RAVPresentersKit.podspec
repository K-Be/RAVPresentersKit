Pod::Spec.new do |s|

  s.name         = "RAVPresentersKit"
  s.version      = "0.4.3"
  s.summary      = "The easiest way to build lists view with models"
  s.homepage     = "https://github.com/K-Be/RAVPresentersKit.git"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Andrew Romanov" => "scalli-k-be@ya.ru" }

  s.source       = { :git => "https://github.com/K-Be/RAVPresentersKit.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.frameworks = 'CoreGraphics'

	s.subspec 'Core' do |op|
		op.source_files = 'TableController/RAVPresentersKit/Core/*.{h,m}', 'TableController/RAVPresentersKit/Core/models/*.{h,m}', 'TableController/RAVPresentersKit/utils/*.{h,m}'
		op.ios.framework = 'Foundation', 'UIKit'
	end

  s.subspec 'TableController' do |op|
    op.source_files = 'TableController/RAVPresentersKit/TableViewController/*.{h,m}', 'TableController/RAVPresentersKit/TableViewController/singleModelPresenter/*.{h,m}', 'TableController/RAVPresentersKit/TableViewController/universalPresenter/*.{h,m}', 'TableController/RAVPresentersKit/TableViewController/universalPresenter/private/*.{h,m}'
    op.dependency 'RAVPresentersKit/Core'
    op.ios.framework = 'UIKit', 'Foundation'
  end

  s.subspec 'HorizontalViewPresenters' do |op|
    op.source_files = 'TableController/RAVPresentersKit/HorizontalViewPresenters/*.{h,m}', 'TableController/RAVPresentersKit/HorizontalView/controller/*.{h,m}'
    op.dependency 'RAVPresentersKit/Core'
    op.ios.framework = 'UIKit', 'Foundation'
  end

  s.subspec 'CollectionViewPresenters' do |op|
    op.source_files = 'TableController/RAVPresentersKit/CollectionViewPresenters/*.{h,m}'
    op.dependency 'RAVPresentersKit/Core'
    op.ios.framework = 'UIKit', 'Foundation'
  end

end
