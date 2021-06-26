import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contactor_picker/contactor_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('contactor_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {

  });
}
