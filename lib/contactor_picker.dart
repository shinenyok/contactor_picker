import 'dart:async';
import 'package:contactor_picker/view/contactor_search_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactor_picker/model/contactor_model.dart';
import 'package:contactor_picker/view/contactor_view.dart';
export 'package:contactor_picker/view/contactor_view.dart';
export 'package:contactor_picker/view/contactor_search_view.dart';
export 'package:contactor_picker/model/contactor_model.dart';
export 'package:lpinyin/lpinyin.dart';

///通讯录+搜索
class ContactorPicker {
  static showPicker(
    BuildContext context, {

    ///标题
    String title,

    ///背景色
    Color backgroundColor,

    ///字母选中颜色
    Color letterSelectedColor,

    ///副标题是否显示
    bool showGroupCode,

    ///数据源
    @required List<ContactorDataListData> dataList,

    ///数据选中回调
    @required Function(ContactorDataListData) onSelectedData,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ContactorView(
            showGroupCode: showGroupCode,
            title: title ?? '联系人',
            backgroundColor: backgroundColor ?? Color(0xFFFAFAFA),
            letterSelectedColor: letterSelectedColor,
            onSelectedData: onSelectedData,
            dataList: dataList,
          );
        },
      ),
    );
  }

  ///仅搜索
  static showSearchPicker(
    BuildContext context, {

    ///背景色
    Color backgroundColor,

    ///是否显示副标题
    bool showGroupCode,

    ///数据源
    @required List<ContactorDataListData> dataList,

    ///选中回调
    @required Function(ContactorDataListData) onSelectedData,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ContactorSearchView(
            showGroupCode: showGroupCode,
            backgroundColor: backgroundColor ?? Color(0xFFFAFAFA),
            onSelectedData: onSelectedData,
            listData: dataList,
            onlyShowSearch: true,
          );
        },
      ),
    );
  }
}
