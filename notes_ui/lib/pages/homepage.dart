import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_ui/pages/add-new_notes.dart';
import 'package:notes_ui/provider/nodesprovider.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: (notesProvider.notes.length > 0)
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (context, index) {
                    Notes currentNote = notesProvider.notes[index];
                    return GestureDetector(
                      onTap: () {
                        ///update
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => AddNotes(
                                      isUpdate: true,
                                      note: currentNote,
                                    )));
                      },
                      onLongPress: () {
                        notesProvider.deleteNotes(currentNote);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentNote.title!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              currentNote.content!,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No notes yet'),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => AddNotes(
                        isUpdate: false,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
