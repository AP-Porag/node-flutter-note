import 'package:flutter/material.dart';
import 'package:node_flutter_note_app/models/note.dart';
import 'package:node_flutter_note_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNote({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  FocusNode noteFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: 'user ID',
      title: titleController.text,
      content: contentController.text,
      created_at: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                updateNote();
              } else {
                addNewNote();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              autofocus: (widget.isUpdate == true) ? false : true,
              controller: titleController,
              onSubmitted: (value) {
                if (value != '') {
                  noteFocus.requestFocus();
                }
              },
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  hintText: 'Title', border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                focusNode: noteFocus,
                controller: contentController,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                    hintText: 'Note', border: InputBorder.none),
              ),
            )
          ],
        ),
      )),
    );
  }
}
