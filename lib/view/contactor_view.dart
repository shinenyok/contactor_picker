/*
 * @author admin.
 * @date: 2021/6/23 9:40 上午
 * @description: flutter
 */

import 'dart:math';

import 'package:contactor_picker/model/contactor_model.dart';
import 'package:contactor_picker/view/item.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'contactor_list_view.dart';
import 'contactor_search_view.dart';
import 'search_bar_view.dart';

///带分类标签的列表widget
class ContactorView extends StatefulWidget {
  ///选中回调
  final Function(ContactorDataListData, int) onSelectedData;

  ///数据源
  final List<ContactorDataListData> dataList;

  ///标题
  final String title;

  ///字母表选中色
  final Color? letterSelectedColor;

  ///背景色
  final Color? backgroundColor;

  ///是否显示副标题
  final bool? showGroupCode;

  ///是否可以返回
  final bool canPop;

  final Widget? extendWidget;

  const ContactorView({
    Key? key,
    required this.onSelectedData,
    required this.dataList,
    this.extendWidget,
    this.title = '选择联系人',
    this.letterSelectedColor,
    this.showGroupCode,
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.canPop = true,
  }) : super(key: key);

  @override
  _ContactorViewState createState() => _ContactorViewState();
}

class _ContactorViewState extends State<ContactorView> {
  ///将数据源封装成按字母分类分类数据源
  List<ContactorCodeData> data = [];

  ///数据源
  List<ContactorDataListData> _dataList = [];

  ///滑动controller
  ScrollController _controller = ScrollController();

  ///当前显示字母index
  int _currentIndex = 0;

  ///字母表
  List<String> _letters = [];

  ///字母在列表上偏移量位置map
  Map<String, double> _letterOffsetMap = {};

  ///偏移量列表
  List<double> _offsetList = [];

  @override
  void initState() {
    super.initState();
    configData();
    _controller.addListener(() {
      double offset = _controller.offset;
      double element =
          _offsetList.firstWhere((element) => element >= offset, orElse: () {
        return offset;
      });
      if (_offsetList.indexOf(element) == 0) {
        _currentIndex = 0;
      } else if (element > _offsetList.last) {
        _currentIndex = _offsetList.length - 1;
      } else {
        _currentIndex = _offsetList.indexOf(element) - 1;
      }
      setState(() {});
    });
  }

  void configData() {
    widget.dataList.forEach((element) {
      String pinyin = PinyinHelper.getPinyinE(element.name,
          separator: "", defPinyin: '#', format: PinyinFormat.WITHOUT_TONE);
      if (!_letters.contains(pinyin[0].toUpperCase())) {
        _letters.add(pinyin[0].toUpperCase());
      }
    });
    _letters.sort((a, b) {
      return a.compareTo(b);
    });
    double _offset = 0.0;
    _letterOffsetMap.putIfAbsent(_letters.first, () => _offset);
    _letters.forEach((element) {
      List<ContactorDataListData> codeList = widget.dataList
          .where((e) => (e.pinyin ?? '').startsWith(element.toLowerCase()))
          .toList();
      _dataList.addAll(codeList);
      ContactorCodeData codeData =
          ContactorCodeData(listData: codeList, name: element);
      if (codeList.isNotEmpty) {
        data.add(codeData);
      }
      int index = _letters.indexOf(element) + 1;
      if (index < _letters.length) {
        _offset = _offset + (1 + codeList.length) * 46.0;
        _letterOffsetMap.putIfAbsent(_letters.elementAt(index), () => _offset);
      }
    });
    _offsetList = _letterOffsetMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.canPop
          ? AppBar(
              title: Text(
                widget.title,
                style: TextStyle(fontSize: 17),
              ),
              centerTitle: true,
            )
          : null,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SearchBarView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                readOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactorSearchView(
                        listData: _dataList,
                        showGroupCode: widget.showGroupCode,
                        onSelectedData: widget.onSelectedData,
                        onlyShowSearch: !widget.canPop,
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              Flexible(
                child: ListView.builder(
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return Item(
                      header: headerItem(index),
                      content: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: ContactorListView(
                          showGroupCode: widget.showGroupCode,
                          shrinkWrap: true,
                          scrollEnabled: false,
                          dataList: data[index].listData,
                          onSelectedData: (data) {
                            if (widget.canPop) {
                              Navigator.pop(context);
                            }
                            widget.onSelectedData(data, 1);
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
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
      padding: EdgeInsets.only(left: 16),
      height: 46,
      color: widget.backgroundColor,
      alignment: Alignment.centerLeft,
      child: Text(
        data[index].name.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          color: _currentIndex == index
              ? (widget.letterSelectedColor ?? Colors.blueAccent)
              : Color(0xff434343),
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
                  double height = _letterOffsetMap[data[index].name] ?? 0;
                  _controller.jumpTo(height);
                  _currentIndex = index;
                  setState(() {});
                },
                child: Text(
                  e,
                  style: TextStyle(
                    color: _currentIndex == index
                        ? (widget.letterSelectedColor ?? Colors.blueAccent)
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
