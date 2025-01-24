import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';

class SyncUsers {
  final UserRepository repository;

  SyncUsers(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.syncUsers();
  }
}
