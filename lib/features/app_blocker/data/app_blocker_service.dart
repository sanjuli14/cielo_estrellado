import 'dart:async';
import 'package:flutter/services.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_blocker_repository.dart';

class AppBlockerService {
  final AppBlockerRepository _repository;
  Timer? _monitoringTimer;
  bool _isMonitoring = false;
  
  static const _channel = MethodChannel('com.example.cielo_estrellado/usage');

  AppBlockerService(this._repository);

  Future<bool> checkPermission() async {
    try {
      final bool result = await _channel.invokeMethod('checkPermission');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check permission: '${e.message}'.");
      return false;
    }
  }

  Future<void> grantPermission() async {
    try {
      await _channel.invokeMethod('grantPermission');
    } on PlatformException catch (e) {
      print("Failed to grant permission: '${e.message}'.");
    }
  }

  Future<bool> checkOverlayPermission() async {
    try {
      final bool result = await _channel.invokeMethod('checkOverlayPermission');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check overlay permission: '${e.message}'.");
      return false;
    }
  }

  Future<void> grantOverlayPermission() async {
    try {
      await _channel.invokeMethod('requestOverlayPermission');
    } on PlatformException catch (e) {
      print("Failed to grant overlay permission: '${e.message}'.");
    }
  }

  Future<List<AppInfo>> getInstalledApps() async {
    return await InstalledApps.getInstalledApps(withIcon: true, packageNamePrefix: '');
  }

  void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    
    // Check every 1 second
    _monitoringTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _checkForegroundApp();
    });
  }

  void stopMonitoring() {
    _monitoringTimer?.cancel();
    _monitoringTimer = null;
    _isMonitoring = false;
  }

  Future<void> _checkForegroundApp() async {
    try {
      final hasPermission = await checkPermission();
      if (!hasPermission) {
        print('AppBlocker: No permission');
        return;
      }

      final String? currentPackage = await _channel.invokeMethod('getForegroundApp');
      print('AppBlocker: Detected foreground app: $currentPackage');

      if (currentPackage != null) {
        // Don't block ourselves
        if (currentPackage == 'com.example.cielo_estrellado') return; 
        
        final blockedPackages = await _repository.getBlockedPackages();
        print('AppBlocker: Blocked list: $blockedPackages');
        
        if (blockedPackages.contains(currentPackage)) {
           print('AppBlocker: BLOCKING $currentPackage');
           // Blocked app!
           await _channel.invokeMethod('bringToForeground');
        }
      }
    } catch (e) {
      print('Error checking usage stats: $e');
    }
  }
}

final appBlockerServiceProvider = Provider<AppBlockerService>((ref) {
  final repo = ref.watch(appBlockerRepositoryProvider);
  return AppBlockerService(repo);
});
