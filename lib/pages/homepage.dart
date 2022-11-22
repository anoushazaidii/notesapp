import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/pages/addNotes.dart';
import 'package:notesapp/providers/notesProvider.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("notes app"),
        centerTitle: true,
      ),
      body: noteProvider.isLoading == false
          ? SafeArea(
              child: (noteProvider.notes.length > 0)
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: noteProvider.notes.length,
                      itemBuilder: (context, index) {
                        Note currentNote = noteProvider.notes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addNewNote(
                                          isUpdate: true,
                                          note: currentNote,
                                        )));
                          },
                          onLongPress: () {
                            noteProvider.deleteNote(currentNote);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentNote.title!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(currentNote.content!)
                                ]),
                          ),
                        );
                      },
                    )
                  : Center(child: Text("No notes yet")))
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const addNewNote(isUpdate: false)));
          }),
    );
  }
}
