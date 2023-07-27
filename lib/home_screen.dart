import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> docIds = [];
  getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          docIds.add(element.reference.id);
          print(element.reference.id);
        });
      });
    });
  }

  CollectionReference usersdata =
      FirebaseFirestore.instance.collection('users');

  // Future getUsers(String docId) async {
  //   final docProduct =
  //       FirebaseFirestore.instance.collection('users').doc(docId);

  //   final snapshot = await docProduct.get();
  //   await docProduct.collection('users').doc(docId).get();
  //   if (snapshot.exists) {
  //     return snapshot.data() as Map<String, dynamic>;
  //   }
  //   return snapshot.data() as Map<String, dynamic>;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersdata.snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasError
              ? const Center(
                  child: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                )
              : snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var user =
                            User.fromDocument(snapshot.data!.docs[index]);
                        return Card(
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text('age: ${user.age}'),
                          ),
                        );
                      },
                    );
        },
      ),
      // body: ListView.builder(
      //     itemCount: docIds.length,
      //     itemBuilder: (context, index) {
      //       return FutureBuilder(
      //         future: FirebaseFirestore.instance
      //             .collection('users')
      //             .doc(docIds[index])
      //             .get(),
      //         builder: (context, snapshot) {
      //           return snapshot.hasError
      //               ? const Center(
      //                   child: Icon(
      //                     Icons.info,
      //                     color: Colors.red,
      //                   ),
      //                 )
      //               : snapshot.connectionState == ConnectionState.waiting
      //                   ? const Center(
      //                       child: CircularProgressIndicator(),
      //                     )
      //                   : Card(
      //                       child: ListTile(
      //                       title: Text(snapshot.data!['name']),
      //                       subtitle: Text('age: ${snapshot.data!['age']}'),
      //                     ));
      //         },
      //       );
      //     }),
    );
  }
}
