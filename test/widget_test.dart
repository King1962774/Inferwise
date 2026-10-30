import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inferwise/main.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(); // 🔥 Asegura que Firebase esté listo antes de cualquier test
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construir la app y disparar un frame.
    await tester.pumpWidget(const InferwiseApp()); // ✅ Asegúrate de que sea const si tu clase lo permite

    // Verifica que el contador comience en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Simula tap en el icono '+'
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador ahora muestre 1.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

