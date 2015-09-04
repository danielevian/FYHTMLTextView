Pod::Spec.new do |s|

s.name         = "FYHTMLTextView"
s.version      = "1.0.0"
s.summary      = "UITextView that parses HTML code and transform it to native views."
s.description  = <<-DESC
UITextView that parses HTML code and transform it to NSAttributedString. Also transforms Instagram, Twitter and others embedeed objects to native views.
DESC

s.homepage     = "https://github.com/fyarad/FYHTMLTextView"
s.license      = "MIT"
s.author       = { "Francisco Yarad" => "fyarad95@gmail.com" }

s.platform     = :ios
s.platform     = :ios, "7.0"

s.source       = { :git => "https://github.com/fyarad/FYHTMLTextView.git", :tag => "1.0.0" }
s.source_files  = "Classes", "Pod/Classes/**/*.{h,m}"
s.exclude_files = "Classes/Exclude"
s.requires_arc = true

s.dependency 'DTCoreText', '~> 1.6.16'
s.dependency 'SDWebImage'


end

