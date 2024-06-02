import 'package:flutter/material.dart';
import 'package:pa3/pages/catatan/add_screen.dart';
import 'package:pa3/pages/catatan/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:pa3/models/note.dart';
import 'package:pa3/models/notes_operation.dart';

class CatatanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        child: Icon(Icons.add, size: 30, color: Colors.blueGrey),
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        title: Text(
          'Catatan',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return CatatanCard(data.getNotes[index]);
            },
          );
        },
      ),
    );
  }
}

class CatatanCard extends StatelessWidget {
  final Note note;

  CatatanCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  note.description,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'edit':
                  // Implement edit functionality here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                          note:
                              note), // Pass the note to the AddScreen for editing
                    ),
                  );
                  break;
                case 'delete':
                  // Implement delete functionality here
                  Provider.of<NotesOperation>(context, listen: false)
                      .deleteNote(note);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
