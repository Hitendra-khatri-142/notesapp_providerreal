import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notesapp_providerreal/database/dbhelper.dart';
import 'package:notesapp_providerreal/provider/dbhelper_provider.dart';
import 'package:provider/provider.dart';

import '../model/NotesModel.dart';
import 'Add Notes.dart';

class fetchNotes extends StatefulWidget {
  const fetchNotes({super.key});

  @override
  State<fetchNotes> createState() => _fetchNotesState();
}

class _fetchNotesState extends State<fetchNotes> {

  @override
  void initState() {
    super.initState();

    getNotes();

  }
  List<NotesModel>arrnotes=[];

  getNotes(){
    context.read<DbhelperProvider>().fetchIntialNotes();
  }
  deleteNotes(int id){
   context.read<DbhelperProvider>().deletenotes(id);
  }

  updateNotes(NotesModel notesModel){
    context.read<DbhelperProvider>().updateNotes(notesModel);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DbhelperProvider>(
      builder: (_,provider,__){
        return Scaffold(
          appBar: AppBar(
            title: Text("Notes App"),
            centerTitle: true,

          ),
          body:ListView.builder(
              itemBuilder: (_,index){

            return InkWell(
              // onTap: (){
              //   log('tapped!!!!');
              //   var title = arrnotes[index].title;
              //   var desc = arrnotes[index].desc;
              //   TextEditingController titlecontroller = TextEditingController();
              //   TextEditingController desccontroller = TextEditingController();
              //   showModalBottomSheet(context: context,
              //       builder: (context){
              //     return Container(
              //       height: 300,
              //       width: double.infinity,
              //       child: Column(
              //         children: [
              //           Text("update notes"),
              //           TextField(
              //             controller: titlecontroller,
              //           ),
              //           TextField(
              //             controller: desccontroller,
              //           ),
              //           ElevatedButton(onPressed: () {
              //             String utitle=titlecontroller.text.trim();
              //             String udesc=desccontroller.text.trim();
              //             updateNotes(NotesModel(id: arrnotes[index].id!,title: utitle, desc:udesc));
              //             context.read<DbhelperProvider>().getNotes();
              //             Navigator.pop(context);
              //
              //           }, child: Text("updates")),
              //         ],
              //       ),
              //     );
              //   }
              //
              //   );
              // },
              onTap: () {
               var title = arrnotes[index].title;
                var desc = arrnotes[index].desc;
                TextEditingController utitle = TextEditingController();
               TextEditingController udesc = TextEditingController();
                showModalBottomSheet(context: context, builder: (context){
                  return Container(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text("update notes"),
                        TextField(
                       controller: utitle,
                        ),
                        TextField(
                          controller: udesc,
                        ),
                        ElevatedButton(onPressed: () {
                           String utitle = titlecontroller.text.trim();
                          String udesc = desccontroller.text.trim();
                          //
                          // db.updatesNotes(NotesModel(
                          //     id: listnotes[index].id,
                          //     title: utitle,
                          //     desc: udesc
                          //
                          // ));
                          // getAllData();
                          Navigator.pop(context);

                        }, child: Text("updates")),
                      ],
                    ),
                  );
                }

                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("${provider.arrNotes[index].id}")
                ),
                title: Text("${provider.arrNotes[index].title}"),
                subtitle: Text('${provider.arrNotes[index].desc}'),
                trailing: IconButton(onPressed: () {
                  deleteNotes(provider.arrNotes[index].id!);
                  context.read<DbhelperProvider>().getNotes();

                }, icon: Icon(Icons.delete)),

              ),
            );
          },itemCount: provider.arrNotes.length) ,
          floatingActionButton: FloatingActionButton(onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) =>addNotes() ,));

          },child:Icon(Icons.add)),
        );
      },

    );
  }
}
