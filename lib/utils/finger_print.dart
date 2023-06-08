
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrint {
  static final localAuth = LocalAuthentication();

  static Future<bool> supportsBiometrics() async {
    return await localAuth.canCheckBiometrics;
  }

  static Future<bool> supportsFingerPrint() async {
    List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return true;
    }

    return false;
  }

  static Future<bool> authenticate() async {
    print("hi4");
    try {
      return await localAuth.authenticate(
          localizedReason: 'fingerprint_auth_message'.tr,
          options: const AuthenticationOptions(biometricOnly: true));
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeee");
      print(e);
      return false;
    }
  }
}
