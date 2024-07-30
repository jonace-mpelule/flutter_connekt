import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_connekt/flutter_connekt.dart';
import 'package:flutter_connekt/flutter_connekt_platform_interface.dart';
import 'package:flutter_connekt/flutter_connekt_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterConnektPlatform
    with MockPlatformInterfaceMixin
    implements FlutterConnektPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterConnektPlatform initialPlatform = FlutterConnektPlatform.instance;

  test('$MethodChannelFlutterConnekt is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterConnekt>());
  });

  test('getPlatformVersion', () async {
    FlutterConnekt flutterConnektPlugin = FlutterConnekt();
    MockFlutterConnektPlatform fakePlatform = MockFlutterConnektPlatform();
    FlutterConnektPlatform.instance = fakePlatform;

    expect(await flutterConnektPlugin.getPlatformVersion(), '42');
  });
}
