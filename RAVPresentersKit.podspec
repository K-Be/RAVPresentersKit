Pod::Spec.new do |s|

  s.name         = "RAVPresentersKit"
  s.version      = "0.4.0"
  s.summary      = "The easiest way to build lists view with models"
  s.homepage     = "https://bitbucket.org/k_be/ravtablecontroller"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Andrew Romanov" => "scalli-k-be@ya.ru" }

  s.source       = { :git => "https://k_be@bitbucket.org/k_be/ravtablecontroller.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.frameworks = 'CoreGraphics'

	s.subspec 'Core' do |op|
		op.source_files = 'TableController/RAVPresentersKit/Core/*.{h,m}', 'TableController/RAVPresentersKit/Core/models/*.{h,m}', 'TableController/RAVPresentersKit/utils/*.{h,m}'
		op.ios.framework = 'Foundation'
	end

  s.subspec 'TableController' do |op|
    op.source_files = 'TableController/RAVPresentersKit/TableView/*.{h,m}', 'TableController/RAVPresentersKit/TableView/singleModelPresenter/*.{h,m}', 'TableController/RAVPresentersKit/TableView/universalPresenter/*.{h,m}'
    op.dependency 'RAVPresentersKit/Core'
    op.ios.framework = 'UIKit'
  end

  s.subspec 'HorizontalViewPresenters' do |op|
    op.source_files = 'TableController/RAVPresentersKit/HorizontalViewPresenters/*.{h,m}', 'TableController/RAVPresentersKit/HorizontalViewPresenters/controller/*.{h,m}'
    op.dependency 'RAVPresentersKit/Core'
    op.ios.framework = 'UIKit'
  end

  s.subspec 'CollectionViewPresenters' do |op|
    op.source_files = 'TableController/RAVPresentersKit/CollectionViewPresenters/*.{h,m}'
    op.dependency 'RAVPresentersKit/Core'
    op.ios.framework = 'UIKit'
  end

end
