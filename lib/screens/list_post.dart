import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:flutter_application_1/widgets/item_post_widget.dart';
import 'package:provider/provider.dart';

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
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    flag.getFlag_postList();

    return FutureBuilder(
        future: flag.getFlag_postList() == true
            ? database!.GETALLPOST()
            : database!.GETALLPOST(),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var objPost = snapshot.data![index];
                return ItemPostWidget(
                  postObj: objPost,
                );
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
