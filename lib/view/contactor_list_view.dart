/*
 * @author admin.
 * @date: 2021/6/24 8:37 下午
 * @description: flutter
 */

import 'package:contactor_picker/model/contactor_model.dart';
import 'package:flutter/material.dart';

///列表widget
class ContactorListView extends StatelessWidget {
  ///数据源列表
  final List<ContactorDataListData> dataList;

  ///选中回调
  final Function(ContactorDataListData) onSelectedData;

  /// If the [shrinkWrap] argument is true, the [center] argument must be null.
  final bool shrinkWrap;

  ///是否可滑动
  final bool scrollEnabled;

  ///是否显示副标题
  final bool? showGroupCode;

  const ContactorListView({
    Key? key,
    required this.dataList,
    required this.onSelectedData,
    this.shrinkWrap = false,
    this.scrollEnabled = true,
    this.showGroupCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      shrinkWrap: shrinkWrap,
      physics: scrollEnabled ? null : NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 16, top: 0, bottom: 0),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 46,
          child: TextButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            onPressed: () {
              onSelectedData.call(dataList[index]);
            },
            icon: dataList[index].headerImageUrl == null
                ? SizedBox.shrink()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      dataList[index].headerImageUrl!,
                      width: 40,
                      height: 40,
                    ),
                  ),
            label: Column(
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${dataList[index].name}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff434343),
                      ),
                    ),
                    SizedBox(width: 10),
                    showGroupCode == true
                        ? Text(
                            "${dataList[index].groupCode}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffD6D6D6),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                Spacer(),
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
