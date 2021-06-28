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
  final Color backgroundColor;
  final bool? showGroupCode;
  final bool? onlyShowSearch;

  ContactorSearchView({
    Key? key,
    required this.listData,
    required this.onSelectedData,
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
                          } else {
                            data = [];
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
                      var count = 0;
                      num pages = widget.onlyShowSearch == true ? 1 : 2;
                      widget.onSelectedData(item);
                      Navigator.popUntil(
                        context,
                        (route) => count++ == pages,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
