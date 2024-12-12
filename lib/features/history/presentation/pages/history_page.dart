import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/history/presentation/bloc/history_bloc.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/history_app_bar_widget.dart';
import 'package:ricecare_mobile/features/history/presentation/widget/history_list_widget.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HistoryAppBar(),
      body: BlocProvider(
        create: (_) => GetIt.instance<HistoryBloc>()..add(LoadHistoryEvent()),
        child: const Column(
          children: [
            Gap(20),
            Expanded(child: HistoryList()),
          ],
        ),
      ),
      bottomNavigationBar: const NavbarWidget(initialIndex: 1),
    );
  }
}
