// import 'package:flutter/material.dart';
// import 'package:pa3/constant.dart';
// import 'package:pa3/models/api_response.dart';
// import 'package:pa3/models/user.dart';
// import 'package:pa3/pages/home_page.dart';
// import 'package:pa3/service/user_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   TextEditingController nameController = TextEditingController(),
//       emailController = TextEditingController(),
//       passwordController = TextEditingController(),
//       confirmPasswordController = TextEditingController();

// // Register User
//   void _registerUser() async {
//     ApiResponse response = await register(
//       nameController.text,
//       emailController.text,
//       passwordController.text,
//     );
//     if (response.error == null) {
//       _saveAndRedirectToHome(response.data as User);
//     } else {
//       setState(() {
//         _isLoading = !_isLoading;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('${response.error!}')));
//     }
//   }

// // Save and Redirect To Home
//   void _saveAndRedirectToHome(User user) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.setString('token', user.token ?? '');
//     await pref.setInt('userId', user.id ?? 0);
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: formkey,
//         child: ListView(
//           padding: EdgeInsets.all(32),
//           children: [
//             TextFormField(
//               controller: nameController,
//               validator: (val) => val!.isEmpty ? 'Invalid name' : null,
//               decoration: kinputDecoration('Name'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               controller: emailController,
//               validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
//               decoration: kinputDecoration('Email'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: passwordController,
//               obscureText: true,
//               validator: (val) =>
//                   val!.length < 6 ? 'Required at least 6 chars' : null,
//               decoration: kinputDecoration('Password'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: confirmPasswordController,
//               obscureText: true,
//               validator: (val) => val != passwordController.text
//                   ? 'Confirm password does not match'
//                   : null,
//               decoration: kinputDecoration('Password'),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             _isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : kTextButton(
//                     'Register',
//                     () {
//                       if (formkey.currentState!.validate()) {
//                         setState(() {
//                           _isLoading = !_isLoading;
//                           _registerUser();
//                         });
//                       }
//                     },
//                   ),
//             SizedBox(
//               height: 10,
//             ),
//             kLoginRegisterHint('Dont have an acount?', 'Register', () {
//               Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => Register()),
//                   (route) => false);
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:pa3/constant.dart';
// import 'package:pa3/models/api_response.dart';
// import 'package:pa3/models/user.dart';
// import 'package:pa3/pages/authentication/login.dart';
// import 'package:pa3/pages/home_page.dart';
// import 'package:pa3/service/user_service.dart';
// import 'package:pa3/theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   TextEditingController nameController = TextEditingController(),
//       emailController = TextEditingController(),
//       passwordController = TextEditingController(),
//       confirmPasswordController = TextEditingController();

//   final _focusName = FocusNode();
//   final _focusEmail = FocusNode();
//   final _focusPassword = FocusNode();
//   final _focusConfirmPassword = FocusNode();

// // Register User
//   void _registerUser() async {
//     ApiResponse response = await register(
//       nameController.text,
//       emailController.text,
//       passwordController.text,
//     );
//     if (response.error == null) {
//       _saveAndRedirectToHome(response.data as User);
//     } else {
//       setState(() {
//         _isLoading = !_isLoading;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('${response.error!}')));
//     }
//   }

// // Save and Redirect To Home
//   void _saveAndRedirectToHome(User user) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     await pref.setString('token', user.token ?? '');
//     await pref.setInt('userId', user.id ?? 0);
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _focusName.unfocus();
//         _focusEmail.unfocus();
//         _focusPassword.unfocus();
//         _focusConfirmPassword.unfocus();
//       },
//       child: Scaffold(
//         body: Container(
//           margin: EdgeInsets.only(top: 50, left: 10, right: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Sign Up',
//                 style: primaryTextStyle.copyWith(
//                   fontSize: 34,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Text(
//                 '',
//                 style: subtitleTextStyle,
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               Form(
//                 key: formkey,
//                 child: Column(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Name",
//                         style: primaryTextStyle.copyWith(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: buttonColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/icon_email.png',
//                               width: 17,
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 style: primaryTextStyle,
//                                 controller: nameController,
//                                 focusNode: _focusName,
//                                 validator: (val) =>
//                                     val!.isEmpty ? 'Invalid name' : null,
//                                 decoration: InputDecoration.collapsed(
//                                   hintText: 'Your Name',
//                                   hintStyle: subtitleTextStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 22),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Email Address",
//                         style: primaryTextStyle.copyWith(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: buttonColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/icon_email.png',
//                               width: 17,
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 style: primaryTextStyle,
//                                 controller: emailController,
//                                 focusNode: _focusEmail,
//                                 validator: (val) => val!.isEmpty
//                                     ? 'Invalid email address'
//                                     : null,
//                                 decoration: InputDecoration.collapsed(
//                                   hintText: 'Your Email',
//                                   hintStyle: subtitleTextStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 22),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Password",
//                         style: primaryTextStyle.copyWith(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: buttonColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/icon_password.png',
//                               width: 17,
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 style: primaryTextStyle,
//                                 controller: passwordController,
//                                 focusNode: _focusPassword,
//                                 obscureText: true,
//                                 validator: (val) => val!.length < 6
//                                     ? 'Required at least 6 chars'
//                                     : null,
//                                 decoration: InputDecoration.collapsed(
//                                   hintText: 'Your Password',
//                                   hintStyle: subtitleTextStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 22),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Confirm Password",
//                         style: primaryTextStyle.copyWith(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: buttonColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/icon_password.png',
//                               width: 17,
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 style: primaryTextStyle,
//                                 controller: confirmPasswordController,
//                                 focusNode: _focusConfirmPassword,
//                                 obscureText: true,
//                                 validator: (val) => val!.length < 6
//                                     ? 'Password not Same'
//                                     : null,
//                                 decoration: InputDecoration.collapsed(
//                                   hintText: 'Confirm Password',
//                                   hintStyle: subtitleTextStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 44.0),
//                     _isLoading
//                         ? CircularProgressIndicator()
//                         : Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     if (formkey.currentState!.validate()) {
//                                       setState(() {
//                                         _isLoading = !_isLoading;
//                                         _registerUser();
//                                       });
//                                     }
//                                   },
//                                   child: Text(
//                                     'Sign up',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   style: ButtonStyle(
//                                     backgroundColor: MaterialStateProperty.all(
//                                       Colors.green,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => Login(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Sudah memiliki akun? Login disini',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pa3/constant.dart';
import 'package:pa3/models/api_response.dart';
import 'package:pa3/models/user.dart';
import 'package:pa3/pages/authentication/login.dart';
import 'package:pa3/pages/home_page.dart';
import 'package:pa3/service/user_service.dart';
import 'package:pa3/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController();

  final FocusNode focusName = FocusNode();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusConfirmPassword = FocusNode();

  // Register User
  void _registerUser() async {
    ApiResponse response = await register(
      nameController.text,
      emailController.text,
      passwordController.text,
    );
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error!}')));
    }
  }

  // Save and Redirect To Home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusName.unfocus();
        focusEmail.unfocus();
        focusPassword.unfocus();
        focusConfirmPassword.unfocus();
      },
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: primaryTextStyle.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
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
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                                controller: nameController,
                                focusNode: focusName,
                                validator: (val) =>
                                    val!.isEmpty ? 'Invalid name' : null,
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
                          fontWeight: FontWeight.w500,
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
                                controller: emailController,
                                focusNode: focusEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) => val!.isEmpty
                                    ? 'Invalid email address'
                                    : null,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
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
                              'assets/icon_password.png',
                              width: 17,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextFormField(
                                style: primaryTextStyle,
                                controller: passwordController,
                                focusNode: focusPassword,
                                obscureText: true,
                                validator: (val) => val!.length < 6
                                    ? 'Required at least 6 chars'
                                    : null,
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
                    SizedBox(height: 22),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
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
                              'assets/icon_password.png',
                              width: 17,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: TextFormField(
                                style: primaryTextStyle,
                                controller: confirmPasswordController,
                                focusNode: focusConfirmPassword,
                                obscureText: true,
                                validator: (val) =>
                                    val != passwordController.text
                                        ? 'Password not same'
                                        : null,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Confirm Password',
                                  hintStyle: subtitleTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 44.0),
                    isLoading
                        ? CircularProgressIndicator()
                        : Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      _registerUser();
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Sudah memiliki akun? Login disini',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
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
