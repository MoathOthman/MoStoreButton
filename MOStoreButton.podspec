Pod::Spec.new do |s|

s.name              = 'MOStoreButton'
s.version           = '0.1.0'
s.summary           = 'AppStore alike download/buy/open button'
s.homepage          = 'https://github.com/MoathOthman/MoStoreButton'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'Moath Othman' => 'myopenworld@outlook.com'
}
s.source            = {
:git => 'https://github.com/MoathOthman/MoStoreButton.git',
:tag => s.version.to_s
}
s.source_files      = 'MOStoreButton/*.{m,h}'
s.requires_arc      = true
s.ios.deployment_target = '7.0'
s.osx.deployment_target = '10.8'
s.platform = :ios
end