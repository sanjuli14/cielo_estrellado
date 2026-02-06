import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBlockerRepository {
  static const String _boxName = 'blocked_apps';
  static const String _keyBlockedApps = 'blocked_packages';

  Future<Box> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox(_boxName);
    }
    return Hive.box(_boxName);
  }

  Future<List<String>> getBlockedPackages() async {
    final box = await _getBox();
    final List<dynamic>? stored = box.get(_keyBlockedApps);
    if (stored == null) return [];
    return stored.cast<String>().toList();
  }

  Future<void> saveBlockedPackages(List<String> packages) async {
    final box = await _getBox();
    await box.put(_keyBlockedApps, packages);
  }
  
  Future<void> toggleAppBlock(String packageName) async {
    final currentList = await getBlockedPackages();
    if (currentList.contains(packageName)) {
      currentList.remove(packageName);
    } else {
      currentList.add(packageName);
    }
    await saveBlockedPackages(currentList);
  }
}

final appBlockerRepositoryProvider = Provider<AppBlockerRepository>((ref) {
  return AppBlockerRepository();
});
