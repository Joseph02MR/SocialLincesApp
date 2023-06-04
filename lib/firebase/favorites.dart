import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFirebase {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  CollectionReference? _favoritesCollection;

  FavoritesFirebase() {
    _favoritesCollection = _firebase.collection('favoritos');
  }

  Future<void> insertFavorite(Map<String, dynamic> map) async {
    return _favoritesCollection!.doc().set(map);
  }

  Future<void> updateFavorite(Map<String, dynamic> map, String id) async {
    return _favoritesCollection!.doc(id).update(map);
  }

  Future<void> deleteFavorite(String id) async {
    return _favoritesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites() {
    return _favoritesCollection!.snapshots();
  }
}
