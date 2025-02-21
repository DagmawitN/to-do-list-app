import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateNote extends StatefulWidget {
  final Client client;
  final int id;
  final String note;
  const UpdateNote({
    Key? key,
    required this.client,
    required this.id,
    required this.note,
  }) : super(key: key);

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note", style: TextStyle(fontWeight: FontWeight.bold)),
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
              child: Text("Update Note" ,  style: TextStyle(color: Colors.white),)
              )
              )
        ],
      ),
    );
  }
}
