import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int _selectedRoleIndex = 1;
  final List<String> _roles = ['Student', 'Teacher', 'Admin'];

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  bool _isPasswordStrong(String password) {
    final hasDigits = password.contains(RegExp(r'\d'));
    final hasLetters = password.contains(RegExp(r'[a-zA-Z]'));
    return password.length >= 8 && hasDigits && hasLetters;
  }

  void _handleRegister(BuildContext context) {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final role = _selectedRoleIndex;

    if (!_isPasswordStrong(password)) {
      _showErrorSnackBar(context,
          'Password must be at least 8 characters long and contain both letters and numbers.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorSnackBar(context, 'Passwords do not match!');
      return;
    }

    context.read<AuthenticationBloc>().add(
          RegisterEvent(
            request: RegisterRequest(
              name: name,
              phone: phone,
              password: password,
              passwordConfirmation: confirmPassword,
              roleId: role,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.pop(context);
        } else if (state.status == AuthenticationStatus.unauthenticated) {
          _showErrorSnackBar(context, 'Registration failed. Please try again.');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                value: _selectedRoleIndex,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (var index = 0; index < _roles.length; index++)
                    DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(_roles[index]),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRoleIndex = value!;
                  });
                },
              ),
              const SizedBox(height: 32.0),
              FilledButton(
                onPressed: () => _handleRegister(context),
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
