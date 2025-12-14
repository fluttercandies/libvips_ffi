# libvips_ffi 未完成事项清单

## 桌面端预编译/加载

- [ ] Linux：实现预编译库加载逻辑（目前固定回退系统库）
  - 证据：`packages/libvips_ffi_linux/lib/src/linux_loader.dart:9-13`（`TODO` + `DynamicLibrary.open('libvips.so.42')`）

- [ ] Linux：补齐预编译二进制与发布前结构（README 标注 placeholder）
  - 证据：`packages/libvips_ffi_linux/README.md:24-26`

- [ ] Linux：补齐 Flutter Linux 插件目录/打包配置（当前不存在 `linux/` 目录）
  - 证据：`packages/libvips_ffi_linux/`（目录结构中无 `linux/`）

- [ ] macOS：补齐 x86_64 预编译库或调整宣称/loader（当前只有 arm64）
  - 证据：`packages/libvips_ffi_macos/README.md:8`（声称 x64+arm64）
  - 证据：`packages/libvips_ffi_macos/macos/Libraries/` 仅有 `arm64/`（目录结构）
  - 证据：`packages/libvips_ffi_macos/lib/src/macos_loader.dart:29-40`（按 `arch` 拼路径）
  - 证据：`packages/libvips_ffi_macos/macos/libvips_ffi_macos.podspec:18`（`vendored_libraries = 'Libraries/arm64/*.dylib'`）

- [ ] macOS：对齐 libvips 版本元信息（podspec 描述 8.17.0 vs pubspec 8.16.0）
  - 证据：`packages/libvips_ffi_macos/macos/libvips_ffi_macos.podspec:6`（"Pre-compiled libvips 8.17.0"）
  - 证据：`packages/libvips_ffi_macos/pubspec.yaml`（`version: 0.1.0+8.16.0`）

- [ ] Windows：README 仍标注 placeholder（但 `windows/dll` 已包含 DLL）
  - 证据：`packages/libvips_ffi_windows/README.md:24-26`
  - 证据：`packages/libvips_ffi_windows/windows/dll/`（存在且包含 `libvips-42.dll` 等）

- [ ] macOS：README 仍标注 placeholder（但 `macos/Libraries` 已包含 dylib）
  - 证据：`packages/libvips_ffi_macos/README.md:25-27`
  - 证据：`packages/libvips_ffi_macos/macos/Libraries/arm64/`（目录存在）

## 系统包管理器加载（libvips_ffi_system）

- [ ] Windows/Chocolatey：`isInstalled` 检测未实现
  - 证据：`packages/libvips_ffi_system/lib/src/system_library_finder.dart:325-342`（`isInstalled: false, // 需要实际检查`）

- [ ] `SystemPackageVipsLoader`：同步 `load()` 未做“同步查找”，仅回退 `SystemVipsLoader`
  - 证据：`packages/libvips_ffi_system/lib/src/system_vips_loader.dart:18-25`

## FFI 绑定与导出（libvips_ffi_core）

- [ ] generated bindings：多处 `TODO(kleisauke)` 提示 `VIPS_API` 导出缺失（可能影响工具/模块）
  - 证据：`packages/libvips_ffi_core/lib/src/bindings/vips_bindings_generated.dart:620, 686, 756, 957, 1051, 1089, 1126, 1364`

- [ ] generated bindings：存在 `FIXME`（"need more of these"）
  - 证据：`packages/libvips_ffi_core/lib/src/bindings/vips_bindings_generated.dart:11367`

## 文档/示例一致性

- [ ] `libvips_ffi_core` README：示例使用不匹配的 init API（`initVipsCore`）
  - 证据：`packages/libvips_ffi_core/README.md:26`

- [ ] docs：桌面重构计划仍有待定事项
  - 证据：`docs/DESKTOP_REFACTOR_PLAN.md:578-582`

- [ ] docs：实现检查清单（phase checklist）未勾选
  - 证据：`docs/DESKTOP_REFACTOR_IMPLEMENTATION.md:720-747`

- [ ] docs：对比报告开发清单仍有未完成项
  - 证据：`docs/COMPARISON_REPORT.md:195-197`

## CI/CD & 发布

- [ ] CI 配置缺失（未发现 `.github/` 工作流目录）
  - 证据：仓库根目录无 `.github/`
