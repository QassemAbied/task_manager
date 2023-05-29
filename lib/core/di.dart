import 'package:firebase_app/data/data_sourece/remote_data_source.dart';
import 'package:firebase_app/data/data_sourece/remote_data_source_impl.dart';
import 'package:firebase_app/data/repository_impl/base_repository_impl.dart';
import 'package:firebase_app/domain/use_case/add_task_use_case.dart';
import 'package:firebase_app/domain/use_case/login_use_case.dart';
import 'package:firebase_app/domain/use_case/register_use_case.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_bloc.dart';
import 'package:get_it/get_it.dart';

import '../domain/repository/base_repository.dart';
import '../domain/use_case/get_user_use_case.dart';
import '../domain/use_case/set_user_use_case.dart';

final Sl = GetIt.instance;

class ServiceLocator {
  void init() {
    Sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
    Sl.registerLazySingleton<BaseRepository>(() => BaseRepositoryImpl(Sl()));
    Sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(Sl()));
    Sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(Sl()));
    Sl.registerLazySingleton<SetUserDataUseCase>(() => SetUserDataUseCase(Sl()));
    Sl.registerLazySingleton<getUserDataUseCase>(
            () => getUserDataUseCase(Sl()));
    Sl.registerLazySingleton<SetAddTaskUserUseCase>(
            () => SetAddTaskUserUseCase(Sl()));
    // Sl.registerLazySingleton<getTopRatedUseCase>(
    //         () => getTopRatedUseCase(Sl()));
    // Sl.registerLazySingleton<getUpComingUseCase>(
    //         () => getUpComingUseCase(Sl()));
    // Sl.registerLazySingleton<getTrendUseCase>(() => getTrendUseCase(Sl()));
    // Sl.registerLazySingleton<getDetailsMovieUseCase>(
    //         () => getDetailsMovieUseCase(Sl()));
    // Sl.registerLazySingleton<getVideoMovieUseCase>(
    //         () => getVideoMovieUseCase(Sl()));
    // Sl.registerLazySingleton<getImageMovieUseCase>(
    //         () => getImageMovieUseCase(Sl()));
    // Sl.registerLazySingleton<getCastMovieUseCase>(
    //         () => getCastMovieUseCase(Sl()));
    // Sl.registerLazySingleton<getSimilarMovieUseCase>(
    //         () => getSimilarMovieUseCase(Sl()));
    // Sl.registerLazySingleton<getSearchMovieUseCase>(
    //         () => getSearchMovieUseCase(Sl()));
    // Sl.registerLazySingleton<getCheckAccountStatesUseCase>(
    //         () => getCheckAccountStatesUseCase(Sl()));
    // Sl.registerLazySingleton<WatchListRepository>(
    //         () => WatchListRepositoryImpl(Sl()));
    // Sl.registerLazySingleton<WatchlistLocalDataSource>(
    //         () => WatchlistLocalDataSourceImpl());
    // Sl.registerLazySingleton<getWatchListUseCase>(
    //         () => getWatchListUseCase(Sl()));
    // Sl.registerLazySingleton<getAddWatchListUseCase>(
    //         () => getAddWatchListUseCase(Sl()));
    // Sl.registerLazySingleton<getRemoveWatchListUseCase>(
    //         () => getRemoveWatchListUseCase(Sl()));
    //
    //
    // Sl.registerLazySingleton<FavoriteRepository>(
    //         () => FavoriteRepositoryImpl(Sl()));
    // Sl.registerLazySingleton<FavoriteRemoteDataSource>(
    //         () => FavoriteRemoteDataSourceImpl());
    // Sl.registerLazySingleton<FavoriteUseCase>(() => FavoriteUseCase(Sl()));
    // Sl.registerLazySingleton<getAddFavoriteUseCase>(
    //         () => getAddFavoriteUseCase(Sl()));
    // Sl.registerLazySingleton<getRemoveFavoriteUseCase>(
    //         () => getRemoveFavoriteUseCase(Sl()));
    //
    // Sl.registerLazySingleton<AuthenticationRepository>(
    //         () => AuthenticationRepositoryImpl(Sl()));
    // Sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    //         () => AuthenticationRemoteDataSourceImpl());
    // Sl.registerLazySingleton<RequestTokenUseCase>(
    //         () => RequestTokenUseCase(Sl()));
    // Sl.registerLazySingleton<getLoginValidateUseCase>(
    //         () => getLoginValidateUseCase(Sl()));
    // Sl.registerLazySingleton<getCreateSessionUseCase>(
    //         () => getCreateSessionUseCase(Sl()));
    //
    // Sl.registerFactory(() => MovieBloc(Sl(), Sl(), Sl(), Sl(), Sl(), Sl()));
    // Sl.registerFactory(
    //         () => MovieDetailsBloc(Sl(), Sl(), Sl(), Sl(), Sl(), Sl()));
    //
    //
    // Sl.registerFactory(() => ChangeBottomCubit());
     Sl.registerFactory(() => LoginBloc(Sl() ,Sl(),Sl() ,Sl(),Sl()));
    // Sl.registerFactory(() => WatchlistBloc(Sl(), Sl(), Sl()));
    // Sl.registerFactory(() => FavoritesBloc(Sl(), Sl(), Sl()));
    // Sl.registerFactory(() => AuthenticationBloc(Sl(), Sl(), Sl()));
  }
}
