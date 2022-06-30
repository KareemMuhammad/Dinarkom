import 'package:bloc/bloc.dart';
import 'package:dinarkom/blocs/verification_bloc/verify_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyCubit extends Cubit<VerifyState>{
  VerifyCubit() : super(const CurrentVerification(false));

  bool _isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  void toFalse() => const CurrentVerification(false);

  void toTrue() => const CurrentVerification(true);

  bool get isVerified => _isVerified;

  set isVerified(bool value) {
    _isVerified = value;
    emit(CurrentVerification(value));
  }
}