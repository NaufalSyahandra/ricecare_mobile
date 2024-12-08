import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/utils/show_snackbar.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/profile_avatar_widget.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/profile_form_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Mengisi controller dengan data awal dari AccountBloc
    final state = context.read<AccountBloc>().state;
    if (state is AccountProfileLoad) {
      _nameController.text = state.accountProfile.name;
      _usernameController.text = state.accountProfile.username;
      _emailController.text = state.accountProfile.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85.0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF15B392),
        centerTitle: true,
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountProfileSaved) {
            showSnackbar(context, 'Profile updated successfully!');
            Navigator.pop(context, true);
          } else if (state is AccountFailure) {
            showSnackbar(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileAvatarWidget(),
                const SizedBox(height: 15),
                ProfileFormWidget(
                  nameController: _nameController,
                  emailController: _emailController,
                  usernameController: _usernameController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _usernameController.text.isEmpty ||
                        _emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Harap isi semua kolom")),
                      );
                      return;
                    }
                    context.read<AccountBloc>().add(
                          UpdatingProfile(
                            name: _nameController.text,
                            username: _usernameController.text,
                            email: _emailController.text,
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
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
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
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
