source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.3'
use_frameworks!

def shared_pods
    pod 'Alamofire'
    pod 'IQKeyboardManagerSwift'
    pod 'MBProgressHUD'
    pod 'RxCocoa'
    pod 'RxSwift'
    pod 'SWRevealViewController', :git => 'https://github.com/John-Lluch/SWRevealViewController.git'
end

target 'Awesome iOS Demo' do
    inhibit_all_warnings!
    shared_pods
end

target 'Awesome iOS DemoTests' do
    inhibit_all_warnings!
    shared_pods

    # Pods for testing
end

target 'Awesome iOS DemoUITests' do
    inhibit_all_warnings!
    shared_pods

    # Pods for testing
end
