import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constant/app_keys.dart';

const _secureStorage = FlutterSecureStorage();

Future<void> saveSeedPhrase(dynamic id, String seedPhrase) async {
  await _secureStorage.write(key: "seed_$id", value: seedPhrase);
}

Future<String?> loadSeedPhrase(dynamic id) async {
  return _secureStorage.read(key: "seed_$id");
}

Future<bool> seedPhraseExists(int id) {
  return _secureStorage.containsKey(key: "seed_$id");
}

Future<void> savePinCode(String pinCode) async {
  await _secureStorage.write(key: AppKeys.pinCode, value: pinCode);
}

Future<String?> loadPinCode() async {
  return _secureStorage.read(key: AppKeys.pinCode);
}

Future<bool> pinCodeExists() {
  return _secureStorage.containsKey(key: AppKeys.pinCode);
}

Future<void> saveWif(String address, String wif) async {
  await _secureStorage.write(key: address, value: wif);
}

Future<String?> loadWif(String address) async {
  return _secureStorage.read(key: address);
}

Future<void> saveWalletWif(int id, String wif) async {
  await _secureStorage.write(key: "private_$id", value: wif);
}

Future<String?> loadWalletWif(dynamic id) async {
  return _secureStorage.read(key: "private_$id");
}

Future<bool> privateKeyExist(){
  return _secureStorage.containsKey(key: 'private_key');

}
Future<void> savePrivateKey(String privateKey)async {
  await _secureStorage.write(key: 'private_key', value: privateKey);
}

Future<String?> loadPrivateKey()async{
  await _secureStorage.read(key: 'private_key');
}