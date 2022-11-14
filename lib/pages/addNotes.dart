import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/providers/notesProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/notes.dart';

class addNewNote extends StatefulWidget {
  const addNewNote({Key? key}) : super(key: key);

  @override
  State<addNewNote> createState() => _addNewNoteState();
}

class _addNewNoteState extends State<addNewNote> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  void newNote() {
    Note newNote = Note(
      id: Uuid().v1(),
      userid: "anshu@abc.com",
      title: titleEditingController.text,
      content: noteEditingController.text,
      dateadded: DateTime.now(),
    );
    Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add notes page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                newNote();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            children: [
              TextField(
                controller: titleEditingController,
                onSubmitted: (value) {
                  if (value != "") {
                    focusNode.requestFocus();
                  }
                },
                autofocus: true,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  hintText: "title",
                ),
              ),
              Expanded(
                child: TextField(
                  controller: noteEditingController,
                  focusNode: focusNode,
                  maxLines: null,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "notes",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
