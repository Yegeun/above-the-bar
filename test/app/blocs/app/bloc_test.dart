import 'package:bloc_test/bloc_test.dart';
import 'package:above_the_bar/auth_service.dart';
import 'package:above_the_bar/models/user_model.dart';
import 'package:above_the_bar/bloc/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements UserModel {}

void main() {
  group('AppBloc', () {
    late AuthService authService;

    setUp(() {
      authService = MockAuthService();
      when(() => authService.user).thenAnswer(
        (_) => Stream.empty(),
      );
      when(
        () => authService.currentUser,
      ).thenReturn(UserModel.empty);
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'invokes logOut',
        setUp: () {
          when(
            () => authService.logout(),
          ).thenAnswer((_) async {});
        },
        build: () => AuthBloc(authService: authService),
        act: (bloc) => bloc.add(AuthLogoutRequested()),
        verify: (_) {
          verify(() => authService.logout()).called(1);
        },
      );
    });
  });
}
