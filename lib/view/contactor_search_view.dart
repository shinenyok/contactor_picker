/*
 * @author admin.
 * @date: 2021/6/23 11:21 上午
 * @description: flutter
 */

import 'package:contactor_picker/model/contactor_model.dart';
import 'package:flutter/material.dart';
import 'contactor_list_view.dart';
import 'search_bar_view.dart';

///搜索列表widget
class ContactorSearchView extends StatefulWidget {
  ///数据源
  final List<ContactorDataListData> listData;

  ///选中回调
  final Function(ContactorDataListData,int) onSelectedData;

  ///背景色
  final Color backgroundColor;

  ///是否显示副标题
  final bool showGroupCode;

  ///是否仅搜索 若是则返回一级界面 否则返回两级界面
  final bool onlyShowSearch;

  ContactorSearchView({
    Key key,
    @required this.listData,
    @required this.onSelectedData,
    this.showGroupCode,
    this.onlyShowSearch,
    this.backgroundColor = const Color(0xFFFAFAFA),
  }) : super(key: key);

  @override
  _ContactorSearchViewState createState() => _ContactorSearchViewState();
}

class _ContactorSearchViewState extends State<ContactorSearchView> {
  List<ContactorDataListData> data = [];
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    data = widget.listData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SearchBarView(
                        padding: EdgeInsets.only(left: 20),
                        focusNode: _focusNode,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            data = widget.listData
                                .where(
                                  (element) => element.name.contains(value),
                                )
                                .toList();
                            Iterable pinyinList = widget.listData.where(
                              (element) => (element.pinyin).contains(value),
                            );
                            data.addAll(pinyinList);
                          } else {
                            data = widget.listData;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ContactorListView(
                  showGroupCode: widget.showGroupCode,
                  dataList: data,
                  onSelectedData: (item) {
                    _focusNode.unfocus();
                    if (!widget.onlyShowSearch) {
                      var count = 0;
                      num pages = 2;
                      Navigator.popUntil(
                        context,
                        (route) => count++ == pages,
                      );
                    }
                    widget.onSelectedData(item,2);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
