import 'package:flutter/cupertino.dart';

class SearchModel {
  String data;
  SearchModel({@required this.data});
  Map<String, String> toMap(SearchModel data) {
    return Map<String, String>()..["data"] = data.data;
  }

  static String formJson(Map<String, dynamic> json) {
    return json["data"];
  }
}
