import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/account_header_widget.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/account_options_widget.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(FetchingProfile());

    return Scaffold(
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountProfileLoad) {
            final profile = state.accountProfile;
            return Column(
              children: [
                AccountHeaderWidget(profile: profile),
                const SizedBox(height: 20),
                const AccountOptionsWidget(),
              ],
            );
          } else if (state is AccountFailure) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No data available.'));
        },
      ),
      bottomNavigationBar: const NavbarWidget(initialIndex: 4),
    );
  }
}
