import 'dart:io';

import 'package:fios/providers/notes.dart';

import 'package:fios/widgets/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  static final routeName = 'notes';
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _noteController = TextEditingController();

  String note = '';
  Future<void> _getNotes() async {
    await Provider.of<Notes>(context, listen: false).getNotes();
  }

  Future<void> _addNote() async {
    if (_noteController.text.isNotEmpty) {
      note = _noteController.text;
      await Provider.of<Notes>(context).addNote(note);
      setState(() {
        _noteController.text = '';
      });
    } else if (_noteController.text.length < 5) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Note is too short, 5 characters please',
            style: TextStyle(fontSize: 18.0),
          ),
          duration: Duration(milliseconds: 1000),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context).notes;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Today Notes',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SearchBox(
              hintText: 'Search for notes',
              onChanged: (value) {},
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(14.0),
              child: TextField(
                autocorrect: false,
                controller: _noteController,
                autofocus: true,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  labelText: 'Note',
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            RaisedButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  'Save Note',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 18.0),
                ),
                color: Theme.of(context).accentColor,
                onPressed: _addNote),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: notes.length,
                itemBuilder: (context, int index) {
                  final note = notes[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 6.0),
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
                          trailing: Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                Platform.isIOS
                                    ? showCupertinoDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'Do you want to delete this note?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () async {
                                                  await Provider.of<Notes>(
                                                          context)
                                                      .deleteNote(note.id)
                                                      .then((success) {
                                                    if (success) {
                                                      Navigator.pop(context);
                                                    } else {
                                                      return;
                                                    }
                                                  });
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('No'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        })
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'Do you want to delete this note?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Provider.of<Notes>(context)
                                                      .deleteNote(note.id);
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('No'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
