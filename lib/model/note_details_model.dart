import 'package:flutter/cupertino.dart';

class NoteDetailsModel {
  final int id;
  final TextEditingController title;
  final TextEditingController subTitle;
  final String date;
  final String time;

  NoteDetailsModel(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.time});
}
