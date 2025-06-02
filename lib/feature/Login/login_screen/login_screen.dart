import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/feature/Login/service/auth_service.dart';
import 'package:redeem/feature/home_page/home_page.dart';
import 'package:redeem/widgets/mytext.dart';
import 'package:redeem/widgets/mytextformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late bool _obsure = true;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final user = await _authService.login(
          contactController.text.trim(),
          passwordController.text.trim(),
        );

        if (!mounted) return;
        Navigator.pop(context);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Welcome ${user.name}')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } catch (e) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text('Login Failed'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              'Welcome To',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Container(
              height: 300.sp,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFormField(
                    textInputType: TextInputType.number,
                    controller: contactController,
                    prefix: const Icon(Icons.phone),
                    hinttext: 'Contact Number',
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contact number is required';
                      }
                      if (value.length != 10 ||
                          !RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit contact number';
                      }
                      return null;
                    },
                  ),
                  MyTextFormField(
                    textInputType: TextInputType.text,
                    controller: passwordController,
                    prefix: const Icon(Icons.password),
                    hinttext: 'Password',
                    textInputAction: TextInputAction.done,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obsure = !_obsure;
                        });
                      },
                      child: Icon(
                        _obsure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    obscureText: _obsure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: 200.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 47, 91, 185),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
            SizedBox(height: 30.h),

            // const Text.rich(
            //   TextSpan(text: "Don't have an account? "),
            //   textAlign: TextAlign.center,
            // ),

            // SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Mytext(
                  text: 'Lele Ventures Pvt. Ltd.',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(width: 10.w),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder:
                //             (_) => const WebViewScreen(
                //               url:
                //                   'https://bihanitech.com/privacy_policy/privacy-policy-for-246-accessories/',
                //               title: 'Privacy Policy',
                //             ),
                //       ),
                //     );
                //   },
                //   child: Mytext(
                //     text: "Privacy Policy",
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.blue,
                //     fontStyle: FontStyle.normal,
                //     textAlign: TextAlign.center,
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 1,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
