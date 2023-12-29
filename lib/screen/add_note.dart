import 'package:flutter/material.dart';

import '../confg/database.dart';
import 'home.dart';


class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerGraph = TextEditingController();
  bool checkTitle = false;
  bool checkGraph = false;
  DateTime dateTime = DateTime.now();
  late final AppDatabase database;

  @override
  void initState() {
    database = AppDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
                title: _controllerTitle.text,
                content: _controllerGraph.text,
              ));
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
              Icons.add,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _controllerTitle,
            onTap: () {
              setState(() {
                checkTitle = true;
              });
            },
            style: TextStyle(fontSize: mediaQuery(context, 1) * 0.1),
            maxLines: 1,
            decoration: InputDecoration(
                label: checkTitle
                    ? null
                    : Text(
                        'Title',
                        style:
                            TextStyle(fontSize: mediaQuery(context, 1) * 0.1),
                      ),
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
                Text('${dateTime.day} - ${dateTime.month} - ${dateTime.year}'),
                Text(
                    '${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}'),
              ],
            ),
          ),
          TextFormField(
            controller: _controllerGraph,
            onTap: () {
              setState(() {
                checkGraph = true;
              });
            },
            maxLines: checkGraph ? 10 : 2,
            decoration: InputDecoration(
                label: checkGraph
                    ? null
                    : const Text(
                        'write ...',
                      ),
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
