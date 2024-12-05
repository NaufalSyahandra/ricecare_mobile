import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        GetHomeData(HomeRepositoryImpl(HomeRemoteDataSourceImpl())),
      )..add(LoadHomeData()),
      child: Scaffold(
        appBar: AppBar(title: Text("Selamat datang!")),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Padi telah dideteksi: ${data.detected}"),
                    Text("Padi sehat: ${data.healthy}"),
                    Text("Padi sakit: ${data.infected}"),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text("Selamat datang!"));
          },
        ),
      ),
    );
  }
}
