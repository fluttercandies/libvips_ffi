---
sidebar_position: 1
---

# 包概览

libvips_ffi 以 monorepo 形式组织，包含多个包，每个包服务于特定目的。

## 包架构

```text
┌─────────────────────────────────────────────────────────────┐
│                       你的应用程序                           │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│  libvips_ffi  │    │libvips_ffi_   │    │libvips_ffi_   │
│   (Flutter)   │    │   desktop     │    │   system      │
└───────────────┘    └───────────────┘    └───────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              ▼
                    ┌───────────────┐
                    │libvips_ffi_api│
                    └───────────────┘
                              │
                              ▼
                    ┌───────────────┐
                    │libvips_ffi_   │
                    │     core      │
                    └───────────────┘
```

## 包摘要

| 包名 | 类型 | 描述 |
|------|------|------|
| **libvips_ffi** | Flutter 插件 | Android/iOS 主包，含预编译库 |
| **libvips_ffi_api** | Dart | 高级 Pipeline API |
| **libvips_ffi_core** | Dart | 底层 FFI 绑定 |
| **libvips_ffi_desktop** | Flutter 插件 | 所有桌面平台的元包 |
| **libvips_ffi_macos** | Flutter 插件 | macOS 预编译库 |
| **libvips_ffi_windows** | Flutter 插件 | Windows 预编译库 |
| **libvips_ffi_linux** | Flutter 插件 | Linux 预编译库 |
| **libvips_ffi_loader** | Dart | 动态库加载器 |
| **libvips_ffi_system** | Dart | 系统库查找器 |

## 选择正确的包

### Flutter 移动端 (Android/iOS)

```yaml
dependencies:
  libvips_ffi: ^0.1.0
```

### Flutter 桌面端 (所有平台)

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_desktop: ^0.1.0
```

### Flutter 桌面端 (特定平台)

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_macos: ^0.1.0+8.17.0  # 仅 macOS
```

### 纯 Dart 使用系统 libvips

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_system: ^0.1.0
```

### 纯 Dart 使用自定义库路径

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_loader: ^0.1.0
```

## 版本规则

包遵循语义化版本，带有 libvips 版本后缀：

```text
<包版本>+<libvips版本>
```

例如：`0.1.0+8.17.0` 表示：

- 包版本：0.1.0
- 捆绑的 libvips 版本：8.17.0

## libvips 版本

不同平台可能捆绑不同的 libvips 版本：

| 平台 | libvips 版本 |
|------|--------------|
| Android | 8.16.0 |
| iOS | 8.16.0 |
| macOS | 8.17.0 |
| Windows | 8.17.3 |
| Linux | (使用系统库) |

## 下一步

- [libvips_ffi](./libvips_ffi) - 移动端包详情
- [libvips_ffi_api](./libvips_ffi_api) - API 包详情
- [libvips_ffi_core](./libvips_ffi_core) - 核心绑定详情
