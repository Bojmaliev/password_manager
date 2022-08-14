import 'package:password_manager/services/encrypt.dart';
import 'package:encrypt/encrypt.dart';

class EncryptImpl implements Encrypt {
  late Encrypter encrypter;
  late IV iv;

  EncryptImpl(String password) {
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
