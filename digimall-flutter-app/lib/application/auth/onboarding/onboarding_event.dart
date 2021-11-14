part of 'onboarding_bloc.dart';

@freezed
abstract class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.initial() = _Initial;
  const factory OnboardingEvent.getDataStep1({
    @required String name,
  }) = _GetDataStep1;
  const factory OnboardingEvent.getDataStep2AndSave({
    @required String address,
  }) = _GetDataStep2AndSave;
  const factory OnboardingEvent.getFile({
    @required File file,
  }) = _GetFile;
  const factory OnboardingEvent.getCategory({
    @required String category,
  }) = _GetCategory;
}
