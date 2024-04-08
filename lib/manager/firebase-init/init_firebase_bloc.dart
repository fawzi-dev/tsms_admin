import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_core/firebase_core.dart' as firebaseCore;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:tsms_admin/models/app_version.dart';
import 'package:tsms_admin/utils/firebase_constants.dart';
import 'package:tsms_admin/utils/firebase_package_helper.dart';

part 'init_firebase_event.dart';
part 'init_firebase_state.dart';

class InitFirebaseBloc extends Bloc<InitFirebaseEvent, InitFirebaseState> {
  InitFirebaseBloc() : super(InitFirebaseInitial()) {
    on<InitFirebaseEvent>((event, emit) async {
      if (event is InitializeFirebase) {
        await firebaseFirestore
            .collection(collection)
            .doc(document)
            .set(
              AppVersionModel(version: 1.0).toJson(),
            )
            .then((value) {
          emit(
            InitFirebaseSuccess(),
          );
        });
      }

      if (event is UpdateVersion) {
        await firebaseFirestore
            .collection(collection)
            .doc(document)
            .update(
              AppVersionModel(version: event.version).toJson(),
            )
            .then((value) {
          emit(
            InitFirebaseSuccess(),
          );
        });
      }
    });
  }
}
