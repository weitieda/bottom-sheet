Pod::Spec.new do |spec|

  spec.name         = "BottomSheet"
  spec.version      = "1.0.6"
  spec.summary      = "⬆️ A SwiftUI view component sliding in from bottom"
  spec.homepage     = "http://www.github.com/weitieda/bottom-sheet"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Tieda Wei" => "hi@tiedawei.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/weitieda/bottom-sheet.git", :tag => spec.version.to_s }
  spec.source_files  = "Sources/BottomSheet/*.{swift}"
  spec.swift_versions   = '5.0'
end
