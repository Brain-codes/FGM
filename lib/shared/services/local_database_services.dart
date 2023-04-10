import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabaseService {
  static final _box = Hive.box(DbKeyStrings.dbName);

  Future<void> add(String key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  Future<void> edit(String key, dynamic value) async {
    await _box.put(key, value);
  }

  T getAllData<T>() {
    return _box.values.toList() as T;
  }

  clear() async {
    await _box.clear();
  }

  T getData<T>(String key) {
    return _box.get(key) as T;
  }
}

mixin DbKeyStrings {
  static const userDetailsKey = 'USER_DETAILS';
  static const loginTimeCreated = 'TIME_CREATED';
  static const tokenExpiration = 'TOKEN_EXPIRATION';
  static const refreshToken = 'REFRESH_TOKEN';
  static const loginToken = 'TOKEN';
  static const onBoardedKey = 'TOKEN';
  static const businessCreateID = 'BUSINESSESID';
  static const dbName = 'FGMLocalDB';
}
