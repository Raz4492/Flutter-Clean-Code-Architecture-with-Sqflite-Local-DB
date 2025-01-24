
import 'package:cleanarchitecture/core/errors/failure.dart';
import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:cleanarchitecture/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<Either<Failure, void>> call(UserModel user) async {
    try {
      await repository.updateUser(user);  // Create user in the repository
      return Right(null);  // Return Right with null to indicate success
    } catch (e) {
      return Left(ServerFailure('Failed to update user.'));  // Return Left with a failure message if an error occurs
    }
  }
}
