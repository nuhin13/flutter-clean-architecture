import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rickmorty/layers/presentation/using_provider/view/character_page.dart';

import '../../../../../fixtures/fixtures.dart';
import '../../helper/pump_app.dart';

void main() {
  group('CharacterPage', () {
    late GetAllCharactersMock getAllCharactersMock;

    setUp(() async {
      getAllCharactersMock = GetAllCharactersMock();
      when(() => getAllCharactersMock.call(page: any(named: 'page')))
          .thenAnswer((_) async => [...characterList1, ...characterList2]);
    });

    testWidgets('renders a CharacterView', (tester) async {
      await tester.pumpApp(
        const CharacterPage(),
        getAllCharacters: getAllCharactersMock,
      );

      expect(find.byType(CharacterView), findsOneWidget);
    });

    testWidgets('renders a grid of Characters widgets', (tester) async {
      const key = Key('character_page_list_key');

      await tester.pumpApp(
        const CharacterPage(),
        getAllCharacters: getAllCharactersMock,
      );

      await tester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expectLater(
        find.byType(CharacterCard),
        findsNWidgets([...characterList1, ...characterList2].length),
      );
    });
  });
}