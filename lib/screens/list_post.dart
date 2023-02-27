import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';

import '../models/post_model.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => PostListState();
}

class PostListState extends State<PostList> {
  DatabaseHelper? database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: database!.GETALLPOST(),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var objPost = snapshot.data![index];
                return Container();
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Ocurrió un error"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
