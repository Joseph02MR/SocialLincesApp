import 'package:flutter/material.dart';

class LoadingModalWidget extends StatelessWidget {
  const LoadingModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(1, 100, 100, 100),
      child: Center(child: Image.asset('assets/images/loading__.gif')),
    );
  }
}
