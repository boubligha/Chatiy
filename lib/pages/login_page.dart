import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  late double _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: _loginPageUI(),
        ),
      ),
    );
  }

  Widget _loginPageUI() {
    return Builder(builder: (BuildContext _context) {
      _auth = Provider.of<AuthProvider>(_context);
      return Container(
        height: _deviceHeight * 0.60,
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingWidget(),
            _inputForm(),
            _loginButton(),
            _registerButton()
          ],
        ),
      );
    });
  }

  Widget _headingWidget() {
    return SizedBox(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Please login to your account.",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return SizedBox(
      height: _deviceHeight * 0.3,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (input) {
        if (input!.isEmpty) {
          return "Please enter your email";
        }
        if (!input.contains("@")) {
          return "Please enter a valid email";
        }
        return null;
      },
      onSaved: (newValue) {
        setState(() {
          _email = newValue!;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Email",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true, // Hide password
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (input) {
        if (input!.isEmpty) {
          return "Please enter your password";
        }
        return null;
      },
      onSaved: (newValue) {
        setState(() {
          _password = newValue!;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        color: Colors.blue,
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        // Navigate to register page
      },
      child: SizedBox(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
