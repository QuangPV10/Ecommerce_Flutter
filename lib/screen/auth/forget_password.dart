import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/services/global_method.dart';
import 'package:toast/toast.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = '/ForgetPassword';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _emailAddress = '';

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        await _auth
            .sendPasswordResetEmail(email: _emailAddress.toLowerCase())
            .then((value) => Toast.show("An email has been sent", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM));
        Navigator.canPop(context) ? Navigator.pop(context) : null;
        ;
      } catch (error) {
        _globalMethods.authErrorHandle(error.message, context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Forget Password',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: TextFormField(
                key: ValueKey('email'),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valied email address';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email address',
                  fillColor: Theme.of(context).backgroundColor,
                ),
                onSaved: (value) {
                  _emailAddress = value;
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: _submitForm,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reset Password',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.vpn_key_rounded,
                            size: 20,
                          )
                        ],
                      )),
                )
        ],
      ),
    );
  }
}
