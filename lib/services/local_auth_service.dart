abstract class LocalAuthService {
  Future<bool> authenticateWithBiometrics(String reason);
  Future<bool> authenticateWithPassword(String password);
  Future<bool> hasPassword();
  Future<void> setPassword(String password);
  Future<String?> getPassword();
}
