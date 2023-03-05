import 'package:flutter/material.dart';

class OnboardingCardData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;
  final int? aux;

  OnboardingCardData(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      this.background,
      this.aux});
}

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final OnboardingCardData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: data.background),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                data.aux == 1
                    ? Flexible(
                        flex: 20,
                        child: Image(image: data.image),
                      )
                    : Flexible(
                        flex: 20,
                        child: CircleAvatar(
                          backgroundImage: data.image,
                          maxRadius: 100.0,
                        ),
                      ),
                const Spacer(flex: 1),
                Text(
                  data.title.toUpperCase(),
                  style: TextStyle(
                    color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                ),
                const Spacer(flex: 1),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const Spacer(flex: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
