import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'athu_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
      emit(AuthSuccess(user:user! ));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> register({required String email, required String password,
   required String phoneNumber,required String userName}) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'name': userName,
          'phone_number': phoneNumber,
        });
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(message: 'User registration failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? 'An unknown error occurred'));
    }
  }
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
