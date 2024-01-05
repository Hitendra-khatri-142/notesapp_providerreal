import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:notesapp_providerreal/model/NotesModel.dart';
import 'package:notesapp_providerreal/provider/dbhelper_provider.dart';
import 'package:notesapp_providerreal/screens/fetchnotes.dart';
import 'package:notesapp_providerreal/widgets/uihelper.dart';
import 'package:provider/provider.dart';

class addNotes extends StatefulWidget {
  const addNotes({super.key});

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController desccontroller=TextEditingController();

  addData(String title,String desc){
    if(title==""&& desc==""){
      return log("Enter Fields");
    }
    else{
      context.read<DbhelperProvider>().addNotes(NotesModel(title: title, desc: desc));
      return log("Data inserted");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add notes"),
        centerTitle: true,

      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Add Notes",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
          SizedBox(height: 30,),
          uiHelper.CustomTextField(titlecontroller, "Title", Icons.title),
          uiHelper.CustomTextField(desccontroller, "Description", Icons.description),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {
            addData(titlecontroller.text.toString(), desccontroller.text.toString());
            context.read<DbhelperProvider>().getNotes();
            Navigator.pop(context);
          }, child: Text("Add Notes")),
        ],
      ),
    );
  }
}
