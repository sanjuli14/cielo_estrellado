import 'dart:async';
import 'package:cielo_estrellado/features/app_blocker/data/app_blocker_repository.dart';
import 'package:cielo_estrellado/features/app_blocker/data/app_blocker_service.dart';
import 'package:installed_apps/app_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBlockerState {
  final bool hasUsagePermission;
  final bool hasOverlayPermission;
  final List<AppInfo> apps;
  final List<String> blockedPackageNames;
  final bool isLoading;

  AppBlockerState({
    required this.hasUsagePermission,
    required this.hasOverlayPermission,
    required this.apps,
    required this.blockedPackageNames,
    required this.isLoading,
  });

  factory AppBlockerState.initial() {
    return AppBlockerState(
      hasUsagePermission: false,
      hasOverlayPermission: false,
      apps: [],
      blockedPackageNames: [],
      isLoading: true,
    );
  }

  AppBlockerState copyWith({
    bool? hasUsagePermission,
    bool? hasOverlayPermission,
    List<AppInfo>? apps,
    List<String>? blockedPackageNames,
    bool? isLoading,
  }) {
    return AppBlockerState(
      hasUsagePermission: hasUsagePermission ?? this.hasUsagePermission,
      hasOverlayPermission: hasOverlayPermission ?? this.hasOverlayPermission,
      apps: apps ?? this.apps,
      blockedPackageNames: blockedPackageNames ?? this.blockedPackageNames,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AppBlockerController extends Notifier<AppBlockerState> {
  
  AppBlockerService get _service => ref.read(appBlockerServiceProvider);
  AppBlockerRepository get _repository => ref.read(appBlockerRepositoryProvider);

  @override
  AppBlockerState build() {
    // Schedule initialization after the build phase
    Future.microtask(() => _init());
    return AppBlockerState.initial();
  }

  Future<void> _init() async {
    await checkPermissions();
    await _loadApps();
    await _loadBlockedApps();
    state = state.copyWith(isLoading: false);
  }

  Future<void> checkPermissions() async {
    final hasUsage = await _service.checkPermission();
    final hasOverlay = await _service.checkOverlayPermission();
    state = state.copyWith(
      hasUsagePermission: hasUsage,
      hasOverlayPermission: hasOverlay,
    );
  }

  Future<void> requestUsagePermission() async {
    await _service.grantPermission();
    // After returning (app resume), we should check again, which is handled in UI lifecycle
  }

  Future<void> requestOverlayPermission() async {
    await _service.grantOverlayPermission();
  }

  Future<void> _loadApps() async {
    final allApps = await _service.getInstalledApps();
    // AppInfo always has icon if requested.
    // Sort by name
    allApps.sort((a, b) => (a.name ?? '').toLowerCase().compareTo((b.name ?? '').toLowerCase()));
    
    state = state.copyWith(apps: allApps);
  }

  Future<void> _loadBlockedApps() async {
    final blocked = await _repository.getBlockedPackages();
    state = state.copyWith(blockedPackageNames: blocked);
  }

  Future<void> toggleAppBlock(String packageName) async {
    await _repository.toggleAppBlock(packageName);
    await _loadBlockedApps();
  }
}

final appBlockerControllerProvider = NotifierProvider<AppBlockerController, AppBlockerState>(() {
  return AppBlockerController();
});
