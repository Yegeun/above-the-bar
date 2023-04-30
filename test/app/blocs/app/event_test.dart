import 'package:above_the_bar/models/user_model.dart';
import 'package:above_the_bar/bloc/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements UserModel {}

void main() {
  group('AppEvent', () {
    group('AppLogoutRequested', () {
      test('supports value based equality', () {
        expect(
          const AuthLogoutRequested(),
          equals(const AuthLogoutRequested()),
        );
      });
    });

    group('AppUserChanged', () {
      final user = MockUser();

      test('supports value based equality', () {
        expect(
          AuthUserChanged(user),
          equals(AuthUserChanged(user)),
        );
      });
    });
  });
}
