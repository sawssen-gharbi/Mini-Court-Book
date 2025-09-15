import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/core/theme/theme.dart';
import 'package:mini_court_book/features/facilities/presentation/pages/facility_details_screen.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/card_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/empty_state_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/search_filter_widget.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  //var
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  //func
  @override
  void initState() {
    super.initState();
    context.read<FacilityBloc>().add(LoadFacilities());
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Mini Court Book")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchFilterWidget(
            focusNode: _searchFocusNode,
            controller: _searchController,
            onChanged: (value) {
              context.read<FacilityBloc>().add(SearchFacilities(value));
            },
            onPressed: () {
              _searchFocusNode.unfocus();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            'Filter Options',
                            style: AppTheme.theme.textTheme.bodyLarge,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        ListTile(
                          leading: const Icon(Icons.location_city),
                          title: Text(
                            'Filter by City',
                            style: AppTheme.theme.textTheme.titleMedium,
                          ),
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
                                            ListTile(
                                              title: Text(
                                                'Select City',
                                                style: AppTheme
                                                    .theme
                                                    .textTheme
                                                    .titleMedium,
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
                                                    title: Text(
                                                      city,
                                                      style: AppTheme
                                                          .theme
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
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
                          leading: const Icon(
                            Icons.settings_backup_restore_outlined,
                          ),
                          title: Text(
                            'Clear Filter',
                            style: AppTheme.theme.textTheme.titleMedium,
                          ),
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
                    if (state.filteredFacilities.isEmpty) {
                      return EmptyStateWidget(
                        icon: Icons.search_off,
                        title: 'No facilities found',
                        subtitle: 'Try adjusting your search or filters',
                      );
                    }
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
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacilityDetailsScreen(
                                    facilityId: facility.id,
                                    facilityName: facility.name,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
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
