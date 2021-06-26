import 'package:contactor_picker_example/data_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:contactor_picker/contactor_picker.dart';

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
  }

  late String _currentData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                ContactorPicker.showPicker(
                  context,
                  dataList: DataUtil.dataList.map((element) {
                    String pinyin = PinyinHelper.getPinyinE(element['name'],
                        separator: " ",
                        defPinyin: '#',
                        format: PinyinFormat.WITHOUT_TONE);
                    return ContactorDataListData(
                      name: element['name'],
                      id: int.tryParse(element['zip']),
                      groupCode: pinyin,
                      code: element['label']
                    );
                  }).toList(),
                  title: '地址簿',
                  backgroundColor: Color(0xFFFAFAFA),
                  letterSelectedColor: Colors.blueAccent,
                  onSelectedData: (data) {
                    print(data.toJson());
                    _currentData = data.toJson().toString();
                    setState(() {});
                  },
                );
              },
              child: Text('地址簿'),
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
