import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/responsive.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:flutter_application_1/widgets/loading_modal_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _theme = 0;

  EmailAuth auth = EmailAuth();

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _theme = (prefs.getInt('theme') ?? 0);
      prefs.setInt('theme', _theme);
    });
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  void setTheme(ThemeProvider theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (prefs.getInt('theme')) {
      case 0:
        setState(() {
          theme.setThemeData(StylesSettings.lightTheme(context));
        });
        break;
      case 1:
        setState(() {
          theme.setThemeData(StylesSettings.darkTheme(context));
        });
        break;
      case 2:
        setState(() {
          theme.setThemeData(StylesSettings.customTheme(context));
        });
        break;
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
          label: Text("EMAIL USER"), border: OutlineInputBorder()),
    );

    bool isLoading = false;

    final txtPass = TextFormField(
      controller: passController,
      decoration: const InputDecoration(
          label: Text("Password"), border: OutlineInputBorder()),
    );

    final horizontalSpace = const SizedBox(
      height: 10,
    );

    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    setTheme(theme);
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
        Future.delayed(const Duration(milliseconds: 1000)).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, '/onboard');
        });

        /*
        auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text)
            .then((value) {
          if (value) {
            Navigator.pushNamed(context, '/onboard');
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error en login')));
          }
        });
        isLoading = false;
        setState(() {});
        */
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
      'assets/images/logo_itc.png',
    );
    final imglogoM = Image.asset(
      'assets/images/logo_itc.png',
      height: 250,
    );
    final imglogoT = Image.asset(
      'assets/images/logo_itc.png',
      height: 350,
    );

    final tab_Widgets = [
      Padding(padding: EdgeInsets.only(right: 20)),
      Expanded(
        child: imgLogo,
      ),
      SizedBox(
        width: 400,
        height: 300,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
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
    ];
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
            imgLogo: imglogoM,
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
        tablet: TabletLoginScreen(
          imgLogo: imglogoT,
          txtEmail: txtEmail,
          horizontalSpace: horizontalSpace,
          txtPass: txtPass,
          buttonlogging: buttonlogging,
          googlebtn: googlebtn,
          btnGithub: btnGithub,
          txtRegister: txtRegister,
          isLoading: isLoading,
          content: tab_Widgets,
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
                  image: AssetImage('assets/images/itc_esc.jpg'))),
        ),
        Positioned(
            bottom: 30,
            right: 30,
            child: IconButton(
              iconSize: 50,
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/theme');
              },
            )),
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
            const Padding(padding: EdgeInsets.only(right: 100)),
          ],
        ),
        isLoading ? const LoadingModalWidget() : Container()
      ],
    );
  }
}

class TabletLoginScreen extends StatelessWidget {
  const TabletLoginScreen(
      {Key? key,
      required this.imgLogo,
      required this.txtEmail,
      required this.horizontalSpace,
      required this.txtPass,
      required this.buttonlogging,
      required this.googlebtn,
      required this.btnGithub,
      required this.txtRegister,
      required this.isLoading,
      required this.content})
      : super(key: key);

  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox horizontalSpace;
  final TextFormField txtPass;
  final SocialLoginButton buttonlogging;
  final SocialLoginButton googlebtn;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;
  final bool isLoading;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/itc_esc.jpg'))),
        ),
        Center(
          child: MediaQuery.of(context).size.width > 750
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: content)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: content),
        ),
        Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              iconSize: 40,
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/theme');
              },
            )),
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
                  image: AssetImage('assets/images/itc_esc.jpg'))),
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
                Positioned(
                  top: 50,
                  child: imgLogo,
                ),
                Positioned(
                    top: 20,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pushNamed(context, '/theme');
                      },
                    ))
              ],
            ),
          ),
        ),
        isLoading ? const LoadingModalWidget() : Container()
      ],
    );
  }
}
