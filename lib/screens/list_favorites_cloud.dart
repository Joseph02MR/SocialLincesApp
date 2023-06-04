import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/favorites.dart';
import 'package:flutter_application_1/models/popular.dart';
import 'package:flutter_application_1/widgets/item_popular.dart';

class ListFavoritesCloud extends StatefulWidget {
  const ListFavoritesCloud({super.key});

  @override
  State<ListFavoritesCloud> createState() => _ListFavoritesCloudState();
}

class _ListFavoritesCloudState extends State<ListFavoritesCloud> {
  @override
  Widget build(BuildContext context) {
    FavoritesFirebase _firebase = FavoritesFirebase();
    return Scaffold(
      body: StreamBuilder(
        stream: _firebase.getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /* return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(snapshot.data!.docs[index].get('title')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _firebase.insertFavorite({
                                    'title':
                                        snapshot.data!.docs[index].get('title')
                                  });
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:
                                                const Text("confirmar pedido"),
                                            content: const Text(
                                                "Deseas borrar de favoritos"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    _firebase
                                                        .deleteFavorite(snapshot
                                                            .data!
                                                            .docs[index]
                                                            .id)
                                                        .then((value) => {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Sí')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('no'))
                                            ],
                                          ));
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  );
                });*/

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8, mainAxisSpacing: 10),
              itemCount: snapshot.data != null ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index) {
                //return
              },
            );
          } else if (snapshot.hasError) {
            return Text('Hubo un error');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
