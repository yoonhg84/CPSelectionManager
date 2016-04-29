
Pod::Spec.new do |s|
  s.name         = "CPSelectionManager"
  s.version      = "0.0.1"
  s.summary      = "Manage selection of controls. (single/multiple selection)"
  s.description  = <<-DESC
  Manage selection of controls.
  Support single, multiple selection.
                   DESC
  s.homepage     = "https://github.com/yoonhg84/CPSelectionManager"
  s.screenshots  = "https://github.com/yoonhg84/CPSelectionManager/raw/master/README/CPSelectionManager.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "yoonhg84" => "yoonhg2002@gmail.com" }
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/yoonhg84/CPSelectionManager.git", :tag => s.version }
  s.source_files  = "Source", "Source/**/*.{h,m,swift}"
end
