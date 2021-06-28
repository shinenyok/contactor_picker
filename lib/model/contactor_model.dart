/*
 * @author admin.
 * @date: 2021/6/22 3:55 下午
 * @description: flutter
 */

class ContactorCodeData {
  List<ContactorDataListData> listData = [];
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
  int? id;
  String? code;
  String? pinyin = '';
  String name = '';
  String groupCode = '';
  ContactorDataListData({
    this.id,
    this.code,
    this.pinyin,
    required this.name,
    required this.groupCode,
  });

  ContactorDataListData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    id = json['id'];
    pinyin = json['pinyin'];
    groupCode = json['groupCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['id'] = this.id;
    data['pinyin'] = this.pinyin;
    data['groupCode'] = this.groupCode;
    return data;
  }
}
