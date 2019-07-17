
Pod::Spec.new do |s|
  s.name             = 'AutmFitering'
  s.version          = '0.1.0'
  s.summary          = 'This is image filtering library like Instagram, this is a Sharaku library that was updated to swift 5.0'

  s.description      = <<-DESC
AutmFiltering is a update version of Sharaku for swift 5.0. Library filtering image like Instagrams, using CIFilter. Thank Sharaku!
                       DESC

  s.homepage         = 'https://github.com/autm-syl/AutmFitering'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sylvanas' => 'lecuong.bka@gmail.com' }
  s.source           = { :git => 'https://github.com/autm-syl/AutmFitering.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'AutmFitering/Classes/**/*.swift'
  s.resources = ['AutmFitering/Classes/**/*.xib']
end
