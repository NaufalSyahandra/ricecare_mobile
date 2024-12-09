import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/utils/show_snackbar.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/update_password.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPasswordField(
          label: 'Kata Sandi Lama',
          controller: _oldPasswordController,
          isVisible: _isOldPasswordVisible,
          onVisibilityToggle: () {
            setState(() {
              _isOldPasswordVisible = !_isOldPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          label: 'Kata Sandi Baru',
          controller: _newPasswordController,
          isVisible: _isNewPasswordVisible,
          onVisibilityToggle: () {
            setState(() {
              _isNewPasswordVisible = !_isNewPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          label: 'Konfirmasi Kata Sandi Baru',
          controller: _confirmPasswordController,
          isVisible: _isConfirmPasswordVisible,
          onVisibilityToggle: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 30),
        BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state is AccountLoading
                  ? null
                  : () {
                      final oldPassword = _oldPasswordController.text.trim();
                      final newPassword = _newPasswordController.text.trim();
                      final confirmPassword =
                          _confirmPasswordController.text.trim();

                      // Validasi input
                      if (oldPassword.isEmpty ||
                          newPassword.isEmpty ||
                          confirmPassword.isEmpty) {
                        showSnackbar(context, "Semua kolom harus diisi!");
                        return;
                      }

                      if (newPassword != confirmPassword) {
                        showSnackbar(
                            context, 'Konfirmasi password tidak cocok');
                        return;
                      }

                      context.read<AccountBloc>().add(
                            UpdatingPassword(
                              params: PasswordParam(
                                old_password: oldPassword,
                                new_password: newPassword,
                                new_password_confirmation: confirmPassword,
                              ),
                            ),
                          );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF15B392),
                padding: const EdgeInsets.symmetric(
                  horizontal: 85,
                  vertical: 18,
                ),
              ),
              child: state is AccountLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Simpan Perubahan',
                      style: TextStyle(color: Colors.white),
                    ),
            );
          },
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            // Reset form controllers when canceled
            _oldPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();

            context.read<AccountBloc>().add(ResetAccountState());
            Navigator.pop(context);
          },
          child: const Text(
            'Batal',
            style: TextStyle(
              color: Color(0xFF15B392),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: !isVisible,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(color: Color(0xFFB3B3B3)),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onVisibilityToggle,
            ),
          ),
        ),
      ],
    );
  }
}
