import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'notes_model.dart';


class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  var formKey = GlobalKey<FormState>();
  late String name;
  late String designation;
  late String dept;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Center(child: const Text("Add New Note",)),backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Title Here',
                      labelText: 'Enter Title Here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter the title of your note';
                    } else {
                      name = text;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Note Here',
                      labelText: 'Enter Note Here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter the description of your note here';
                    } else {
                      designation = text;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Day Name',
                      labelText: 'Day Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter the Day name here';
                    } else {
                      dept = text;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.red,
                            ),
                            onPressed: () {
                              formKey.currentState!.reset();
                            },
                            child: const Text('Clear'))),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {

                                // Insert into DB

                                var tch = Teacher(name: name, designation: designation, dept: dept);

                                var dbHelper =  DatabaseHelper.instance;
                                int result = await dbHelper.insertTeacher(tch);

                                if( result > 0 ){
                                  Fluttertoast.showToast(msg: 'Your Note Has Been Saved');
                                }

                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Save'))),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                // Text('Obtained Marks: $obtMarks'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
