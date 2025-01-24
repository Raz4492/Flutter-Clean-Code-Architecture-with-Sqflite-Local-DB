import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../repositories/user_repository.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<Either<Failure, void>> call(UserModel user) async {
    try {
      await repository.createUser(user);  // Create user in the repository
      return Right(null);  // Return Right with null to indicate success
    } catch (e) {
      return Left(ServerFailure('Failed to create user.'));  // Return Left with a failure message if an error occurs
    }
  }
}
