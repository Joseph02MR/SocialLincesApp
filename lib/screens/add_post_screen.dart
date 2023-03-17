import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_help.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  DatabaseHelper database = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final txtPostController = TextEditingController();

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
              const Text('Agregar publicación'),
              TextFormField(
                maxLines: 8,
                controller: txtPostController,
              ),
              ElevatedButton(
                  onPressed: () {
                    database.INSERT('tblPost', {
                      'dscPost': txtPostController.text,
                      'datePost': DateTime.now().toString()
                    }).then((value) {
                      var msg = value > 0 ? 'Registro insertado' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: const Text('Guardar'))
            ],
          ),
        ),
      ),
    );
  }
}
