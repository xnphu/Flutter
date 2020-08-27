import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_status.dart';
import 'data/datasource/api/authen_api_impl.dart';
import 'data/datasource/api/interface_api.dart';
import 'data/datasource/authen_cache.dart';
import 'data/repository/authen_repository_impl.dart';
import 'data/repository/room_repository_impl.dart';
import 'domain/repository/authen_repository.dart';
import 'domain/repository/room_repository.dart';
import 'domain/usecases/authentication_usecases.dart';

import 'presentation/scenes/change_room/index.dart';
import 'presentation/scenes/detail_room/index.dart';
import 'presentation/scenes/home/index.dart';
import 'presentation/scenes/login/index.dart';

GetIt injector = GetIt.asNewInstance();

initInjector() {
  //API
  injector.registerFactory<AuthenApi>(() => AuthenApiImpl());

  //Storage
  injector.registerLazySingleton<AuthenCache>(() => AuthenCacheImpl());

  //Usecases
  injector.registerFactory<AuthenticationUseCases>(
      () => AuthenticationUseCaseImpl(injector()));

  //Repositories
  injector.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(injector(), injector()));
  injector.registerFactory<RoomRepository>(
      () => RoomRepositoryImpl().getInstance());

  //Blocs
  injector.registerFactory<LoginBloc>(() => LoginBloc(
        injector(),
      ));
  injector.registerFactory<HomeBloc>(() => HomeBloc(injector()));
  injector.registerFactory<DetailRoomBloc>(() => DetailRoomBloc(injector()));
  injector.registerFactory<ChangeRoomBloc>(() => ChangeRoomBloc(injector()));
  //Routers
  injector.registerFactory<LoginRouter>(() => LoginRouter());
  injector.registerFactory<HomeRouter>(() => HomeRouter());
  injector.registerFactory<DetailRoomRouter>(() => DetailRoomRouter());
  injector.registerFactory<ChangeRoomRouter>(() => ChangeRoomRouter());

  //Utils
  injector.registerLazySingleton(() => DataConnectionChecker());
  injector.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImpl(injector()));
}
