import 'package:flutter/material.dart';

class Notes {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;
  Notes({this.content, this.dateadded, this.id, this.title, this.userid});
  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
        id: map['id'],
        userid: map['userid'],
        title: map['title'],
        dateadded: DateTime.tryParse(map['dateadded']),
        content: map['content']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      "content": content,
      'dateadded': dateadded!.toIso8601String()
    };
  }
}
