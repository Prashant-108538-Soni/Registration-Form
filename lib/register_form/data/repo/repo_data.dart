import 'package:hoxton/register_form/data/datasource/datasource.dart';
import 'package:hoxton/register_form/domain/repo/repo_base.dart';

class Repository extends RepositoryBase {
  Repository(this.dataSource);

  final DataSource dataSource;

  @override
  Future<String> registerUser(Map<String, dynamic> userData) async {
    return await dataSource.registerUser(userData);
  }
}
