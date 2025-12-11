Pod::Spec.new do |s|
  s.name             = 'libvips_ffi_macos'
  s.version          = '0.1.0'
  s.summary          = 'Pre-compiled libvips for macOS'
  s.description      = <<-DESC
Pre-compiled libvips 8.17.0 binaries for macOS (arm64).
Part of the libvips_ffi package family.
                       DESC
  s.homepage         = 'https://github.com/CaiJingLong/libvips_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'CaiJingLong' => 'cjl_spy@163.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.platform         = :osx, '10.14'
  s.swift_version    = '5.0'

  # Pre-compiled libvips and dependencies
  s.vendored_libraries = 'Libraries/arm64/*.dylib'
  
  # Set rpath for finding dependencies
  s.pod_target_xcconfig = {
    'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks @executable_path/../Frameworks'
  }
end
