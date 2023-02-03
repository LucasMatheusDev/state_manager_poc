import 'package:flutter/material.dart';
import 'package:state_manager_poc/login_erros.dart';
import 'package:state_manager_poc/login_state_manager%20copy.dart';
import 'package:state_manager_poc/login_states.dart';

class LoginPage extends StatelessWidget {
  final LoginStateManager stateManager;
  const LoginPage({super.key, required this.stateManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: stateManager.scaffoldKey,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: stateManager.state,
          builder: (context, value, child) {
            if (value is LoginStateSuccess) {
              return Form(
                key: stateManager.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: stateManager.emailTextController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: stateManager.passwordTextController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: stateManager.isLoading,
                      builder: (context, value, child) {
                        return value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: stateManager.login,
                                child: const Text('Login'),
                              );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: stateManager.userIsBlock,
                      builder: (context, value, child) {
                        return value
                            ? const Text('User is blocked')
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
            } else if (value is LoginStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value is LoginStateFailure &&
                value.error is LoginErrorUserBlocked) {
              return const Center(
                child: Text('User is blocked not allowed to login'),
              );
            } else {
              return const Center(
                child: Text('Unexpected error'),
              );
            }
          },
        ),
      ),
    );
  }
}
