/*
 * @author admin.
 * @date: 2021/6/23 11:21 上午
 * @description: flutter
 */


import 'package:contactor_picker/model/contactor_model.dart';
import 'package:flutter/material.dart';

import 'contactor_list_view.dart';
import 'search_bar_view.dart';

class ContactorSearchView extends StatefulWidget {
  final List<ContactorDataListData> listData;
  final Function(ContactorDataListData) onSelectedData;

  ContactorSearchView({
    Key? key,
    required this.listData,
    required this.onSelectedData,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            focusNode: _focusNode,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  data = widget.listData
                      .where(
                        (element) => element.name.contains(value),
                  )
                      .toList();
                } else {
                  data = [];
                }
                setState(() {});
              },
            ),
        // Container(
        //   height: 40,
        //   margin: EdgeInsets.only(left: 25),
        //   child: TextField(
        //     maxLines: 1,
        //     focusNode: _focusNode,
        //     decoration: InputDecoration(
        //       prefixIcon: Icon(
        //         Icons.search,
        //         color: Colors.black12,
        //       ),
        //       hintText: '搜索员工',
        //       border: InputBorder.none,
        //       enabledBorder: OutlineInputBorder(
        //         /*边角*/
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(20), //边角为5
        //         ),
        //         borderSide: BorderSide.none,
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderSide: BorderSide.none,
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(25), //边角为30
        //         ),
        //       ),
        //       fillColor: Colors.black12,
        //       filled: true,
        //       isDense: true,
        //       contentPadding: EdgeInsets.zero,
        //     ),
        //     onChanged: (value) {
        //       if (value.isNotEmpty) {
        //         data = widget.listData
        //             .where(
        //               (element) => element.name.contains(value),
        //             )
        //             .toList();
        //       } else {
        //         data = [];
        //       }
        //       setState(() {});
        //     },
        //   ),
        // ),
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
    dataList: data,
    onSelectedData: (item) {
    _focusNode.unfocus();
    print('888q99w88q8w8w98---${item.name}');
    var count = 0;
    widget.onSelectedData(item);
    Navigator.popUntil(context, (route) => count++ == 2);
    }),
    )
    ],
    ),
    ),
    ),
    );
  }
}
