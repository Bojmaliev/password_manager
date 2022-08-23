import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/encrypt_service.dart';
import 'package:password_manager/services/impl/base_service_impl.dart';

class LoginCredentialService extends BaseServiceImpl<LoginCredential> {
  @override
  Future<List<LoginCredential>> getAll() async {
    var credential = await super.getAll();
    EncryptService encrypt = await getIt.getAsync<EncryptService>();
    return credential.map((e) {
      e.password = encrypt.decrypt(e.password);
      return e;
    }).toList();
  }

  @override
  Future<int> insert(LoginCredential entity) async {
    EncryptService encrypt = await getIt.getAsync<EncryptService>();

    entity.password = encrypt.encrypt(entity.password);
    return super.insert(entity);
  }

  @override
  Future<bool> update(LoginCredential entity) async {
    EncryptService encrypt = await getIt.getAsync<EncryptService>();

    entity.password = encrypt.encrypt(entity.password);
    return super.update(entity);
  }

  @override
  Future<LoginCredential> getOne(int id) async {
    EncryptService encrypt = await getIt.getAsync<EncryptService>();
    var credential = await super.getOne(id);
    credential.password = encrypt.decrypt(credential.password);
    return credential;
  }
}
