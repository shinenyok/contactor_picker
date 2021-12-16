# contactor_picker

联系人选择器

## Getting Started
#### 1 Add [contactor_picker] latest version under dependencies to your package's pubspec.yaml file. 
```
dependencies:
  contactor_picker: ^0.0.7
```
#### 2 You can install packages from the command line: 
```
$ flutter packages get
```
#### 3 Api Usage 
* Usage
```
///列表加搜索
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
```
///支持嵌入其他Widget  详见example
 return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ContactorView(
        ///数据源
        dataList: DataUtil.dataList.map((element) {
          String pinyin = PinyinHelper.getPinyinE(element['name'],
              separator: " ",
              defPinyin: '#',
              format: PinyinFormat.WITHOUT_TONE);
          return ContactorDataListData(
            name: element['name'],
            id: int.tryParse(element['zip']),
            pinyin: pinyin,
            headerImageUrl: 'https://picsum.photos/250?image=9',
            code: element['label'],
            groupCode: element['zip'],
          );
        }).toList(),
        ///选中item时仅选中 不附带pop动作
        canPop: false,
        ///选中回调
        onSelectedData: (ContactorDataListData data) {
          print('${data.toString()}');
        },
      ),
  );

```


## 预览

![image](https://shineyoki.oss-cn-beijing.aliyuncs.com/demo.gif)
