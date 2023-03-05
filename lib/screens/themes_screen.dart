import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../settings/styles_settings.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  void setTheme(ThemeProvider theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (prefs.getInt('theme')) {
      case 0:
        setState(() {
          theme.setThemeData(StylesSettings.lightTheme(context));
        });
        break;
      case 1:
        setState(() {
          theme.setThemeData(StylesSettings.darkTheme(context));
        });
        break;
      case 2:
        setState(() {
          theme.setThemeData(StylesSettings.customTheme(context));
        });
        break;
    }
  }

  void updateTheme(int theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('theme', theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    final light_theme = ElevatedButton(
      onPressed: () {
        updateTheme(0);
      },
      child: const Text('Tema claro'),
    );
    final dark_theme = ElevatedButton(
      onPressed: () {
        updateTheme(1);
      },
      child: const Text('Tema oscuro'),
    );
    final custom_theme = ElevatedButton(
      onPressed: () {
        updateTheme(2);
      },
      child: const Text('Personalizado'),
    );

    return Scaffold(
      //body: Responsive(mobile: mobile, desktop: desktop),
      body: Stack(
        children: [
          Center(child: LottieBuilder.asset("assets/animations/bg-3.json")),
          Center(
            //padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                const Flexible(
                  flex: 20,
                  child: Icon(
                    CupertinoIcons.wand_stars,
                    size: 100,
                  ),
                ),
                const Spacer(flex: 1),
                const Text(
                  "Temas",
                  style: TextStyle(
                    //color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                ),
                const Spacer(flex: 1),
                const Text(
                  "Elige el tema para la aplicación",
                  style: TextStyle(
                    //color: data.subtitleColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const Spacer(flex: 3),
                light_theme,
                const Spacer(flex: 1),
                dark_theme,
                const Spacer(flex: 1),
                custom_theme,
                const Spacer(flex: 3),
                SizedBox(
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
