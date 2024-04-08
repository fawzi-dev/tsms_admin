part of 'init_firebase_bloc.dart';

@immutable
sealed class InitFirebaseEvent {}

class InitializeFirebase extends InitFirebaseEvent {}

class UpdateVersion extends InitFirebaseEvent {
  final double version;

  UpdateVersion({required this.version});
}
