import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:felinefacts/core/network/network_info.dart';
import 'package:felinefacts/data/datasources/cat_trivia_local_datasource.dart';
import 'package:felinefacts/data/datasources/cat_trivia_remote_datasource.dart';
import 'package:felinefacts/data/providers/cat_trivia_provider.dart';
import 'package:felinefacts/domain/repositories/cat_trivia_repository.dart';
import 'package:felinefacts/domain/usecases/get_cat_trivia_list.dart';
import 'package:felinefacts/presentation/bloc/cat_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

void init() {
  serviceLocator
      .registerFactory(() => CatTriviaBloc(listUseCase: serviceLocator()));

  // use cases
  serviceLocator
      .registerLazySingleton(() => GetCatTriviaListUseCase(serviceLocator()));

  // repository
  serviceLocator.registerLazySingleton<BaseCatTriviaRepository>(() => CatTriviaRepository(
      localDatasource: serviceLocator(),
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator()));

  // data sources
  serviceLocator.registerLazySingleton<BaseCatTriviaLocalDatasource>(() => CatTriviaLocalDatasource(provider: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseCatTriviaRemoteDataSource>(() => CatTriviaRemoteDataSource(client: serviceLocator()));

  // external
  serviceLocator.registerLazySingleton<BaseCatTriviaProvider>(() => CatTriviaProvider(databasePath: "cat_trivia.db"));
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerFactory<BaseNetworkInfo>(() => NetworkInfo(connectionChecker: serviceLocator()));
  serviceLocator.registerFactory(() => DataConnectionChecker());
}
