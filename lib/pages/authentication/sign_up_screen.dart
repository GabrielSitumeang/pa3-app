import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pa3/helper/firebase_auth.dart';
import 'package:pa3/pages/authentication/login_screen.dart';
import 'package:pa3/pages/nav_page.dart';
import 'package:pa3/theme.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        // body: Padding(
        //   padding: const EdgeInsets.all(24.0),
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Form(
        //           key: _registerFormKey,
        //           child: Column(
        //             children: <Widget>[
        //               TextFormField(
        //                 controller: _nameTextController,
        //                 focusNode: _focusName,
        //                 validator: (value) => Validator.validateName(
        //                   name: value,
        //                 ),
        //                 decoration: InputDecoration(
        //                   hintText: "Name",
        //                   errorBorder: UnderlineInputBorder(
        //                     borderRadius: BorderRadius.circular(6.0),
        //                     borderSide: BorderSide(),
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(height: 12.0),
        //               TextFormField(
        //                 controller: _emailTextController,
        //                 focusNode: _focusEmail,
        //                 validator: (value) => Validator.validateEmail(
        //                   email: value,
        //                 ),
        //                 decoration: InputDecoration(
        //                   hintText: "Email",
        //                   errorBorder: UnderlineInputBorder(
        //                     borderRadius: BorderRadius.circular(6.0),
        //                     borderSide: BorderSide(
        //                       color: Colors.red,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(height: 12.0),
        //               TextFormField(
        //                 controller: _passwordTextController,
        //                 focusNode: _focusPassword,
        //                 obscureText: true,
        //                 validator: (value) => Validator.validatePassword(
        //                   password: value,
        //                 ),
        //                 decoration: InputDecoration(
        //                   hintText: "Password",
        //                   errorBorder: UnderlineInputBorder(
        //                     borderRadius: BorderRadius.circular(6.0),
        //                     borderSide: BorderSide(
        //                       color: Colors.red,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(height: 32.0),
        //               _isProcessing
        //                   ? CircularProgressIndicator()
        //                   : Row(
        //                       children: [
        //                         Expanded(
        //                           child: ElevatedButton(
        //                             onPressed: () async {
        //                               setState(() {
        //                                 _isProcessing = true;
        //                               });

        //                               if (_registerFormKey.currentState!
        //                                   .validate()) {
        //                                 User? user = await FirebaseAuthHelper
        //                                     .registerUsingEmailPassword(
        //                                   name: _nameTextController.text,
        //                                   email: _emailTextController.text,
        //                                   password:
        //                                       _passwordTextController.text,
        //                                 );

        //                                 setState(() {
        //                                   _isProcessing = false;
        //                                 });

        //                                 if (user != null) {
        //                                   Navigator.of(context)
        //                                       .pushAndRemoveUntil(
        //                                     MaterialPageRoute(
        //                                       builder: (context) =>
        //                                           HomeScreen(user: user),
        //                                     ),
        //                                     ModalRoute.withName('/'),
        //                                   );
        //                                 }
        //                               } else {
        //                                 setState(() {
        //                                   _isProcessing = false;
        //                                 });
        //                               }
        //                             },
        //                             child: Text(
        //                               'Sign up',
        //                               style: TextStyle(color: Colors.white),
        //                             ),
        //                             style: ButtonStyle(
        //                               backgroundColor:
        //                                   MaterialStateProperty.all(
        //                                       primaryColor),
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     )
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),

        body: Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the left
            children: [
              Text(
                'Sign Up',
                style: primaryTextStyle.copyWith(
                  fontSize: 34,
                  fontWeight: semiBold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                '',
                style: subtitleTextStyle,
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icon_email.png',
                              width: 17,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextFormField(
                                style: primaryTextStyle,
                                controller: _nameTextController,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Your Name',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email Address",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // TextFormField(
                    //   controller: _emailTextController,
                    //   focusNode: _focusEmail,
                    //   validator: (value) => Validator.validateEmail(
                    //     email: value,
                    //   ),
                    //   decoration: InputDecoration(
                    //     icon: Icon(
                    //       Icons.email,
                    //       color: primaryColor,
                    //     ),
                    //     hintText: "Email",
                    //     errorBorder: UnderlineInputBorder(
                    //       borderRadius: BorderRadius.circular(6.0),
                    //       borderSide: BorderSide(
                    //         color: Colors.red,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icon_email.png',
                              width: 17,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextFormField(
                                style: primaryTextStyle,
                                controller: _emailTextController,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Your Email',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 22),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // TextFormField(
                    //   controller: _passwordTextController,
                    //   focusNode: _focusPassword,
                    //   obscureText: true,
                    //   validator: (value) => Validator.validatePassword(
                    //     password: value,
                    //   ),
                    //   decoration: InputDecoration(
                    //     icon: Icon(
                    //       Icons.password_outlined,
                    //       color: primaryColor,
                    //     ),
                    //     hintText: "Password",
                    //     errorBorder: UnderlineInputBorder(
                    //       borderRadius: BorderRadius.circular(6.0),
                    //       borderSide: BorderSide(
                    //         color: Colors.red,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icon_password.png',
                              width: 17,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextFormField(
                                style: primaryTextStyle,
                                controller: _passwordTextController,
                                obscureText: true,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Your Password',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 44.0),
                    // _isProcessing
                    //     ? CircularProgressIndicator()
                    //     : Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //                                       SizedBox(width: 104.0),
                    //           Expanded(
                    //             child: ElevatedButton(
                    //               onPressed: () {
                    //                 Navigator.of(context).push(
                    //                   MaterialPageRoute(
                    //                     builder: (context) => SignUpScreen(),
                    //                   ),
                    //                 );
                    //               },
                    //               child: Text(
                    //                 'SignUp',
                    //                 style: TextStyle(color: Colors.white),
                    //               ),
                    //               style: ButtonStyle(
                    //                 backgroundColor:
                    //                     MaterialStateProperty.all(primaryColor),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 104.0,
                    //           ),
                    //         ],
                    //       )

                    _isProcessing
                        ? CircularProgressIndicator()
                        : Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    if (_registerFormKey.currentState!
                                        .validate()) {
                                      User? user = await FirebaseAuthHelper
                                          .registerUsingEmailPassword(
                                        name: _nameTextController.text,
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => NavPage(),
                                          ),
                                          ModalRoute.withName('/'),
                                        );
                                      }
                                    } else {
                                      setState(() {
                                        _isProcessing = false;
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sudah memiliki akun? Login disini',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0, // Anda bisa menyesuaikan ukuran font
                          // Tambahkan garis bawah jika diinginkan
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
