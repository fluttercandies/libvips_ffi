Pod::Spec.new do |s|
  s.name             = 'libvips_ffi_macos'
  s.version          = '0.1.0'
  s.summary          = 'Pre-compiled libvips for macOS'
  s.description      = <<-DESC
Pre-compiled libvips binaries for macOS (arm64 and x86_64).
Part of the libvips_ffi package family.
                       DESC
  s.homepage         = 'https://github.com/CaiJingLong/libvips_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'CaiJingLong' => 'cjl_spy@163.com' }
  s.source           = { :path => '.' }
  s.dependency       'FlutterMacOS'
  s.source_files     = 'Classes/**/*'
  s.platform         = :osx, '10.14'
  s.swift_version    = '5.0'

  # Pre-compiled libvips and dependencies
  # Detect CPU architecture and load corresponding libraries
  require 'rbconfig'
  arch = RbConfig::CONFIG['host_cpu']
  arch = 'arm64' if arch == 'aarch64'
  arch = 'x86_64' if arch == 'amd64'
  
  # Only include real dylib files (not symlinks)
  # Dependencies are already fixed to use full version names
  s.vendored_libraries = "Libraries/#{arch}/*.dylib"
  
  # Set rpath for finding dependencies in Frameworks directory
  s.pod_target_xcconfig = {
    'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks @executable_path/../Frameworks'
  }

end
