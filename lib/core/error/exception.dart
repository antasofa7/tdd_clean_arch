class ServerException implements Exception {}

class SocketException implements Exception {
  final String message;

  SocketException(this.message);
}
