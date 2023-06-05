import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter_note_app/models/note.dart';
import 'package:node_flutter_note_app/pages/add_new_note.dart';
import 'package:node_flutter_note_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: (notesProvider.notes.length > 0)
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: notesProvider.notes.length,
                itemBuilder: (context, index) {
                  Note currentNote = notesProvider.notes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AddNewNote(
                            isUpdate: true,
                            note: currentNote,
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      notesProvider.deleteNote(currentNote);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.lightBlue.shade50, width: 2),
                          color: Colors.lightBlue.shade50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentNote.title!,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            currentNote.content!,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No notes yet'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddNewNote(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
