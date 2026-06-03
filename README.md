# 聚财 (JuCai) - 个人资产组合管理

一款基于 Flutter 的个人资产组合管理应用，帮助用户全面追踪和管理个人资产、负债及现金流。

## 功能特性

- **资产总览仪表盘** — 总资产、总负债、净资产一目了然，资产分布饼图、月度收支趋势图
- **18 类资产管理** — 覆盖现金、股票、基金、债券、外汇、数字货币、贵金属、保险、股权投资、房产、商业地产、养老金、汽车、电子产品、家具、收藏品等
- **负债管理** — 房贷、车贷、信用卡等负债追踪，含利率、月供、剩余期数
- **现金流管理** — 收入/支出记录，支持一次性与周期性（月度）记录，月度收支汇总
- **数据可视化** — fl_chart 驱动的饼图和折线图
- **应用锁屏** — 4 位密码保护，SHA-256 哈希存储
- **国际化** — 简体中文 / 繁体中文 / 日本語 / English
- **数据导出** — JSON 格式导出全部资产数据
- **种子数据** — 首次启动自动生成示例数据，开箱即用

## 技术栈

| 层级 | 技术 |
|------|------|
| 框架 | Flutter 3.44+ (Dart 3.12+) |
| 数据库 | SQLite (sqflite) |
| 状态管理 | Provider |
| 图表 | fl_chart |
| 国际化 | flutter_localizations + l10n |
| 本地存储 | shared_preferences |

## 项目结构

```
lib/
├── main.dart                    # 应用入口
├── database/
│   └── database_helper.dart     # 数据库初始化、迁移、CRUD、种子数据
├── models/                      # 数据模型
│   ├── asset.dart
│   ├── asset_type.dart
│   ├── asset_value_history.dart
│   ├── cash_flow.dart
│   ├── investment_return.dart
│   ├── liability.dart
│   └── user.dart
├── providers/                   # Provider 状态管理
│   ├── asset_provider.dart
│   ├── cash_flow_provider.dart
│   ├── dashboard_provider.dart
│   ├── liability_provider.dart
│   ├── locale_provider.dart
│   ├── password_provider.dart
│   └── user_provider.dart
├── screens/                     # 页面
│   ├── home_screen.dart         # 底部导航 + IndexedStack
│   ├── dashboard_screen.dart    # 仪表盘
│   ├── assets_screen.dart       # 资产列表
│   ├── liabilities_screen.dart  # 负债列表
│   ├── cash_flow_screen.dart    # 现金流
│   ├── asset_types_screen.dart  # 资产类型管理
│   ├── settings_screen.dart     # 设置
│   ├── about_screen.dart        # 关于
│   └── lock_screen.dart         # 锁屏
├── widgets/
│   └── forms/
│       └── asset_form.dart      # 资产表单组件
├── l10n/                        # 国际化翻译文件
└── utils/
    ├── constants.dart           # 常量、资产类型定义、分类标签
    └── formatters.dart          # 货币格式化
```

## 数据库 Schema (v3)

共 7 张表：`users`、`asset_types`、`assets`、`liabilities`、`cash_flows`、`asset_value_history`、`investment_returns`

资产分为三大类：
- **流动资产 (liquid)** — 现金、存款、股票、基金、债券、外汇、数字货币、贵金属、保险、股权投资
- **固定资产 (fixed)** — 房产、商业地产、养老金
- **消费品 (consumer)** — 汽车(折旧15%/年)、电子产品(折旧30%/年)、家具(折旧10%/年)、收藏品

## 开发环境

```bash
# 克隆项目
git clone <repo-url>
cd fpersonasset

# 安装依赖
flutter pub get

# Web 端需初始化 sqlite wasm（首次）
dart run sqflite_common_ffi_web:setup

# 运行 (Chrome)
flutter run -d chrome

# 运行 (Windows 桌面，需 Visual Studio C++ 工具链)
flutter run -d windows

# 运行 (Android)
flutter run -d <device>
```

## 版本历史

- **v2.0.0** — 扩展资产类型至 18 类 + 应用锁屏密码功能
- **v1.0.0** — 初始版本：国际化支持 + 种子数据 + 现金流周期 + 关于页面
