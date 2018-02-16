
Pod::Spec.new do |s|
  s.name             = 'Linker'
  s.version          = '1.0.0'
  s.summary          = 'Lightweight way to handle internal and external URLs in Swift for iOS.'
  s.ios.deployment_target = '8.0'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maksim Kurpa' => 'maksim.kurpa@gmail.com' }
  s.description      = 'Linker is the easiest way to handle internal and external URLs in your project!'
  s.homepage         = 'https://github.com/MaksimKurpa/Linker'
  s.source       = { :git => 'https://github.com/MaksimKurpa/Linker.git', :branch => 'master',:tag => s.version.to_s }
  s.social_media_url = 'https://www.facebook.com/maksim.kurpa'
  s.source_files = 'Linker/Sources/Linker/*.{swift}'
  s.requires_arc = true
end
