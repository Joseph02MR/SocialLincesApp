import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  DatabaseHelper database = DatabaseHelper();
  Post? objPost;

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);

    final txtPostController = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objPost = ModalRoute.of(context)!.settings.arguments as Post;
      txtPostController.text = objPost!.dscPost!;
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          height: 350,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: Colors.green),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              objPost == null
                  ? const Text('Agregar publicación')
                  : const Text('Actualizar publicación'),
              TextFormField(
                maxLines: 8,
                controller: txtPostController,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (objPost == null) {
                      database.INSERT('tblPost', {
                        'dscPost': txtPostController.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0 ? 'Registro insertado' : 'Error';
                        var snackBar = SnackBar(content: Text(msg));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    } else {
                      database.UPDATE('tblPost', {
                        'idPost': objPost!.idPost,
                        'dscPost': txtPostController.text,
                        'datePost': DateTime.now().toString()
                      }).then((value) {
                        var msg = value > 0 ? 'Registro actualizado' : 'Error';
                        var snackBar = SnackBar(content: Text(msg));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                    flag.setFlag_postList();
                  },
                  child: objPost == null
                      ? const Text('Agregar')
                      : const Text('Actualizar'))
            ],
          ),
        ),
      ),
    );
  }
}
