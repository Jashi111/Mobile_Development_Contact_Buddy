import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class _EditContactScreenState extends StatelessWidget {

  // Modify this class based on your requirements
  final String firstname;
  final String lastname;
  final String birthDay;
  final String number;
  final String email;
  final String address;
  final String company;
  final String docID;

  // Add controllers for text form fields
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  // Constructor to initialize controllers
  _EditContactScreenState({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.birthDay,
    required this.number,
    required this.email,
    required this.address,
    required this.company,
    required this.docID,
  }) : super(key: key) {
    _firstnameController.text = firstname;
    _lastnameController.text = lastname;
    _birthDayController.text = birthDay;
    _numberController.text = number;
    _emailController.text = email;
    _addressController.text = address;
    _companyController.text = company;
  }

  // Function to update contact in Firestore
  void updateContact() {
    FirebaseFirestore.instance.collection('contacts').doc(docID).update({
      'firstname': _firstnameController.text,
      'lastname': _lastnameController.text,
      'birthDay': _birthDayController.text,
      'number': _numberController.text,
      'email': _emailController.text,
      'address': _addressController.text,
      'company': _companyController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextFormField(
              controller: _birthDayController,
              decoration: InputDecoration(labelText: "Birth Day"),
            ),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "Address"),
            ),
            TextFormField(
              controller: _companyController,
              decoration: InputDecoration(labelText: "Company"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateContact();
                Navigator.pop(context);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
