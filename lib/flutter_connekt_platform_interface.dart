import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_connekt_method_channel.dart';

abstract class FlutterConnektPlatform extends PlatformInterface {
  /// Constructs a FlutterConnektPlatform.
  FlutterConnektPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterConnektPlatform _instance = MethodChannelFlutterConnekt();

  /// The default instance of [FlutterConnektPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterConnekt].
  static FlutterConnektPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterConnektPlatform] when
  /// they register themselves.
  static set instance(FlutterConnektPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
