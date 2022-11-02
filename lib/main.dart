import 'package:flutter/material.dart';
import 'package:flutter_sqflite/AddNote.dart';
import 'package:flutter_sqflite/db/MyDB.dart';

import 'model/Note.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note>? noteList;

  @override
  void initState() {
    refreshList();
    super.initState();
  }

  @override
  void dispose() {
    MyDB.instance.close();
    super.dispose();
  }

  Future refreshList() async {
    setState(() {
      MyDB.instance.getNotes().then((value) => noteList = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("sqfLite Database")),
      body: FutureBuilder(
        future: MyDB.instance.getNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return noteList!.isEmpty
              ? const Center(
                  child: Text("NO DATA"),
                )
              : ListView.builder(
                  itemCount: noteList?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            noteList![index].title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            noteList![index].content.toString(),
                          ),
                          trailing: GestureDetector(
                            onTap: ()async{
                              MyDB.instance.deleteNote(noteList![index].id ?? 0);
                              refreshList();
                            },
                            child: Icon(Icons.delete_outline,
                                color: Colors.pinkAccent.shade100),
                          ),
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddNote(
                                    note: noteList![index],
                                  );
                                },
                              ),
                            );
                            refreshList();
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddNote();
              },
            ),
          );
          refreshList();
        },
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:flutter_sqflite/AddNote.dart';
// import 'package:flutter_sqflite/db/MyDB.dart';
//
// import 'model/Note.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Note>? noteList;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     refreshList();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     MyDB.instance.close();
//     super.dispose();
//   }
//
//   Future refreshList() async {
//     setState(() => isLoading = true);
//     MyDB.instance.getNotes().then((value) => noteList = value);
//     setState(() => isLoading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("sqfLite Database")),
//       body: FutureBuilder(
//         future: MyDB.instance.getNotes(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return isLoading
//               ? const CircularProgressIndicator()
//               : noteList!.isEmpty
//                   ? const Center(
//                       child: Text("NO DATA"),
//                     )
//                   : ListView.builder(
//                       itemCount: noteList?.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               title: Text(
//                                 noteList![index].title.toString(),
//                                 style:
//                                 TextStyle(fontWeight: FontWeight.w900),
//                               ),
//                               subtitle: Text(
//                                 noteList![index].content.toString(),
//                               ),
//                               trailing: GestureDetector(
//                                 onTap: () {
//                                   MyDB.instance.deleteNote(noteList![index].id ?? 0);
//                                   refreshList();
//                                 },
//                                   child: Icon(Icons.delete_outline,color: Colors.pinkAccent.shade100,)),
//                               onTap: () async{
//                                 await Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) {
//                                     return AddNote(
//                                       note: noteList![index],
//                                     );
//                                   },
//                                 ));
//                                 refreshList();
//                               },
//                             )
//                           ),
//                         );
//                       },
//                     );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () async {
//           await Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) {
//                 return AddNote();
//               },
//             ),
//           );
//           refreshList();
//         },
//       ),
//     );
//   }
// }
