class ServerException implements Exception {
  final String message;

  ServerException({this.message = 'Server error occurred'});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Cache error occurred'});

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({this.message = 'Unauthorized access'});

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({this.message = 'Resource not found'});

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;

  ValidationException({this.message = 'Validation error'});

  @override
  String toString() => message;
}
