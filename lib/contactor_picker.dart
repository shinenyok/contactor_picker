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
    String? title,
    Color? backgroundColor,
    Color? letterSelectedColor,
    bool? showGroupCode,
    required List<ContactorDataListData> dataList,
    required Function(ContactorDataListData) onSelectedData,
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
        Color? backgroundColor,
        bool? showGroupCode,
        required List<ContactorDataListData> dataList,
        required Function(ContactorDataListData) onSelectedData,
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
