import 'dart:async';

import 'package:cleanarchitecture/features/user/data/datasources/user_local_data_source.dart';
import 'package:cleanarchitecture/features/user/data/datasources/user_remote_data_source.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../../../core/utils/network_info.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      final users = await localDataSource.getAllUsers();
      if (users.isEmpty) {
        return Left(DataMismatchFailure('No users found in local storage.'));
      }
      return Right(users);
    } catch (e) {
      return Left(
          CacheFailure('Failed to fetch users from the local database.'));
    }
  }

  @override
  Future<Either<Failure, void>> createUser(UserModel user) async {
    try {
      await localDataSource.createUser(user);

      await localDataSource
          .markUserPendingSync(user.userName); // Mark user for sync
      return const Right(null);
    } catch (e) {
      return Left(
          DatabaseFailure('Failed to create user in the local database.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await localDataSource.deleteUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(
          DatabaseFailure('Failed to delete user from the local database.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserModel user) async {
    try {
      if (await networkInfo.isConnected) {
        //await remoteDataSource.updateUser(user); // Update on the server
      }

      await localDataSource.updateUser(user);
      await localDataSource
          .markUserPendingSync(user.userName); // Mark user for sync
      return const Right(null);
    } catch (e) {
      return Left(
          DatabaseFailure('Failed to update user in the local database.'));
    }
  }

  @override
  Future<Either<Failure, void>> syncUsers() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection.'));
    }

    try {
      final pendingUsers = await localDataSource.getPendingSyncUsers();

      for (var user in pendingUsers) {
        final response = await remoteDataSource.syncUser(user);
        if (response.statusCode == 200 && response.data != null) {
          await localDataSource.markUserSynced(user.userName); // Mark as synced
        } else {
          return Left(
              ServerFailure('Failed to sync user with ID: ${user.userName}'));
        }
      }
      return const Right(null);
    } catch (e) {
      if (e is TimeoutException) {
        return Left(TimeoutFailure('Sync operation timed out.'));
      } else {
        return Left(ServerFailure('Unexpected error during user sync.'));
      }
    }
  }

  @override
  Future<Either<Failure, User?>> getUserById(int userId) async {
    try {
      final localUser = await localDataSource.getUserById(userId);
      if (localUser != null) {
        return Right(localUser);
      }

      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getUserById(userId.toString());
        if (response.statusCode == 200 && response.data != null) {
          // Use UserModel instead of User to call fromJson
          final user = UserModel.fromJson(response.data['user']);
          await localDataSource.createUser(user); // Cache user locally
          return Right(user);
        }
      }

      return Left(NotFoundFailure('User not found locally or on the server.'));
    } catch (e) {
      return Left(ServerFailure('Error fetching user details.'));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserByUserName(String userName) async {
    try {
      // First try fetching the user from local storage
      final localUser = await localDataSource.getUserByUserName(userName);
      if (localUser != null) {
        return Right(localUser);
      }

      // If user not found locally, check for online data
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getUserByUserName(userName);
        if (response.statusCode == 200 && response.data != null) {
          final user = UserModel.fromJson(response.data['user']);
          await localDataSource.createUser(user); // Cache user locally
          return Right(user);
        }
      }

      return Left(NotFoundFailure('User not found locally or on the server.'));
    } catch (e) {
      return Left(ServerFailure('Error fetching user by userName.'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getPendingSyncUsers() async {
    try {
      final users = await localDataSource.getPendingSyncUsers();
      return Right(users);
    } catch (e) {
      return Left(CacheFailure(
          'Failed to fetch pending sync users from the database.'));
    }
  }
}
