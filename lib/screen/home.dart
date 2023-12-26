import 'package:flutter/material.dart';

import '../confg/database.dart';
import '../model/note_details_model.dart';
import '../model/notes_model.dart';
import '../widget/notes_widgets.dart';
import 'add_note.dart';
import 'note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final database = AppDatabase();
  List<TodoItem> notes = [];

  Future readData() async {
    notes = await database.select(database.todoItems).get();
    if(mounted){
      setState(() {

      });
    }
    print(notes);
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNote(),));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(notes.length, (index) {
              return Column(
                  children: [
                  SizedBox(
                  height: mediaQuery(context, 0) * 0.05,
              ),
              GestureDetector(
              onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(
                      noteDetailsModel: NoteDetailsModel(
                          id: notes[index].id,
                          title: TextEditingController(text: notes[index].title),
                          subTitle: TextEditingController(text: notes[index].content,

                          ), date: '', time: '',
                          ),
                    ),
                  ));
              },
              child: BuildNotesWidget(
              title: notes[index].title,
              subTitle: notes[index].content,
              date: '${dateTime.day} - ${dateTime.month} - ${dateTime.year}',
              time: '${dateTime.hour} - ${dateTime.minute} - ${dateTime.second}',
              ),
              ),
              ]
              ,
              );
            }),
          ),
        ),
      ),
    );
  }
}

double mediaQuery(BuildContext context, int number) {
  return number == 0
      ? MediaQuery
      .of(context)
      .size
      .height
      : MediaQuery
      .of(context)
      .size
      .width;
}
