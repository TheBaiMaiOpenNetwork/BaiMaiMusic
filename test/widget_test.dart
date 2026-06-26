import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baimai_music/app.dart';

void main() {
  testWidgets('BaiMai Music smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: BaiMaiMusicApp()),
    );
    // Verify the app launches without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
