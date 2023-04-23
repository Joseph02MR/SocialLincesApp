import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/widgets/onboarding_card.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  late final auth;

  final data = [
    OnboardingCardData(
        title: "¡Bienvenido!",
        subtitle:
            "Social Linces es una red social para los estudiantes del TECNM en Celaya",
        image: const AssetImage("assets/images/logo_itc.png"),
        backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
        titleColor: const Color.fromARGB(255, 5, 153, 34),
        subtitleColor: Colors.white,
        background: LottieBuilder.asset("assets/animations/bg-1.json"),
        aux: 1),
    OnboardingCardData(
        title: "Poco, pero honrado...",
        subtitle:
            "Social Linces fue desarrollada por alumnos de la ing. en Sistemas. ¿Qué esperas para cambiarte?",
        image: const AssetImage("assets/images/asisc.jpg"),
        backgroundColor: Colors.white,
        titleColor: const Color.fromARGB(255, 49, 7, 147),
        subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
        background: LottieBuilder.asset("assets/animations/bg-2.json"),
        aux: 0),
    OnboardingCardData(
        title: "¿Buscas un lugar?",
        subtitle:
            "La app incluye un pequeño croquis de campus 2 para ayudarte a llegar a tu próxima clase",
        image: const AssetImage("assets/images/map.png"),
        backgroundColor: const Color.fromARGB(255, 5, 153, 34),
        titleColor: const Color.fromARGB(255, 49, 7, 147),
        subtitleColor: Colors.white,
        background: LottieBuilder.asset("assets/animations/bg-3.json"),
        aux: 1),
  ];

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      auth = ModalRoute.of(context)!.settings.arguments as EmailAuth;
    }
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return OnboardingCard(data: data[index]);
        },
        onFinish: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardScreen(
                      userCredential: auth,
                    )),
          );
        },
      ),
    );
  }
}
