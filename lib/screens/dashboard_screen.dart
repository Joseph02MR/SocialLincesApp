import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lincesaurios anonimos'), actions: []),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn0.soyungato.com/es/razas/2/1/0/gato-snowshoe_12_0_orig.jpg'),
                ),
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
            )
          ],
        ),
      ),
    );
  }
}
