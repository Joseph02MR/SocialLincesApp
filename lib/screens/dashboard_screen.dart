import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/list_favorites_cloud.dart';
import 'package:flutter_application_1/screens/list_post.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, required this.userCredential});
  final EmailAuth userCredential;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;
  Map aux = {};
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    super.initState();
    logger.i(widget.userCredential.userCredential.user);

    if (widget.userCredential.userCredential.user?.providerData != null) {
      var data = widget.userCredential.userCredential.user?.providerData[0];
      aux = Map.from({
        'email': data?.email,
        'photoURL': data?.photoURL,
        'name': data?.displayName,
        'providerId': data?.providerId
      });
    } else {
      var data = widget.userCredential.userCredential.user;
      aux = Map.from({
        'email': data?.email,
        'photoURL': data?.photoURL,
        'name': data?.displayName,
      });
    }
  }

  @override
  void dispose() {
    logout();
    super.dispose();
  }

  void logout() async {
    await widget.userCredential.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: const ListFavoritesCloud(),
      //body: const PostList(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add').then((value) {
              setState(() {});
            });
          },
          label: const Text('Agregar publicación'),
          icon: const Icon(Icons.add_comment)),
      appBar: AppBar(title: const Text('Lincesaurios anonimos'), actions: [
        IconButton(
          icon: const Icon(
            Icons.settings,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/theme');
          },
        )
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(aux['photoURL'])),
                accountName: Text(aux['name']),
                accountEmail: Text(aux['email'])),
            ListTile(
              onTap: () {},
              title: const Text('Práctica 1'),
              subtitle: const Text('Descripción de la práctica'),
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/events');
              },
              title: const Text('Eventos'),
              leading: const Icon(Icons.calendar_month),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
              title: const Text('API videos'),
              leading: const Icon(Icons.movie),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
              title: const Text('Práctica Maps'),
              leading: const Icon(Icons.map),
              trailing: const Icon(Icons.chevron_right),
            ),
            /*DayNightSwitcher(
                isDarkModeEnabled: isDarkModeEnabled,
                onStateChanged: (isDarkModeEnabled) {
                  isDarkModeEnabled
                      ? theme.setThemeData(StylesSettings.darkTheme(context))
                      : theme.setThemeData(StylesSettings.lightTheme(context));
                  this.isDarkModeEnabled = isDarkModeEnabled;
                  setState(() {});
                })*/
          ],
        ),
      ),
    );
  }
}
