import 'package:flutter/material.dart';

class FlagsProvider with ChangeNotifier {
  // ignore: non_constant_identifier_names
  bool _postList_Flag = false;

  // ignore: non_constant_identifier_names
  getFlag_postList() => _postList_Flag;
  // ignore: non_constant_identifier_names
  setFlag_postList() {
    _postList_Flag = !_postList_Flag;
    notifyListeners();
  }
}
