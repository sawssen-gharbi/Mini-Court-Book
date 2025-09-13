import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/card_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/search_filter_widget.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  //var
  final TextEditingController _searchController = TextEditingController();

  //func
  @override
  void initState() {
    super.initState();
    context.read<FacilityBloc>().add(LoadFacilities());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchFilterWidget(
            controller: _searchController,
            onChanged: (value) {
              context.read<FacilityBloc>().add(SearchFacilities(value));
            },
          ),
          Expanded(
            child: BlocBuilder<FacilityBloc, FacilityState>(
              builder: (BuildContext context, state) {
                if (state is FacilitiesError) {
                } else {
                  if (state is FacilitiesLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<FacilityBloc>().add(LoadFacilities());
                        _searchController.clear();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.filteredFacilities.length,
                        itemBuilder: (context, index) {
                          final facility = state.filteredFacilities[index];
                          return CardWidget(
                            facilityImage: facility.thumbnail,
                            facilityName: facility.name,
                            cityName: facility.city,
                            sports: facility.sports,
                            courtsNumber: facility.courts.length,
                          );
                        },
                      ),
                    );
                  } else if (state is FacilitiesLoading) {
                    return CircularProgressIndicator(color: Colors.black);
                  } else if (state is FacilitiesEmpty) {
                    return Text("No data");
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
