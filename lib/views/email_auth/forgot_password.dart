import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'sign_in_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.primaryColorDark),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(
                height: 80,
                child: Image.asset('assets/images/app_logo.png'),
              ),

              const SizedBox(height: 32),

              Text(
                'Enter your email to receive a password reset link',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Colors.grey.shade600),
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => _authController
                    .resetPassword(_emailController.text.trim()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color((0xFF00A9C7)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Send Reset Link',
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Get.off(() => SignInPage()),
                child: Text(
                  'Back to Sign In',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.primaryColorDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
