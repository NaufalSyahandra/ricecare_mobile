import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ricecare_mobile/features/account/data/datasources/account_remote_datasource.dart';
import 'package:ricecare_mobile/features/account/data/repositories/account_repository_impl.dart';
import 'package:ricecare_mobile/features/account/domain/repositories/account_repository.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/account_logout.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/fetch_profile.dart';
import 'package:ricecare_mobile/features/account/domain/usecases/update_profile.dart';
import 'package:ricecare_mobile/features/account/presentation/bloc/account_bloc.dart';
import 'package:ricecare_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:ricecare_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:ricecare_mobile/features/home/domain/repositories/home_repository.dart';
import 'package:ricecare_mobile/features/home/domain/usecase/get_home_data.dart';
import 'package:ricecare_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ricecare_mobile/core/api/api_client.dart';
import 'package:ricecare_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ricecare_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:ricecare_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:ricecare_mobile/features/auth/domain/usecase/user_signin.dart';
import 'package:ricecare_mobile/features/auth/domain/usecase/user_signup.dart';
import 'package:ricecare_mobile/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Register the HTTP client
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // Register SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(() => prefs);

  // Register the ApiClient
  serviceLocator.registerLazySingleton<ApiClient>(
        () => ApiClient(serviceLocator<http.Client>()),
  );

  _initAuth();
  _initAccount();
  _initHome();
}

void _initAuth() {
  serviceLocator

  // Datasource's
    ..registerFactory<AuthRemoteDatasource>(
            () => AuthRemoteDatasourceImpl(serviceLocator<ApiClient>()))

  // Repositories
    ..registerFactory<AuthRepository>(
            () => AuthRepositoryImpl(serviceLocator()))

  // Use cases
    ..registerFactory<UserSignup>(() =>
        UserSignup(serviceLocator()))

    ..registerFactory<UserSignIn>(() =>
        UserSignIn(serviceLocator()))

  // Bloc
    ..registerFactory<AuthBloc>(() =>
        AuthBloc(
          userSignup: serviceLocator(),
          userSignIn: serviceLocator(),
        ));
}

void _initAccount() {
  serviceLocator
  // Data Source
    ..registerFactory<AccountRemoteDataSources>(
          () => AccountRemoteDataSourcesImpl(serviceLocator<ApiClient>()),
    )
  // Repository
    ..registerFactory<AccountRepository>(
          () => AccountRepositoryImpl(serviceLocator()),
    )
  // UseCase
  //   ..registerFactory<AccountLogout>(
  //           () => AccountLogout(serviceLocator()))

    ..registerFactory<FetchProfile>(
            () => FetchProfile(serviceLocator()))

    ..registerFactory<UpdateProfile>(
            () => UpdateProfile(serviceLocator()))

  // ..registerFactory<UpdatePassword>(
  //         () => UpdatePassword(serviceLocator())
  // )
  // Bloc
    ..registerFactory<AccountBloc>(
          () =>
          AccountBloc(
            fetchProfile: serviceLocator(),
            // accountLogout: serviceLocator(),
            updateProfile: serviceLocator(),
            // updatePassword: serviceLocator()
          ),
    );
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(serviceLocator<ApiClient>()))
    ..registerFactory<HomeRepository>(() => HomeRepositoryImpl(serviceLocator<HomeRemoteDataSource>()))
    ..registerFactory<GetHomeData>(() => GetHomeData(serviceLocator<HomeRepository>()))
    ..registerFactory<HomeBloc>(() => HomeBloc(getHomeData: serviceLocator<GetHomeData>()));
}