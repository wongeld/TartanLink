import 'dart:convert';
import 'package:flutter/material.dart';

class InlineImage extends StatelessWidget {
  final String keyName;
  final double? width;
  final double? height;
  final BoxFit fit;

  InlineImage(this.keyName, {this.width, this.height, this.fit = BoxFit.cover});

  static const Map<String, String> _images = {
    'onboard1': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP4BwQACfsD/QV3kQAAAABJRU5ErkJggg==',
    'onboard2': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP4BwQACfsD/QV3kQAAAABJRU5ErkJggg==',
    'onboard3': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP4BwQACfsD/QV3kQAAAABJRU5ErkJggg==',
    'sample1': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP4BwQACfsD/QV3kQAAAABJRU5ErkJggg==',
    'sample2': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP4BwQACfsD/QV3kQAAAABJRU5ErkJggg==',
    'sample3': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGP4BwQACfsD/QV3kQAAAABJRU5ErkJggg==',
  };

  @override
  Widget build(BuildContext context) {
    final b64 = _images[keyName] ?? _images['sample1']!;
    final bytes = base64Decode(b64);
    return Image.memory(bytes, width: width, height: height, fit: fit);
  }
}
