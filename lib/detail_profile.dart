import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'model/user_model.dart';

class DetailProfile extends StatefulWidget {
  DetailProfile(
      {super.key,
      required this.user,
      required this.images,
      required this.docId});
  List<dynamic> images;
  User user;
  String docId;

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  @override
  Widget build(BuildContext context) {
    CollectionReference usersdata = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.docId.toString())
        .collection('sub_account');
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                              return Card(
                                child: ListTile(
                                  onTap: () {},
                                  leading: CircleAvatar(
                                    maxRadius: 30,
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.docs[index]['sub_profile']
                                        .toString()),
                                  ),
                                  title: Text(snapshot
                                      .data!.docs[index]['sub_name']
                                      .toString()),
                                  trailing: IconButton(
                                      onPressed: () async {},
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              );
                            },
                          );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index) => SizedBox(
                height: 200,
                width: 300,
                child: CachedNetworkImage(
                  imageUrl: widget.images[index] as String,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
