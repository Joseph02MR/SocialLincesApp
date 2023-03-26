import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_post_screen.dart';
import 'package:flutter_application_1/screens/calendar_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/list_popular_videos.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_application_1/screens/themes_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/onboard': (BuildContext context) => OnboardingScreen(),
    '/theme': (BuildContext context) => const ThemesScreen(),
    '/add': (BuildContext context) => AddPostScreen(),
    '/popular': (BuildContext context) => const ListPopularVideos(),
    '/events': (BuildContext context) => const CalendarScreen(),
  };
}
