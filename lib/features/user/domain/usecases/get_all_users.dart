import 'package:cleanarchitecture/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';

class GetAllUsers {
  final UserRepository repository;

  GetAllUsers(this.repository);

  Future<Either<Failure, List<UserModel>>> call() async {
    return await repository.getAllUsers();
  }
}
