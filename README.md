# contactor_picker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### contactor_picker
联系人选择器

## 使用方法
```
ContactorPicker.showPicker(
                    context,
                    ///数据源
                    dataList: [],
                    ///选中数据
                    onSelectedData: (data) {

                    },
                  );
```