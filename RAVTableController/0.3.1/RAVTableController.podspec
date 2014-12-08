Pod::Spec.new do |s|

  s.name         = "RAVTableController"
  s.version      = "0.3.1"
  s.summary      = "The easiest way to build table view with models"
  s.homepage     = "https://bitbucket.org/k_be/ravtablecontroller"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Andrew Romanov" => "scalli-k-be@ya.ru" }

  s.source       = { :git => "https://k_be@bitbucket.org/k_be/ravtablecontroller.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.frameworks = 'CoreGraphics'

  s.source_files = 'TableController/RAVTableController/*.{h,m}'

end
