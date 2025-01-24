import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, void>> call(String userName) async {
    return await repository.deleteUser(userName);
  }
}
