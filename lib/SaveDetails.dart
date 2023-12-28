import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController firstname = TextEditingController();
TextEditingController lastname = TextEditingController();
TextEditingController birthDay = TextEditingController();
TextEditingController number = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController company = TextEditingController();
FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Contacts"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: firstname,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: lastname,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Last Name',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: birthDay,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Birth Day',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mobile',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: email,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: address,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: company,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Company',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _firebaseFirestore.collection('uDetails').add({
              'firstname': firstname.text,
              'lastname': lastname.text,
              'birthDay': birthDay.text,
              'number': number.text,
              'email': email.text,
              'address': address.text,
              'company': company.text,
            });
              firstname.clear();
              lastname.clear();
              birthDay.clear();
              number.clear();
              email.clear();
              address.clear();
              company.clear();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Contact saved successfully'),
            ));
          }
        },
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white70,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Save'),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
