import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/provider/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Addnotepage extends StatefulWidget {
  const Addnotepage({super.key, required this.isupdate, this.note});
  final bool isupdate;
  final Note? note;

  @override
  State<Addnotepage> createState() => _AddnotepageState();
}

class _AddnotepageState extends State<Addnotepage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();

  void addnewnotes() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userid: "prince",
        title: titlecontroller.text,
        content: contentcontroller.text,
        dateAdded: DateTime.now());
    Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updatenote() {
    if (widget.note!.title != titlecontroller.text ||
        widget.note!.content != contentcontroller.text) {
      widget.note!.title = titlecontroller.text;
      widget.note!.content = contentcontroller.text;
      widget.note!.dateAdded = DateTime.now();
      Provider.of<NoteProvider>(context, listen: false)
          .updateNote(widget.note!);
    }
    Navigator.pop(context);
  }

  FocusNode nodefocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.isupdate) {
      titlecontroller.text = widget.note!.title!;
      contentcontroller.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: titlecontroller,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                onSubmitted: (val) {
                  if (val != "") {
                    nodefocus.requestFocus();
                  }
                },
                autofocus: !widget.isupdate,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 30)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 29),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: 400,
                  child: TextField(
                    controller: contentcontroller,
                    focusNode: nodefocus,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: "Content",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                onPressed: () {
                  if (widget.isupdate) {
                    updatenote();
                  } else {
                    addnewnotes();
                  }
                },
                child: widget.isupdate
                    ? const Text(
                        'Update Note',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    : const Text(
                        'Add Note',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
