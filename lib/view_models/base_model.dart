import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  String _errMsg;
  String get errMsg => _errMsg;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
  void setMessage(String value) {
    _errMsg = value;
  }
}