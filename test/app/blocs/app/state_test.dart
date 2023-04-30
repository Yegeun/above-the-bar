import 'package:above_the_bar/models/user_model.dart';
import 'package:above_the_bar/bloc/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements UserModel {}

void main() {
  group('AppState', () {
    group('unauthenticated', () {
      test('has correct status', () {
        final state = AuthState.unauthenticated();
        expect(state.status, AuthStatus.unauthenticated);
        expect(state.user, UserModel.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final user = MockUser();
        final state = AuthState.authenticated(user);
        expect(state.status, AuthStatus.authenticated);
        expect(state.user, user);
      });
    });
  });
}
