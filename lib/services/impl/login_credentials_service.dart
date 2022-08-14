import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/encrypt.dart';
import 'package:password_manager/services/impl/base_service_impl.dart';

class LoginCredentialService extends BaseServiceImpl<LoginCredential> {
  final Encrypt encrypt = getIt<Encrypt>();

  @override
  Future<int> insert(LoginCredential entity) {
    entity.password = encrypt.encrypt(entity.password);
    return super.insert(entity);
  }

  @override
  Future<bool> update(LoginCredential entity) {
    entity.password = encrypt.encrypt(entity.password);
    return super.update(entity);
  }

  @override
  Future<LoginCredential> getOne(int id) async {
    var credential = await super.getOne(id);
    credential.password = encrypt.decrypt(credential.password);
    return credential;
  }
}
