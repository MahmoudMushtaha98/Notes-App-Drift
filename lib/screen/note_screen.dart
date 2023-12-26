import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../confg/database.dart';
import '../model/note_details_model.dart';
import 'home.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    super.key,
    required this.noteDetailsModel,
  });

  final NoteDetailsModel noteDetailsModel;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final database = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await database.delete(database.todoItems).delete(TodoItem(
                  id: widget.noteDetailsModel.id,
                  title: widget.noteDetailsModel.title.text,
                  content: widget.noteDetailsModel.subTitle.text));
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false);
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
          IconButton(
            onPressed: () async {
              await database.update(database.todoItems).replace(TodoItem(
                  id: widget.noteDetailsModel.id,
                  title: widget.noteDetailsModel.title.text,
                  content: widget.noteDetailsModel.subTitle.text));
              if(mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false);
              }
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: widget.noteDetailsModel.title,
            style: TextStyle(fontSize: mediaQuery(context, 1) * 0.1),
            maxLines: 1,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.noteDetailsModel.date),
                Text(widget.noteDetailsModel.time),
              ],
            ),
          ),
          TextFormField(
            controller: widget.noteDetailsModel.subTitle,
            maxLines: 10,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor))),
          ),
        ],
      ),
    );
  }
}
