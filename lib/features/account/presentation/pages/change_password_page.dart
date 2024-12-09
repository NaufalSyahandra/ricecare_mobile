import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/utils/show_snackbar.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/change_password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pastikan untuk memanggil event FetchingProfile saat halaman muncul
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(FetchingProfile());
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85.0,
        title: const Text(
          "Ganti Kata Sandi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF15B392),
        centerTitle: true,
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is PasswordUpdated) {
            showSnackbar(context, 'Password berhasil diperbarui');
            Navigator.pop(context);
          } else if (state is AccountFailure) {
            showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Padding(
            padding: EdgeInsets.all(40.0),
            child: ChangePasswordForm(),
          );
        },
      ),
    );
  }
}
