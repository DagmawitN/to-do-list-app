import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:note_app/create.dart';
import 'package:note_app/note.dart';
import 'package:note_app/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App' ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 1, 61)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To do list' ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retriveNotes();
    super.initState();
  }

  _retriveNotes() async {
    notes = [];
    List response = json.decode(
        (await client.get(Uri.parse("http://127.0.0.1:8000/app/notes/"))).body);

    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  Uri deleteUrl(int id) {
    return Uri.parse("http://127.0.0.1:8000/app/notes/$id/delete/");
  }

  void _deleteNote(int id) {
    client.delete(deleteUrl(id));
    _retriveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 72, 94, 105),
        title: Text(widget.title , style: TextStyle(fontWeight: FontWeight.bold , color : Colors.white),),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retriveNotes();
        },
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(notes[index].note),
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateNote(client: client , id: notes[index].id, note: notes[index].note)),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteNote(notes[index].id),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateNote(client: client)),
          );
          },
        tooltip: 'Create Note',
        child: const Icon(Icons.add , color: Colors.white,),
        backgroundColor: Colors.black,
        elevation: 5.0,
      ),
    );
  }
}
