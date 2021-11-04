/*
 * @author admin.
 * @date: 2021/6/24 4:42 下午
 * @description: flutter
 */

import 'package:flutter/material.dart';

class SearchBarView extends StatelessWidget {
  ///点击searchbar回调
  final Function  onTap;

  ///输入框提示文字
  final String  placeholder;

  ///输入框提示颜色
  final Color  placeholderColor;

  ///输入框是否只读
  final bool readOnly;

  ///输入框聚焦模式
  final FocusNode  focusNode;

  ///输入框输入内容
  final Function(String)  onChanged;

  ///间距
  final EdgeInsets  padding;

  const SearchBarView({
    Key key,
    this.onTap,
    this.placeholder,
    this.placeholderColor,
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.padding,
  }) : super(key: key);

  OutlineInputBorder get _border => OutlineInputBorder(
        /*边角*/
        borderRadius: BorderRadius.all(
          Radius.circular(6), //边角为5
        ),
        borderSide: BorderSide.none,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: padding,
      child: TextField(
        focusNode: focusNode,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minHeight: 30,
            minWidth: 30,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: placeholderColor ?? Color(0xFFC2C6CC),
            size: 20,
          ),
          fillColor: placeholderColor ?? Color(0xFFF2F3F5),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: placeholder ?? '搜索',
          focusedBorder: _border,
          enabledBorder: _border,
        ),
        onTap: () {
          onTap?.call();
        },
        onChanged: (value) {
          onChanged?.call(value);
        },
        readOnly: readOnly,
      ),
    );
  }
}
