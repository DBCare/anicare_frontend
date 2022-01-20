class ItemNotFound implements Exception {
  final _message;
  ItemNotFound([this._message]);

  @override
  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
