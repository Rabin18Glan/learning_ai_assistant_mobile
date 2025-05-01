import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = 'Server error occurred'});

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class AuthFailure extends Failure {
  final String message;

  AuthFailure({this.message = 'Authentication failed'});

  @override
  List<Object> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;

  ValidationFailure({this.message = 'Validation failed'});

  @override
  List<Object> get props => [message];
}
