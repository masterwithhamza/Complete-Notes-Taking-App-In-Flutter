import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quicknote/add_note.dart';
import 'package:quicknote/privacy.dart';
import 'package:quicknote/proclass.dart';
import 'package:quicknote/profile.dart';

import 'package:quicknote/update_teacher.dart';

import 'Aboutus.dart';
import 'database_helper.dart';
import 'notes_model.dart';
class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(title: const Center(child: Text("Quick Note")),backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_box),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileForm()),
              );
            },
          ),

        ],),
      body: FutureBuilder<List<Teacher>>(
        future: DatabaseHelper.instance.getAllTeachers(),
        builder: (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Record Found'));
            }
            else {
              List<Teacher> teachers = snapshot.data!;
              return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: teachers.length, //players.length
                    itemBuilder: (BuildContext context, int index) {
                      Teacher tch = teachers[index];

                      return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tch.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('${tch.designation}'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Day : ${tch.dept}',style: TextStyle(color: Colors.deepOrange,fontSize: 15,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            var result =
                                            await Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return UpdateTeacher(teacher: tch);
                                                }));

                                            if (result == 'done') {
                                              setState(() {});
                                            }
                                          },
                                          icon: const Icon(Icons.edit,color: Colors.green,)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Confirmation!'),
                                                    content: const Text(
                                                        'Are you sure you want to delete ?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          child:
                                                          const Text('No')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                context)
                                                                .pop();

                                                            // delete dog

                                                            int result =
                                                            await DatabaseHelper
                                                                .instance
                                                                .deleteTeacher(tch.id!);

                                                            if (result > 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                  msg:
                                                                  'Note Has Been Deleted');
                                                              setState(() {});
                                                              // build function will be called
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Yes')),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.delete,color: Colors.red,)),
                                    ],
                                  )
                                ],
                              )));
                    },
                  )
              );

            }
          }


        },

      ),
      drawer: Drawer(
        backgroundColor: Colors.cyan,
        child: ListView(
          scrollDirection: Axis.vertical,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 20,),
            Image.asset("images/logo.png",width: 180,height: 100,),
            const SizedBox(height: 40,),
            const Divider(thickness: 0.6,color: Colors.black,),
            ListTile(
              leading: const Icon(Icons.add_box,size: 25,color: Colors.white,),
              title: const Text('Add New Note',style: TextStyle(fontSize: 16,color: Colors.white),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTeacher()),
                );
              },//  tileColor: Colors.white,


            ),
            ListTile(
              leading: const Icon(Icons.account_circle,size: 25,color: Colors.white),
              title: const Text('My Profile',style: TextStyle(fontSize: 16,color: Colors.white),),
                           //  tileColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileForm()),
                );
              },


            ),


            ListTile(
              leading: const Icon(Icons.policy,size: 25,color: Colors.white,),
              title: const Text('Privacy Policy',style: TextStyle(fontSize: 16,color: Colors.white),),
                             //  tileColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const privacy()),
                );

              },


            ),
            ListTile(
              leading: const Icon(Icons.policy,size: 25,color: Colors.white,),
              title: const Text('about',style: TextStyle(fontSize: 16,color: Colors.white),),
              //  tileColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const about()),
                );

              },


            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app,size: 25,color: Colors.white,),
              title: const Text('Exit',style: TextStyle(fontSize: 16,color: Colors.white),),

              onTap: () {
                Navigator.pop(context);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: Row(
                          children: const [
                            Icon(Icons.exit_to_app, size: 25, color: Colors.red,),
                            SizedBox(width: 10,),
                            Text('Exit', style: TextStyle(fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),),
                          ],
                        ),
                        content: const Text(
                          'Are you sure you want to Exit from this app ?',
                          style: TextStyle(fontSize: 15),),
                        actions: <Widget>[
                          TextButton(

                            onPressed: () => SystemNavigator.pop(),
                            child: const Text('Exit'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                );
              },

            ),



          ],
        ),

      ),
    );
  }
}
