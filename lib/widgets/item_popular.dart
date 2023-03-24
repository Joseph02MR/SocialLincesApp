import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/popular.dart';

class ItemPopular extends StatelessWidget {
  const ItemPopular({super.key, required this.model});

  final Popular model;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.fill,
      placeholder: const AssetImage('assets/loading.gif'),
      image:
          NetworkImage('https://image.tmdb.org/t/p/w500/${model.posterPath}'),
    );
  }
}
