import 'package:password_manager/services/encrypt_service.dart';
import 'package:encrypt/encrypt.dart';

class EncryptServiceImpl implements EncryptService {
  late Encrypter encrypter;
  late IV iv;

  EncryptServiceImpl(String password) {
    final key = Key.fromUtf8(password);
    iv = IV.fromLength(16);
    encrypter = Encrypter(AES(key));
  }

  @override
  String decrypt(String text) {
    return encrypter.decrypt64(text, iv: iv);
  }

  @override
  String encrypt(String text) {
    return encrypter.encrypt(text, iv: iv).base64;
  }
}
