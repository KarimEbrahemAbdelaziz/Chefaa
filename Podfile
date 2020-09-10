# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def rx_swift
    pod 'RxSwift', '~> 5.0'
end

def rx_cocoa
    pod 'RxCocoa', '~> 5.0'
end

def rx_alamofire
    pod 'Alamofire'
    pod 'RxAlamofire'
end

def ui
  pod 'R.swift'
  pod 'SkeletonView'
  pod 'Kingfisher'
end

target 'Chefaa' do
  use_frameworks!

  rx_cocoa
  rx_swift
  ui
end

target 'Domain' do
  use_frameworks!
  
  rx_swift
end

target 'NetworkPlatform' do
    use_frameworks!

    rx_swift
    rx_alamofire
end
