import 'package:contactor_picker_example/data_util.dart';
import 'package:flutter/material.dart';
import 'package:contactor_picker/contactor_picker.dart';
import 'package:lpinyin/lpinyin.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('length----${DataUtil.dataList.length}');
  }

  String _currentData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      // body: ContactorView(
      //   dataList: DataUtil.dataList.map((element) {
      //     String pinyin = PinyinHelper.getPinyinE(element['name'],
      //         separator: " ",
      //         defPinyin: '#',
      //         format: PinyinFormat.WITHOUT_TONE);
      //     return ContactorDataListData(
      //       name: element['name'],
      //       id: int.tryParse(element['zip']),
      //       pinyin: pinyin,
      //       headerImageUrl: 'https://picsum.photos/250?image=9',
      //       code: element['label'],
      //       groupCode: element['zip'],
      //     );
      //   }).toList(),
      //   canPop: false,
      //   onSelectedData: (ContactorDataListData data) {
      //     print('${data.toString()}');
      //   },
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                ContactorPicker.showPicker(
                  context,
                  showGroupCode: true,
                  dataList: DataUtil.dataList.map((element) {
                    String pinyin = PinyinHelper.getPinyinE(element['name'],
                        separator: "",
                        defPinyin: '#',
                        format: PinyinFormat.WITHOUT_TONE);
                    return ContactorDataListData(
                      name: element['name'],
                      id: int.tryParse(element['zip']),
                      pinyin: pinyin,
                      // headerImageUrl: 'https://picsum.photos/250?image=9',
                      code: element['label'],
                      groupCode: element['zip'],
                    );
                  }).toList(),
                  title: '地址簿',
                  extendWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        child: Text('666666'),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text('555555'),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Text('888888'),
                        ),
                      )
                    ],
                  ),
                  // backgroundColor: Color(0xFFFAFAFA),
                  letterSelectedColor: Colors.blueAccent,
                  onSelectedData: (data, pageNum) {
                    print(data.toJson());
                    _currentData = data.toJson().toString();
                    setState(() {});
                  },
                );
              },
              child: Text('地址簿'),
            ),
            TextButton(
              onPressed: () {
                ContactorPicker.showSearchPicker(
                  context,
                  showGroupCode: true,
                  dataList: DataUtil.dataList.map((element) {
                    String pinyin = PinyinHelper.getPinyinE(element['name'],
                        separator: " ",
                        defPinyin: '#',
                        format: PinyinFormat.WITHOUT_TONE);
                    return ContactorDataListData(
                      name: element['name'],
                      id: int.tryParse(element['zip']),
                      pinyin: pinyin,
                      code: element['label'],
                      groupCode: element['zip'],
                    );
                  }).toList(),
                  backgroundColor: Color(0xFFFAFAFA),
                  onSelectedData: (data, pageNum) {
                    print(data.toJson());
                    _currentData = data.toJson().toString();
                    setState(() {});
                  },
                );
              },
              child: Text('搜索'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('currentData: $_currentData\n'),
            ),
          ],
        ),
      ),
    );
  }
}
