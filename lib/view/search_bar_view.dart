/*
 * @author admin.
 * @date: 2021/6/24 4:42 下午
 * @description: flutter
 */

import 'package:flutter/material.dart';

class SearchBarView extends StatelessWidget {
  final Function? onTap;
  final String? placeholder;
  final Color? placeholderColor;
  final bool readOnly;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final EdgeInsets? padding;

  const SearchBarView({
    Key? key,
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
          Radius.circular(20), //边角为5
        ),
        borderSide: BorderSide.none,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: padding,
      child: TextField(
        focusNode: focusNode,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: placeholderColor ?? Colors.black12,
          ),
          fillColor: placeholderColor ?? Colors.black12,
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
