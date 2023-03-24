import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postObj});
  Post? postObj;

  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final avatar =
        CircleAvatar(backgroundImage: AssetImage('assets/images/cat.png'));

    final txtUser = Text('Le José');
    final txtDate = Text('06/03/2023');
    final postImage =
        Image(height: 100, image: AssetImage('assets/images/logo_itc.png'));
    final txtDesc = Text('Este es el contenido del post');
    final iconRate = Icon(Icons.rate_review);

    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue),
      child: Column(
        children: [
          Row(
            children: [avatar, txtUser, txtDate],
          ),
          Row(
            children: [postImage, txtDesc],
          ),
          Row(
            children: [
              iconRate,
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add', arguments: postObj);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('confirmar borrado'),
                              content: const Text('¿Deseas borrar el post?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      database
                                          .DELETE('tblPost', postObj!.idPost!)
                                          .then(
                                            (value) => flag.setFlag_postList(),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Sí')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'))
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
