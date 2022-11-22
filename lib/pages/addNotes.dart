import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/providers/notesProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/notes.dart';

class addNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const addNewNote({Key? key, required this.isUpdate, this.note})
      : super(key: key);

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

  void updateNote() {
    widget.note!.title = titleEditingController.text;
    widget.note!.content = noteEditingController.text;
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleEditingController.text = widget.note!.title!;
      noteEditingController.text = widget.note!.content!;
    }
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
                widget.isUpdate ? updateNote() : newNote();
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
                autofocus: (widget.isUpdate) ? false : true,
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
