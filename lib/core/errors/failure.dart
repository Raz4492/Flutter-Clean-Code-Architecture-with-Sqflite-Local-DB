abstract class Failure {
  final String message;
  Failure(this.message);
}

// Server-related failures (e.g., when the network request fails)
class ServerFailure extends Failure {
  ServerFailure(super.message);
}
// Network-related failures (e.g., when there's no internet connection)
class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

// NotFoundFailure-related failures (e.g., User not found locally or on the server.)
class NotFoundFailure extends Failure {
  NotFoundFailure(super.message);
}

// Cache-related failures (e.g., when data retrieval from local cache fails)
class CacheFailure extends Failure {
  CacheFailure(super.message);
}

// Database-related failures (e.g., when database operations fail)
class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

// Connection-related failures (e.g., when the app cannot connect to the internet)
class ConnectionFailure extends Failure {
  ConnectionFailure(super.message);
}

// Timeout failures (e.g., when a network request takes too long)
class TimeoutFailure extends Failure {
  TimeoutFailure(super.message);
}

// Authentication-related failures (e.g., invalid credentials, token expired)
class AuthenticationFailure extends Failure {
  AuthenticationFailure(super.message);
}

// Unauthorized access failures (e.g., user tries to access something they're not authorized to)
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message);
}

// Unknown failures (catch-all for unspecified errors)
class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

// Data mismatch or empty response failures
class DataMismatchFailure extends Failure {
  DataMismatchFailure(super.message);
}