import 'package:flutter/material.dart';

void main() {
  runApp(WildCareApp());
}

class WildCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wild Care',
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      print('${_isLogin ? "Logging in" : "Signing up"}...');
      // Perform auth logic here
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/photo.png', // Your logo here
                height: 120,
              ),
              const SizedBox(height: 20),
              Text(
                _isLogin ? 'Login' : 'Sign Up',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 162, 222),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: _validatePassword,
                    ),
                    if (!_isLogin)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: _confirmController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: _validateConfirmPassword,
                        ),
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 162, 222),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        _isLogin ? 'Login' : 'Sign Up',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: _toggleMode,
                      child: Text(
                        _isLogin
                            ? "Don't have an account? Sign up"
                            : "Already have an account? Login",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
