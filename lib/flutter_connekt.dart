// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/io.dart';

class FlutterConnekt {
  static void initialize() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      serializeWidgetTree();
    });
  }

  static void serializeWidgetTree() {
    final RenderObject? rootRenderObject =
        WidgetsBinding.instance.rootElement?.renderObject;

    if (rootRenderObject == null) {
      if (kDebugMode) {
        print('No render object found');
      }
      return;
    }

    final Map<String, dynamic> serializedTree =
        serializeRenderObject(rootRenderObject);

    //SEND SERIALIZED DATA
    sendSerializedData(serializedTree.toString());
  }

  static Map<String, dynamic> serializeRenderObject(RenderObject renderObject) {
    final Map<String, dynamic> result = {
      'type': renderObject.runtimeType.toString(),
      'constraints': renderObject.constraints.toString(),
      'size': {
        'width': renderObject.paintBounds.width,
        'height': renderObject.paintBounds.height,
      },
    };

    if (renderObject is RenderBox) {
      result['size'] = {
        'width': renderObject.size.width,
        'height': renderObject.size.height,
      };
    }

    if (renderObject is RenderObjectWithChildMixin) {
      if (renderObject.child != null) {
        result['child'] = serializeRenderObject(renderObject.child!);
      }
    } else if (renderObject is ContainerRenderObjectMixin) {
      List<Map<String, dynamic>> children = [];
      renderObject.visitChildren((child) {
        children.add(serializeRenderObject(child));
      });

      result['children'] = children;
    }

    return result;
  }

  static void sendSerializedData(String data) {
    final channel = IOWebSocketChannel.connect('ws://localhost:8080');
    channel.sink.add(data);
    channel.sink.close();
  }

  Future<String?> getPlatformVersion() async {
    final channel = IOWebSocketChannel.connect('ws://localhost:8080');
    final version = await channel.stream.first as String?;
    channel.sink.close();
    return version;
  }
}
