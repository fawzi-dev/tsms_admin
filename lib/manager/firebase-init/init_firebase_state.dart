part of 'init_firebase_bloc.dart';

@immutable
sealed class InitFirebaseState {}

final class InitFirebaseInitial extends InitFirebaseState {}

final class InitFirebaseLoading extends InitFirebaseState {}

final class InitFirebaseSuccess extends InitFirebaseState {}

final class InitFirebaseFailed extends InitFirebaseState {}
