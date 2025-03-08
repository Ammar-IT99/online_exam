import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheNetwork {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();


  static Future<void> insertToCache({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getCacheData({required String key}) async {
    return await _secureStorage.read(key: key);
  }


  static Future<void> deleteCacheItem({required String key}) async {
    await _secureStorage.delete(key: key);
  }


  static Future<void> clearData() async {
    await _secureStorage.deleteAll();
  }
}