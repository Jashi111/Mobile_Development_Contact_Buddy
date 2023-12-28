import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_contact_buddy/SaveDetails.dart';
import 'package:new_contact_buddy/Update.dart';



class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    _stream = FirebaseFirestore.instance.collection('uDetails').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Welcome to Contact Buddy"),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('uDetails').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? const Center(
                  child: Text("No Contacts Found ..."),
                )
              : ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Home(
                            //             firstname: data["firstname"],
                            //             number: data["number"],
                            //             email: data["email"],
                            //             docID: document.id))),
                            leading:
                                CircleAvatar(child: Text(data["firstname"][0])),
                            title: Text(
                              data["firstname"],
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              data["number"],
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.teal,
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => _EditContactScreenState(
                                      //       firstname: data["firstname"],
                                      //       lastname: data["lastname"],
                                      //       birthDay: data["birthDay"],
                                      //       number: data["number"],
                                      //       email: data["email"],
                                      //       address: data["address"],
                                      //       company: data["company"],
                                      //       docID: document.id,
                                      //     ),
                                      //   ),
                                      // );
                                    },

                                  ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.teal,
                                onPressed: () {
                                  deleteContact(document.id);
                                },
                              ),
                            ]));
                      })
                      .toList()
                      .cast(),
                );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[900] ?? Colors.black,
        items: [
          Icon(Icons.add, color: Colors.black),
        ],
        onTap: (index) {
          print("Button Pressed: $index");
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
              break;
          }
        },
      ),
    );
  }

  /// Read the firestore document

  Stream<QuerySnapshot> getUserDetails({String? searchQuery}) async* {
    var userDetailsQuery = FirebaseFirestore.instance
        .collection("uDetails")
        .orderBy("firstname"); // Order the documents by the "firstname" field

    // If a search query is provided, add a filter to the query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = "$searchQuery\uf8ff";
      userDetailsQuery = userDetailsQuery.where("firstname",
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }

    var userDetails = userDetailsQuery.snapshots();

    yield* userDetails;
  }

  // Delete contact

  Future<void> deleteContact(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection("uDetails")
          .doc(docID)
          .delete();
      print("Contact Deleted");
    } catch (e) {
      print("Error deleting contact: $e");
    }
  }
}



Future _EditContactScreenState(
    String name, String phone, String email, String docID) async {
  Map<String, dynamic> data = {"firstname": firstname,"lastname": lastname,"birthDay": birthDay, "number":number, "email": email, "address": address, "company": company};
  try {
    await FirebaseFirestore.instance
        .collection("uDetails")
        .doc(docID)
        .update(data);
    print("Document Updated");
  } catch (e) {
    print(e.toString());
  }
}


// Future<void> _EditContactScreenState({
//   required String firstname,
//   required String lastname,
//   required String birthDay,
//   required String number,
//   required String email,
//   required String address,
//   required String company,
//   required String docID,
// }) async {
//   Map<String, dynamic> data = {
//     "firstname": firstname,
//     "lastname": lastname,
//     "birthDay": birthDay,
//     "number": number,
//     "email": email,
//     "address": address,
//     "company": company,
//   };
//
//   try {
//     await FirebaseFirestore.instance
//         .collection("uDetails")
//         .doc(docID)
//         .update(data);
//     print("Document Updated");
//   } catch (e) {
//     print(e.toString());
//   }
// }






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: MainMenu(),
  ));
}
