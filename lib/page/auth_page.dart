import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:proyectofinal2/widget/login_widget.dart';
import 'package:proyectofinal2/widget/signup_widget.dart';


class AuthPage extends StatefulWidget {

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
    isLogin ? LoginWidget(onClickedSignUp : toggle)
    :SignUpWidget(onClickedSignUp : toggle);
  void toggle()=> setState(() => isLogin = !isLogin);
}