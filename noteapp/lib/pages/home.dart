import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/models/notecard.dart';
import 'package:noteapp/pages/addnotepage.dart';
import 'package:noteapp/provider/note_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: const Text('Your Notes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      ),
      body: SafeArea(child: Consumer<NoteProvider>(
        builder: (BuildContext context, noteprovider, Widget? child) {
          return noteprovider.notes.isEmpty
              ? Center(
                  child: Text(
                    'No Notes Yet \n Tap on Add Button to Add Notes',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: noteprovider.notes.length,
                  itemBuilder: (context, index) {
                    return NoteCard(index: index);
                  });
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => Addnotepage(
                  isupdate: false,
                ),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
