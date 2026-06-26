import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class StorageInitializer {
  StorageInitializer._();

  static Future<void> initialize() async {
    await Hive.initFlutter();
  }
}
