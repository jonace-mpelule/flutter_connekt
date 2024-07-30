import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_connekt_platform_interface.dart';

/// An implementation of [FlutterConnektPlatform] that uses method channels.
class MethodChannelFlutterConnekt extends FlutterConnektPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_connekt');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
