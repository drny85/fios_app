import 'package:fios/models/note.dart';
import 'package:fios/providers/notes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class NotesList extends StatelessWidget {
  final List<Note> notes;

  NotesList(this.notes);

  Future<void> deleteNote(BuildContext context, String noteId) async {
    await Provider.of<Notes>(context, listen: false).deleteNote(noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: notes.length,
        itemBuilder: (context, int index) {
          final note = notes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              animationDuration: Duration(milliseconds: 500),
              elevation: 12.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: ListTile(
                  title: Text(note.note),
                  subtitle: Text(
                    DateFormat.yMd().add_jms().format(note.created),
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        semanticLabel: 'Delete',
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (
                              ctx,
                            ) {
                              return Platform.isIOS
                                  ? CupertinoAlertDialog(
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Are you sure'),
                                      ),
                                      content: Text(
                                        'Do you want to delete this note?',
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () {
                                            deleteNote(context, note.id);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        FlatButton(
                                          color: Theme.of(context).accentColor,
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    )
                                  : AlertDialog(
                                      title: Text('Are you sure'),
                                      content: Text(
                                          'Do you want to delete this note?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () {
                                            deleteNote(context, note.id);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        FlatButton(
                                          color: Theme.of(context).accentColor,
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                            });
                      }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
