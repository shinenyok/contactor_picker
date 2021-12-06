/*
 * @author admin.
 * @date: 2021/6/22 3:55 下午
 * @description: flutter
 */

///数据模型
class ContactorCodeData {
  ///分类数组
  List<ContactorDataListData> listData = [];

  ///分类标签
  String name = '';

  ContactorCodeData({required this.listData, required this.name});

  ContactorCodeData.fromJson(Map<String, dynamic> json) {
    if (json['listData'] != null) {
      listData = <ContactorDataListData>[];
      (json['listData'] as List).forEach((v) {
        listData.add(new ContactorDataListData.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listData'] = this.listData.map((v) => v.toJson()).toList();
    data['name'] = this.name;
    return data;
  }
}

class ContactorDataListData {
  ///id
  int? id = -1;

  ///code
  String? code = '';

  ///拼音
  String? pinyin = '';

  ///标题内容
  String name = '';

  ///附加标题
  String groupCode = '';

  ///头像链接 有则预留位置显示头像 否则不显示
  String? headerImageUrl = '';

  ContactorDataListData({
    this.id,
    this.code,
    this.pinyin,
    this.headerImageUrl,
    required this.name,
    required this.groupCode,
  });

  ContactorDataListData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    id = json['id'];
    pinyin = json['pinyin'];
    groupCode = json['groupCode'];
    headerImageUrl = json['headerImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['id'] = this.id;
    data['pinyin'] = this.pinyin;
    data['groupCode'] = this.groupCode;
    data['headerImageUrl'] = this.headerImageUrl;
    return data;
  }
}
