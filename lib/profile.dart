import 'package:flutter/material.dart';
import 'package:quicknote/proclass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await UserProfile.getProfile();
    setState(() {
      _nameController.text = profile['name'] ?? '';
      _ageController.text = profile['age']?.toString() ?? '';
      _cityController.text = profile['city'] ?? '';
      _bioController.text = profile['bio'] ?? '';
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await UserProfile.saveProfile(
        _nameController.text,
        int.parse(_ageController.text),
        _cityController.text,
        _bioController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Center(child: Text('User Profile')),backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color:Colors.white),
                controller: _nameController,
                decoration: InputDecoration(labelText: 'User Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color:Colors.white),
                controller: _ageController,
                decoration: InputDecoration(labelText: 'User Age'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                style: TextStyle(color:Colors.white),
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Your City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color:Colors.white),
                controller: _bioController,
                decoration: InputDecoration(labelText: 'Your Bio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Save',style: TextStyle(fontSize: 20),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
