import 'package:dartz/dartz.dart';
import 'package:hoxton/register_form/domain/repo/repo_base.dart';

class RegisterUserUsecase {
  RegisterUserUsecase({
    required this.repositoryBase,
  });

  final RepositoryBase repositoryBase;

  Future<Either<String, String>> call(Map<String, dynamic> userData) async {
    try {
      final String msg = await repositoryBase.registerUser(userData);
      return Right(msg);
    } catch (e) {
      return Left("Registration failed: ${e.toString()}");
    }
  }
}
