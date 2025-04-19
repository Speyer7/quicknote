import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/data/note.dart';
import 'package:quicknote/core/data/notes_database.dart';
import 'package:quicknote/core/providers/text_size_provider.dart';
import 'package:quicknote/core/utils/get_font_size_from_level.dart';
import 'package:quicknote/core/widgets/addNoteButton_widget.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}


class _NotesScreenState extends ConsumerState<NotesScreen> {
  List<Note> notes = [];
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    final notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      _notes = notes;
    });
  }

  Widget _buildNoteCard(Note note, int index) {
    final textSizeLevel = ref.watch(textSizeProvider);
    final textSizeNormal = getFontSizeFromLevel(textSizeLevel, "normal"); 
    final textSizeBig = getFontSizeFromLevel(textSizeLevel, "big"); 
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(note.title, style: TextStyle(fontSize: textSizeBig, fontWeight: FontWeight.w500),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          note.isExpanded = !note.isExpanded;
                        });
                      },
                      icon: Icon(
                        note.isExpanded ? Icons.expand_more : Icons.expand_less,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final titleController = TextEditingController(
                          text: note.title,
                        );
                        final descriptionController = TextEditingController(
                          text: note.description,
                        );

                        final confirm = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text("Update Note"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: titleController,
                                      decoration: const InputDecoration(
                                        labelText: "Title",
                                      ),
                                      maxLength: 50,
                                    ),
                                    const SizedBox(height: 12.0),
                                    TextField(
                                      controller: descriptionController,
                                      decoration: const InputDecoration(
                                        labelText: "Description",
                                      ),
                                      maxLength: 300,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text("Update"),
                                  ),
                                ],
                              ),
                        );

                        if (confirm == true &&
                            titleController.text.isNotEmpty) {
                          if (descriptionController.text.isEmpty) {
                            descriptionController.text =
                                "No description provided";
                          }
                          final updatedNote = Note(
                            id: note.id,
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          await NotesDatabase.instance.update(updatedNote);
                          _loadNotes();
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        final confirm = await showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text("Delete Note"),
                                content: const Text(
                                  "Are you sure you want to delete this note?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                        );
                        try {
                          if (confirm) {
                            await NotesDatabase.instance.delete(note.id!);
                            _loadNotes();
                          }
                        } catch (e) {
                          _loadNotes();
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
            if (note.isExpanded) Column(
              children: [
                Divider(
                  thickness: 1,
                ),
                Text(note.description, style: TextStyle(fontSize: textSizeNormal),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return _buildNoteCard(_notes[index], index);
          },
        ),
      ),
      floatingActionButton: AddnotebuttonWidget(onNoteAdded: _loadNotes),
    );
  }
}

