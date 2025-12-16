# libvips_ffi 未完成事项清单

更新时间: 2025-01

## 桌面端预编译/加载

- [ ] Linux：实现预编译库加载逻辑（目前固定回退系统库）
- [ ] Linux：补齐预编译二进制与 Flutter Linux 插件目录

## 系统包管理器加载（libvips_ffi_system）

- [ ] Windows/Chocolatey：`isInstalled` 检测未实现
- [ ] `SystemPackageVipsLoader`：同步 `load()` 未做“同步查找”

## FFI 绑定

- [ ] generated bindings：多处 `TODO(kleisauke)` 提示 `VIPS_API` 导出缺失
- [ ] generated bindings：存在 `FIXME`（"need more of these"）

## CI/CD & 发布

- [ ] CI 配置缺失（`.github/` 工作流目录）
