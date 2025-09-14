import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/pages/facility_details_screen.dart';
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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text(
                            'Filter Options',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        ListTile(
                          leading: const Icon(Icons.location_city),
                          title: const Text('Filter by City'),
                          onTap: () {
                            Navigator.pop(context);
                            final state = context.read<FacilityBloc>().state;

                            if (state is FacilitiesLoaded) {
                              final cities = state.facilities
                                  .map((f) => f.city)
                                  .toSet()
                                  .toList();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return SafeArea(
                                    child: DraggableScrollableSheet(
                                      initialChildSize: 0.6,
                                      minChildSize: 0.3,
                                      maxChildSize: 0.9,
                                      expand: false,
                                      builder: (context, scrollController) {
                                        return Column(
                                          children: [
                                            const ListTile(
                                              title: Text(
                                                'Select City',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                            Expanded(
                                              child: ListView.builder(
                                                controller: scrollController,
                                                itemCount: cities.length,
                                                itemBuilder: (context, index) {
                                                  final city = cities[index];
                                                  return ListTile(
                                                    title: Text(city),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      context
                                                          .read<FacilityBloc>()
                                                          .add(
                                                            FilterFacilities(
                                                              city,
                                                            ),
                                                          );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),

                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.clear),
                          title: const Text('Clear Filter'),
                          onTap: () {
                            Navigator.pop(context);
                            context.read<FacilityBloc>().add(
                              FilterFacilities(""),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacilityDetailsScreen(
                                    facilityId: facility.id,
                                  ),
                                ),
                              );
                            },
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
