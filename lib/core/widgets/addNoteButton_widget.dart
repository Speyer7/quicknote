import 'package:flutter/material.dart';
import 'package:quicknote/core/data/note.dart';
import 'package:quicknote/core/data/notes_database.dart';

class AddnotebuttonWidget extends StatefulWidget {
  final void Function()? onNoteAdded;

  const AddnotebuttonWidget({super.key, this.onNoteAdded});

  @override
  State<AddnotebuttonWidget> createState() =>
      _AddnotebuttonWidgetState();
}

class _AddnotebuttonWidgetState
    extends State<AddnotebuttonWidget> {
  final TextEditingController _titleController =
      TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();

  void _openNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                maxLength: 300,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty) {
                  if(_descriptionController.text.isEmpty) {
                    _descriptionController.text = "No description provided";
                  }
                  final newNote = Note(
                    title: _titleController.text,
                    description:
                        _descriptionController.text,
                  );
                  await NotesDatabase.instance.create(
                    newNote,
                  );
                  if (widget.onNoteAdded != null) {
                    widget.onNoteAdded!();
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    ).then((_) {
      _clearControllers();
    });
  }

  void _clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _openNoteDialog();
      },
      elevation: 3,
      child: Icon(Icons.add),
    );
  }
}
