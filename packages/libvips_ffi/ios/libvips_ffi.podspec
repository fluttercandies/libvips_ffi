#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint libvips_ffi.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'libvips_ffi'
  s.version          = '0.0.1'
  s.summary          = 'Flutter FFI bindings for libvips image processing library.'
  s.description      = <<-DESC
Flutter FFI bindings for libvips - a fast image processing library.
                       DESC
  s.homepage         = 'https://github.com/CaiJingLong/libvips_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'CaiJingLong' => 'cjl_spy@163.com' }

  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.static_framework = true

  # libvips static library - use preserve_paths to avoid CocoaPods auto-linking
  s.preserve_paths = 'Frameworks/libvips.xcframework'
  
  # System frameworks required by libvips
  s.frameworks = 'CoreFoundation', 'CoreGraphics', 'ImageIO', 'Accelerate'
  
  # System libraries
  s.libraries = 'c++', 'z', 'bz2', 'iconv', 'resolv'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'OTHER_LDFLAGS' => '-ObjC -all_load -force_load "${PODS_TARGET_SRCROOT}/Frameworks/libvips.xcframework/ios-arm64/libvips.a"',
    'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '-ObjC -all_load -force_load "${PODS_TARGET_SRCROOT}/Frameworks/libvips.xcframework/ios-arm64-simulator/libvips.a"',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}/Frameworks/libvips.xcframework/ios-arm64/Headers" "${PODS_TARGET_SRCROOT}/Frameworks/libvips.xcframework/ios-arm64-simulator/Headers"'
  }
  
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS[sdk=iphoneos*]' => '$(inherited) -force_load "${PODS_ROOT}/../.symlinks/plugins/libvips_ffi/ios/Frameworks/libvips.xcframework/ios-arm64/libvips.a"',
    'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '$(inherited) -force_load "${PODS_ROOT}/../.symlinks/plugins/libvips_ffi/ios/Frameworks/libvips.xcframework/ios-arm64-simulator/libvips.a"'
  }
  s.swift_version = '5.0'
end
