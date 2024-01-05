import 'package:notesapp_providerreal/database/dbhelper.dart';

class NotesModel{

  int? id;
  String title;
  String desc;
  NotesModel({this.id, required this.title,required this.desc});

  factory NotesModel.fromMap(Map<String,dynamic>map){
    return NotesModel(title: map[dbHelper.note_title], desc:map[dbHelper.note_desc],id: map[dbHelper.note_id]);
  }
  Map<String,dynamic>tomap(){
    return{
      dbHelper.note_title:title,
      dbHelper.note_desc:desc,
      dbHelper.note_id:id,

    };

  }

}