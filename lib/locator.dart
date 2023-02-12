import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/data/remote/geocoding.dart';
import 'package:cab_rider/repository/main_screen_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

setUp() {
  //call remote api
  getIt.registerSingleton<GoogleGeoCoding>(GoogleGeoCoding());

  //repository
  getIt.registerSingleton<MainScreenRepository>(MainScreenRepository(getIt()));

  //bloc
  getIt.registerSingleton<MainScreenBloc>(MainScreenBloc(getIt()));
}
