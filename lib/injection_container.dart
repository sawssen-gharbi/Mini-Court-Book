import 'package:get_it/get_it.dart';
import 'package:mini_court_book/features/facilities/data/data_sources/facility_local_data_source.dart';
import 'package:mini_court_book/features/facilities/data/repositories_impl/facility_repository_impl.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/get_facilities.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  //Blocs
  serviceLocator.registerFactory<FacilityBloc>(
    () => FacilityBloc(serviceLocator<FacilityRepository>()),
  );

  //Repositories
  serviceLocator.registerLazySingleton<FacilityRepository>(
    () => FacilityRepositoryImpl(facilityLocalDataSource: serviceLocator()),
  );

  //DataSources

  serviceLocator.registerLazySingleton<FacilityLocalDataSource>(
    () => FacilityLocalDataSourceImpl(),
  );

  //UseCases

  serviceLocator.registerLazySingleton(
    () => GetFacilitiesUseCase(facilityRepository: serviceLocator()),
  );
}
