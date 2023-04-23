import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placeholder_images/placeholder_images.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email =
      TextEditingController(text: 'example@email.com');

  EmailAuth auth = EmailAuth();

  TextEditingController password = TextEditingController(text: '12345678');
  TextEditingController name = TextEditingController(text: 'Pedro Paramos');

  TextEditingController cmfPassword = TextEditingController(text: '12345678');

  XFile? image;
  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  bool validate_textFields() {
    var textAux = 'Error: hay campos vacíos';
    bool result = false;
    if (cmfPassword.text != password.text) {
      textAux = 'Error: Las contraseñas no coinciden';
      result = false;
    } else if (email.text != "" &&
        password.text != "" &&
        cmfPassword.text != "" &&
        name.text != "") {
      textAux = '¡Registro exitoso!';
      result = true;
      /*
      if (validateEmail(email.text) != null) {
        textAux = 'Error: correo no válido';
        return false;
      }
      */
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Info',
                            style: TextStyle(
                              color: darkGrey,
                              fontSize: 30,
                            ),
                          ),
                          CloseButton()
                        ],
                      ),
                      Text(
                        textAux,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ));
        });
    return result;
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Escoge la imagen a subir'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget title = const Text(
      'Bienvenido a la comunidad',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () {
          if (validate_textFields()) {
            auth.createUserWithEmailAndPassword(
                email: email.text,
                password: password.text,
                name: name.text,
                photo: image?.path ??
                    PlaceholderImage.getPlaceholderImageURL(name.text));
            //Navigator.pushNamed(context, '/dash');
            Navigator.pop(context);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          decoration: BoxDecoration(
              gradient: mainButton,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
          child: const Center(
              child: Text("Registrarse",
                  style: TextStyle(
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
        ),
      ),
    );

    Widget registerForm = SizedBox(
      height: 450,
      child: Stack(
        children: <Widget>[
          Container(
            height: 370,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        myAlert();
                      },
                      child: const Text('Subir foto'),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 40.0)),
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: CircleAvatar(
                              maxRadius: 48,
                              backgroundImage: FileImage(File(image!.path)),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  maxRadius: 48,
                                  backgroundImage: NetworkImage(
                                      PlaceholderImage.getPlaceholderImageURL(
                                          name.text)),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: name,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: email,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    style: const TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: cmfPassword,
                    style: const TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          registerButton,
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo_itc.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: const BoxDecoration(
              color: transparentGreen,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(
                  flex: 3,
                ),
                title,
                const Spacer(
                  flex: 3,
                ),
                registerForm,
                const Spacer(
                  flex: 3,
                ),
                //Padding(padding: EdgeInsets.only(bottom: 20), child: socialRegister)
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
