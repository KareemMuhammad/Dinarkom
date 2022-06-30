import 'dart:async';
import 'package:dinarkom/blocs/verification_bloc/verify_cubit.dart';
import 'package:dinarkom/blocs/verification_bloc/verify_state.dart';
import 'package:dinarkom/screens/auth/verification_screen.dart';
import 'package:dinarkom/screens/main_screen.dart';
import 'package:dinarkom/utils/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({Key? key}) : super(key: key);

  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  bool canResendEmail = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if(!BlocProvider.of<VerifyCubit>(context).isVerified){
      sendEmailVerification();
      _timer = Timer.periodic(
          const Duration(seconds: 10), (timer) {
            debugPrint('check');
        checkEmailVerification();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCubit,VerifyState>(
      builder: (context,state) {
        return state.isVerified ?
        const MainScreen() : VerificationScreen(canResend: canResendEmail,);
      }
    );
  }

  void sendEmailVerification() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    }catch(e){
      Utils.showSnack('', e.toString(), context, greyOpacity);
    }
  }

  void checkEmailVerification() async{
    await FirebaseAuth.instance.currentUser!.reload();
      BlocProvider.of<VerifyCubit>(context).isVerified =
          FirebaseAuth.instance.currentUser!.emailVerified;
    if(BlocProvider.of<VerifyCubit>(context).isVerified) _timer!.cancel();
  }

}
