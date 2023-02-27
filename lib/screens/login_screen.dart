import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/responsive.dart';
import 'package:flutter_application_1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final txtEmail = TextFormField(
    decoration: const InputDecoration(
        label: Text("EMAIL USER"), border: OutlineInputBorder()),
  );

  bool isLoading = false;

  final txtPass = TextFormField(
    decoration: const InputDecoration(
        label: Text("Password"), border: OutlineInputBorder()),
  );

  final horizontalSpace = const SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    final txtRegister = Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text(
          "Crear cuenta",
          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
        ),
      ),
    );
    final buttonlogging = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 4000)).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      },
    );
    final googlebtn = SocialLoginButton(
      buttonType: SocialLoginButtonType.twitter,
      onPressed: () {},
    );
    final btnGithub = SocialLoginButton(
      buttonType: SocialLoginButtonType.github,
      onPressed: () {},
    );

    final imgLogo = Image.asset(
      'assets/logo_itc.png',
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Responsive(
        mobile: MobileLoginScreen(
            txtEmail: txtEmail,
            horizontalSpace: horizontalSpace,
            txtPass: txtPass,
            buttonlogging: buttonlogging,
            googlebtn: googlebtn,
            btnGithub: btnGithub,
            txtRegister: txtRegister,
            imgLogo: imgLogo,
            isLoading: isLoading),
        desktop: DesktopLoginScreen(
          imgLogo: imgLogo,
          txtEmail: txtEmail,
          horizontalSpace: horizontalSpace,
          txtPass: txtPass,
          buttonlogging: buttonlogging,
          googlebtn: googlebtn,
          btnGithub: btnGithub,
          txtRegister: txtRegister,
          isLoading: isLoading,
        ),
      ),
    );
  }
}

class DesktopLoginScreen extends StatelessWidget {
  const DesktopLoginScreen({
    Key? key,
    required this.imgLogo,
    required this.txtEmail,
    required this.horizontalSpace,
    required this.txtPass,
    required this.buttonlogging,
    required this.googlebtn,
    required this.btnGithub,
    required this.txtRegister,
    required this.isLoading,
  }) : super(key: key);

  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox horizontalSpace;
  final TextFormField txtPass;
  final SocialLoginButton buttonlogging;
  final SocialLoginButton googlebtn;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/itc_esc.jpg'))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: imgLogo,
            ),
            SizedBox(
              width: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  txtEmail,
                  horizontalSpace,
                  txtPass,
                  horizontalSpace,
                  buttonlogging,
                  horizontalSpace,
                  googlebtn,
                  horizontalSpace,
                  btnGithub,
                  txtRegister
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 100))
          ],
        ),
        isLoading ? const LoadingModalWidget() : Container()
      ],
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
    required this.txtEmail,
    required this.horizontalSpace,
    required this.txtPass,
    required this.buttonlogging,
    required this.googlebtn,
    required this.btnGithub,
    required this.txtRegister,
    required this.imgLogo,
    required this.isLoading,
  }) : super(key: key);

  final TextFormField txtEmail;
  final SizedBox horizontalSpace;
  final TextFormField txtPass;
  final SocialLoginButton buttonlogging;
  final SocialLoginButton googlebtn;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;
  final Image imgLogo;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/itc_esc.jpg'))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    txtEmail,
                    horizontalSpace,
                    txtPass,
                    horizontalSpace,
                    buttonlogging,
                    horizontalSpace,
                    googlebtn,
                    horizontalSpace,
                    btnGithub,
                    txtRegister
                  ],
                ),
                SizedBox(
                  height: 250,
                  child: Positioned(
                    top: 100,
                    child: imgLogo,
                  ),
                )
              ],
            ),
          ),
        ),
        isLoading ? const LoadingModalWidget() : Container()
      ],
    );
  }
}
