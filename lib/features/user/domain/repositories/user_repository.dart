import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  /// Retrieves all users from the local database.
  Future<Either<Failure, List<UserModel>>> getAllUsers();

  /// Creates a new user in the local database.
  /// Uses `userName` as a unique identifier for each user.
  Future<Either<Failure, void>> createUser(UserModel user);

  /// Deletes a user from the local database by `userName`.
  Future<Either<Failure, void>> deleteUser(String userName);

  /// Updates an existing user's details in the local database by `userName`.
  Future<Either<Failure, void>> updateUser(UserModel user);

  /// Synchronizes users with the remote server.
  /// This method handles syncing pending users when online.
  Future<Either<Failure, void>> syncUsers();

  /// Retrieves a single user by `userName` from the local database.
  Future<Either<Failure, User?>> getUserByUserName(String userName);

  /// Retrieves a single user by ID from the local database.
  Future<Either<Failure, User?>> getUserById(int id);

  /// Retrieves all users marked as pending sync in the local database.
  Future<Either<Failure, List<User>>> getPendingSyncUsers();
}
