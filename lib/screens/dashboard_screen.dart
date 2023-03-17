import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/list_post.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: PostList(),
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
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/itc_esc.jpg')),
                accountName: Text('Sunny'),
                accountEmail: Text('sunny@omori.com')),
            ListTile(
              onTap: () {
                return;
              },
              title: Text('Práctica 1'),
              subtitle: Text('Descripción de la práctica'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
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
