import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactor_picker/model/contactor_model.dart';
import 'package:contactor_picker/view/contactor_view.dart';
export 'package:contactor_picker/view/contactor_view.dart';
export 'package:contactor_picker/view/contactor_search_view.dart';
export 'package:contactor_picker/model/contactor_model.dart';
export 'package:lpinyin/lpinyin.dart';

class ContactorPicker {

  static const MethodChannel _channel = const MethodChannel('contactor_picker');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static showPicker(
    BuildContext context, {
    required List<ContactorDataListData> dataList,
    required Function(ContactorDataListData) onSelectedData,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ContactorView(
            onSelectedData: onSelectedData,
            dataList: dataList,
          );
        },
      ),
    );
  }
}
