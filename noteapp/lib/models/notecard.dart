import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/pages/addnotepage.dart';
import 'package:noteapp/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  final int index;

  const NoteCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        log(noteProvider.notes.length.toString());
        log(index.toString());
        if (noteProvider.notes.isEmpty || index >= noteProvider.notes.length) {
          return Container(); // Return an empty container if index is out of range
        }
        Note note = noteProvider.notes[index];

        return GestureDetector(
          onTap: () {
            noteProvider.toggleTapped(index);
          },
          onLongPress: () {
            noteProvider.deleteNote(index, note);
          },
          child: Container(
              margin: const EdgeInsets.all(5),
              child: noteProvider.isTapped[index]
                  ? Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              border: Border.all(width: 2, color: Colors.blue)),
                          child: Center(
                            child: Text(
                              note.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.update),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Addnotepage(
                                              isupdate: true,
                                              index: index,
                                              note: note,
                                            )));
                              },
                            ))
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black)),
                      child: Center(
                        child: Text(
                          note.content!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    )),
        );
      },
    );
  }
}
