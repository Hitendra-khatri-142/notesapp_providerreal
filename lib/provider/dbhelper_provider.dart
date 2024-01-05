import 'package:flutter/material.dart';
import 'package:notesapp_providerreal/database/dbhelper.dart';
import 'package:notesapp_providerreal/model/NotesModel.dart';
import 'package:notesapp_providerreal/screens/Add%20Notes.dart';

class DbhelperProvider extends ChangeNotifier {

  dbHelper db = dbHelper.instance;

  List<NotesModel>arrNotes = [];

  addNotes(NotesModel notesModel) async {
    var check = await db.insertNote(notesModel);
    if (check) {
      arrNotes = await db.getData();
      notifyListeners();
    }
  }


  fetchIntialNotes() async {
    arrNotes = await db.getData();
    notifyListeners();
  }

  List<NotesModel> getNotes() {
    fetchIntialNotes();
    return arrNotes;
  }

  deletenotes(int id) async {
    var check = await db.deleteNotes(id);
    if (check) {
      arrNotes = await db.getData();
      notifyListeners();
    }
  }
  updateNotes(NotesModel notesModel)async{
    var check=await db.updatesNotes(notesModel);
    if(check){
      arrNotes=await db.getData();
      notifyListeners();
    }
  }
}