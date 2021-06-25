/*
 * @author admin.
 * @date: 2021/6/23 9:40 上午
 * @description: flutter
 */


import 'package:contactor_picker/model/contactor_model.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'contactor_list_view.dart';
import 'contactor_search_view.dart';
import 'search_bar_view.dart';

class ContactorView extends StatefulWidget {
  final Function(ContactorDataListData) onSelectedData;
  final List<ContactorDataListData> dataList;

  const ContactorView({
    Key? key,
    required this.onSelectedData,
    required this.dataList,
  }) : super(key: key);

  @override
  _ContactorViewState createState() => _ContactorViewState();
}

class _ContactorViewState extends State<ContactorView> {
  List<ContactorCodeData>? data = [];
  List<ContactorDataListData> _dataList = [];
  ScrollController _controller = ScrollController();
  int? _currentIndex;
  List<String> _letters = [];
  double _offset = 1.0;

  @override
  void initState() {
    super.initState();
    configData();
  }

  void configData() {
    widget.dataList.forEach((element) {
      String pinyin = PinyinHelper.getPinyinE(element.name,
          separator: " ", defPinyin: '#', format: PinyinFormat.WITHOUT_TONE);
      if (!_letters.contains(pinyin[0].toUpperCase())) {
        _letters.add(pinyin[0].toUpperCase());
      }
    });
    _dataList.addAll(widget.dataList);
    _letters.sort((a, b) {
      return a.compareTo(b);
    });
    _letters.forEach((element) {
      List<ContactorDataListData> codeList = _dataList
          .where((e) => e.groupCode.startsWith(element.toLowerCase()))
          .toList();
      ContactorCodeData codeData =
          ContactorCodeData(listData: codeList, name: element);
      if (codeList.isNotEmpty) {
        data!.add(codeData);
      }
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择员工'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SearchBarView(
                readOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactorSearchView(
                              listData: _dataList,
                              onSelectedData: widget.onSelectedData,
                            ),
                        fullscreenDialog: true),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data!.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return VisibilityDetector(
                      key: Key(index.toString()),
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (!mounted) {
                          return;
                        }
                        if (_offset == 1.0) {
                          return;
                        }
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: StickyHeader(
                        callback: (offsets) {
                          if (!mounted) {
                            return;
                          }
                          _offset = offsets;
                        },
                        header: headerItem(index),
                        content: ContactorListView(
                          shrinkWrap: true,
                          scrollEnabled: false,
                          dataList: data![index].listData,
                          onSelectedData: (data) {
                            widget.onSelectedData(data);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: lettersWidget(),
          ),
        ],
      ),
    );
  }

  ///字母header
  Widget headerItem(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      height: 45,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        data![index].name.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          color: _currentIndex == index ? Colors.blueAccent : Color(0xff434343),
        ),
      ),
    );
  }

  ///字母排序列表
  Widget lettersWidget() {
    return Container(
      width: 25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _letters.map(
          (e) {
            int index = _letters.indexOf(e);
            return SizedBox(
              height: 16,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  var height = index * 45.0;
                  for (int i = 0; i < index; i++) {
                    height += data![i].listData.length * 46.0;
                  }
                  _controller.jumpTo(height);
                  _currentIndex = index;
                  setState(() {});
                },
                child: Text(
                  e,
                  style: TextStyle(
                    color: _currentIndex == index
                        ? Colors.blueAccent
                        : Color(0xff434343),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
