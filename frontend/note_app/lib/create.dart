import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateNote extends StatefulWidget {
  final Client client;
  const CreateNote({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note" , style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          Padding(padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
              onPressed: () {
                widget.client
                    .post(Uri.parse("http://127.0.0.1:8000/app/notes/create/") , body: {'body': controller.text});
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black , 
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),  
                elevation: 5.0,
                
                ),
              child: Text("Create Note" ,  style: TextStyle(color: Colors.white),)
              )
              )
        ],
      ),
    );
  }
}
