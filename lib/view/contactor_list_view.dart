/*
 * @author admin.
 * @date: 2021/6/24 8:37 下午
 * @description: flutter
 */

import 'package:contactor_picker/model/contactor_model.dart';
import 'package:flutter/material.dart';

class ContactorListView extends StatelessWidget {
  final List<ContactorDataListData> dataList;
  final Function(ContactorDataListData) onSelectedData;
  final bool shrinkWrap;
  final bool scrollEnabled;
  const ContactorListView({
    Key? key,
    required this.dataList,
    required this.onSelectedData,
    this.shrinkWrap = false,
    this.scrollEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              height: 45,
              child: TextButton(
                onPressed: () {
                  onSelectedData.call(dataList[index]);
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      "${dataList[index].name}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff434343),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${dataList[index].groupCode}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffD6D6D6),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        );
      },
      itemCount: dataList.length,
      shrinkWrap: shrinkWrap,
      physics: scrollEnabled ? null : NeverScrollableScrollPhysics(),
    );
  }
}
