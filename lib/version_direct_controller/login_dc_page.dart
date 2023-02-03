import 'package:flutter/material.dart';
import 'package:state_manager_poc/login_erros.dart';
import 'package:state_manager_poc/login_states.dart';
import 'package:state_manager_poc/version_direct_controller/login_dc_controller.dart';

class LoginDCPage extends StatelessWidget {
  final LoginDCController controller;
  const LoginDCPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.stateManager.scaffoldKey,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: controller.stateManager.state,
          builder: (context, value, child) {
            if (value is LoginStateSuccess) {
              return Form(
                key: controller.stateManager.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.stateManager.emailTextController,
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
                      controller:
                          controller.stateManager.passwordTextController,
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
                      valueListenable: controller.stateManager.isLoading,
                      builder: (context, value, child) {
                        return value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: controller.login,
                                child: const Text('Login'),
                              );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.stateManager.userIsBlock,
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
