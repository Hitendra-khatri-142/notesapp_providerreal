import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/NotesModel.dart';

class dbHelper{
  dbHelper._();
  static final dbHelper instance=dbHelper._();
  Database? _database;
  static const note_tabe="notes";
  static const note_id="note_id";
  static const note_title="note_title";
  static const note_desc="note_desc";

  Future<Database>getDb()async{
    if(_database==null){
      return await initDb();

    }
    else{
      return _database!;
    }
  }

  Future<Database>initDb()async{
    Directory directory=await getApplicationDocumentsDirectory();
    var dbpath=join(directory.path+"notesdb.db");
    return openDatabase(dbpath,version: 1,onCreate: (db,version){
      return db.execute("Create table $note_tabe ( $note_id integer primary key autoincrement, $note_title text, $note_desc text )");
    });


  }
  insertNote(NotesModel notesModel)async{
    var db=await getDb();
    db.insert(note_tabe,notesModel.tomap());
  }

  Future<List<NotesModel>>getData()async{
    var db=await getDb();
    List<NotesModel>listnotes=[];
    var data= await db.query(note_tabe);
    for(Map<String,dynamic> eachData in data){
      NotesModel notesModel=NotesModel.fromMap(eachData);
      listnotes.add(notesModel);
    }
    return listnotes;

  }
   updatesNotes(NotesModel notesModel)async{
    var db=await getDb();
    await db.update(note_tabe, notesModel.tomap(),
        where: "$note_id=${notesModel.id}" );

  }
  deleteNotes(int id)async{
    var db=await getDb();
    await db.delete(note_tabe,where: "$note_id=?",whereArgs: [id.toString()]);
  }
}