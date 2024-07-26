import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'notes_model.dart';


class UpdateTeacher extends StatefulWidget {
  final Teacher teacher;
  const UpdateTeacher({Key? key, required this.teacher}) : super(key: key);

  @override
  State<UpdateTeacher> createState() => _UpdateTeacherState();
}

class _UpdateTeacherState extends State<UpdateTeacher> {
  late String name;
  late String designation;
  late String dept;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Center(child: const Text('Update Note')),backgroundColor:Colors.cyan ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
style: TextStyle(color: Colors.white),
                  initialValue: widget.teacher.name,
                  decoration: const InputDecoration(hintText: 'Note Title',),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the title of your note';
                    }

                    name = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  initialValue: widget.teacher.designation,
                  decoration: const InputDecoration(hintText: 'Note Description'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the detail of your note';
                    }
                    designation = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  initialValue: widget.teacher.dept,
                  decoration: const InputDecoration(hintText: 'Enter Day'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Day name here';
                    }
                    dept = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(

                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // var tch = Teacher(id: widget.teacher.id,name: widget.teacher.name,
                        //     designation: widget.teacher.designation,
                        //     dept: widget.teacher.dept);

                        var tch = Teacher(id: widget.teacher.id,name: name,
                            designation: designation,
                            dept: dept);


                        // print(tch.toMap());

                        var dbHelper = DatabaseHelper.instance;
                        int result = await dbHelper.updateTeacher(tch);

                        // print("Result = " + result.toString());
                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Note Has Been Updated');
                          Navigator.pop(context, 'done');

                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: const Text('Update',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
