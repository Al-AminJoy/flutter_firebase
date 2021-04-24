import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget{
  @override
  _State createState()=>new _State();
}

class _State extends State<MyApp>{
  String _studentName,_studentId,_studentProgramId;
  double _studentGPA;
  FirebaseFirestore db=FirebaseFirestore.instance;
  getStudentName(name){
    this._studentName=name;
  }
  getStudentId(String id){
    this._studentId=id;
  }
  getStudentProgramId(String programId){
    this._studentProgramId=programId;
  }
  getStudentGPA(String gpa){
    this._studentGPA=double.parse(gpa);
  }
  createData(){
    // ignore: deprecated_member_use
    CollectionReference reference=db.collection("students");
    Map<String,dynamic> students={
      "studentName":_studentName,
      "studentId":_studentId,
      "studentProgramID":_studentProgramId,
      "studentGPA":_studentGPA
    };
    reference.add(students).whenComplete(() => print('Created'));

  }
  readData(){
    CollectionReference reference=db.collection("students");
    reference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        print(doc["studentName"]);
      });
    });
  }
  updateData(){
    DocumentReference reference=db.collection("students").document('Al-Amin');
    Map<String,dynamic> students={
      "studentName":_studentName,
      "studentId":_studentId,
      "studentProgramID":_studentProgramId,
      "studentGPA":_studentGPA
    };
    reference.set(students).whenComplete(() => print('Updated'));  }
  deleteData(){
    DocumentReference reference=db.collection("students").document('Al-Amin');
    reference.delete().whenComplete(() => print("Deleted"));
  }
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter App'),
        ),
        body: new Container(
          padding: EdgeInsets.all(20),
            child: new Column(
              children: [
               TextField(
                 decoration: new InputDecoration(
                   labelText: 'Name',
                   fillColor: Colors.white,
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.yellow,
                     width: 2.0),
                   ),

                 ),
                 onChanged: (String name){
                   getStudentName(name);
                 },
               ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: 'Id',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow,
                          width: 2.0),
                    ),

                  ),
                  onChanged: (String id){
                     getStudentId(id);
                  },
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: 'Program Id',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow,
                          width: 2.0),
                    ),

                  ),
                  onChanged: (String programId){
                     getStudentProgramId(programId);
                  },
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: 'GPA',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow,
                          width: 2.0),
                    ),

                  ),
                  onChanged: (String gpa){
                     getStudentGPA(gpa);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){
                      createData();
                    },
                      child: Text('Create'),),
                    ElevatedButton(onPressed: (){
                      readData();
                    },
                      child: Text('Read'),),
                    ElevatedButton(onPressed: (){
                      updateData();
                    },
                      child: Text('Update'),),
                    ElevatedButton(onPressed: (){
                      deleteData();
                    },
                      child: Text('Delete'),),
                  ],
                )
              ],
            ),
        ),
      );
  }
}