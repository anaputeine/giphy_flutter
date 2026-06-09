import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_flutter/presentation/app/bloc/app_cubit.dart';
import '../../../data/repository/fake_connectivity_repository.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late AppCubit cubit;
  late FakeConnectivityRepository fakeConnectivityRepository;
  setUp(() {
    fakeConnectivityRepository = FakeConnectivityRepository();
    cubit = AppCubit(fakeConnectivityRepository);
  });

  group('network stream', () {
    blocTest(
      'set to true',
      build: () => cubit,
      act: (cubit) => cubit.emit(true),
      verify: (cubit) {
        expect(cubit.state, true);
      },
    );
    blocTest(
      'set to false',
      build: () => cubit,
      act: (cubit) => cubit.emit(false),
      verify: (cubit) {
        expect(cubit.state, false);
      },
    );
  });
}
