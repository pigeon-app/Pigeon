import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  AnimationController enterController;
  Animation<double> titleOpacity;
  Animation<double> subtitleOpacity;
  Animation<double> loginOpacity;
  Animation<double> registerOpacity;

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

  @override
  void initState() {
    super.initState();

    enterController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    titleOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: enterController,
        curve: Interval(
          0.0, 0.7,
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
          0.1, 0.8,
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
          0.2, 0.9,
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
          0.3, 1.0,
        ),
      ),
    );
    // test

    _playEnterAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: enterController,
      builder: (context, child) {
        return Scaffold(
          // backgroundColor: Theme.of(context).primaryColor,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
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
                  opacity: loginOpacity.value,
                  child: ButtonTheme(
                    height: 48,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('LOG IN'),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Opacity(
                  opacity: registerOpacity.value,
                    child: ButtonTheme(
                    height: 48,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('REGISTER'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
