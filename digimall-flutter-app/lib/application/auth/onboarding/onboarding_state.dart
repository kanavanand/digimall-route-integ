part of 'onboarding_bloc.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @required bool isLoading,
    @required String businessName,
    @required String category,
    @required String address,
    @required int step,
    Address getAddress,
    File file,
    @required Option<Either<FirebaseFailure, Unit>> failureOption,
  }) = _OnboardingState;

  factory OnboardingState.initial() => OnboardingState(
        isLoading: false,
        businessName: '',
        category: 'Select category',
        address: '',
        failureOption: none(),
        step: 1,
      );
}
