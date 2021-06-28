# contactor_picker

联系人选择器

## Getting Started

```
ContactorPicker.showPicker(
                    context,
                    ///数据源
                    dataList: [],
                    ///是否展示code 默认不展示
                    showGroupCode: true,
                    ///选中数据
                    onSelectedData: (data) {

                    },
                    ///标题
                    title: '联系人',
                    ///页面背景色
                    backgroundColor: Color(0xFFFAFAFA),
                    ///当前字母颜色
                    letterSelectedColor: Colors.blueAccent,
                  );
```

```
///仅搜索
   ContactorPicker.showSearchPicker(
                    context,
                    ///是否展示code 默认不展示
                    showGroupCode: true,
                    ///不展示
                    dataList: [],
                    ///背景色
                    backgroundColor: Color(0xFFFAFAFA),
                    ///选中数据
                    onSelectedData: (data) {
                    },
                  );
```
## 预览

![image](https://shineyoki.oss-cn-beijing.aliyuncs.com/demo.gif)
