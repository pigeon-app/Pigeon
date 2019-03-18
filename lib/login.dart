import 'package:flutter/material.dart';
import 'home.dart';

class LandingScreen extends StatefulWidget {
  @override
  LandingScreenState createState() {
    return LandingScreenState();
  }
}

class LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {

  AnimationController enterController;
  Animation<double> titleOpacity;
  Animation<double> subtitleOpacity;
  Animation<double> loginOpacity;
  Animation<double> registerOpacity;

  String _pressed = "";

  @override
  void dispose() {
    enterController?.dispose();
    super.dispose();
  }

  Future<void> _playEnterAnimation() async {
    try {
      await enterController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  void _statusListener(AnimationStatus status) async {
    if (status == AnimationStatus.reverse) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => (_pressed == "login") ? LoginScreen() : RegisterScreen()));
        
        enterController.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    enterController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );

    titleOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: Interval(
          0.2, 0.7,
        ),
      ),
    );

    subtitleOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: Interval(
          0.3, 0.8,
        ),
      ),
    );

    loginOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: Interval(
          0.4, 0.9,
        ),
      ),
    );

    registerOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: Interval(
          0.5, 1.0,
        ),
      ),
    );

    enterController.addStatusListener(_statusListener);

    _playEnterAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: enterController,
      builder: (context, child) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 192.0, horizontal: 64.0),
            children: <Widget>[
              Opacity(
                opacity: titleOpacity.value,
                child: Text(
                  "Pigeon",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.display2.fontSize * 0.9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Opacity(
                opacity: subtitleOpacity.value,
                child: Text(
                  "Crowdsourced food transport.",
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              SizedBox(height: 192.0),
              Opacity(
                opacity: (_pressed == "login") ? 1 : loginOpacity.value,
                child: Hero(
                  tag: "login",
                  child: ButtonTheme(
                    height: 48,
                    child: RaisedButton(
                      onPressed: () {
                        _pressed = "login";
                        enterController.reverse();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text('LOG IN'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Opacity(
                opacity: (_pressed == "register") ? 1 : registerOpacity.value,
                child: Hero(
                  tag: "register",
                  child: ButtonTheme(
                    height: 48,
                    child: RaisedButton(
                      onPressed: () {
                        _pressed = "register";
                        enterController.reverse();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text('REGISTER'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 192.0, horizontal: 32.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username"
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password"
              ),
            ),
            SizedBox(height: 48.0),
            Hero(
              tag: "login",
              child: ButtonTheme(
                height: 48,
                child: RaisedButton(
                  onPressed: () {
                    // TODO: Proper login handling
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(name: "Shreya Nagpal"),
                        ), (route) => false);
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text('LOG IN'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 192.0, horizontal: 32.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email"
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username"
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password"
              ),
            ),
            SizedBox(height: 48.0),
            Hero(
              tag: "register",
              child: ButtonTheme(
                height: 48,
                child: RaisedButton(
                  onPressed: () { },
                  color: Theme.of(context).primaryColor,
                  child: Text('REGISTER'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}