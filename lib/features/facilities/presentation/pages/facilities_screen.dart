import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/card_widget.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FacilityBloc>().add(LoadFacilities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlocBuilder<FacilityBloc, FacilityState>(
              builder: (BuildContext context, state) {
                if (state is FacilitiesError) {
                  debugPrint(state.message);
                } else {
                  if (state is FacilitiesLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.facilities.length,
                      itemBuilder: (context, index) {
                        final facility = state.facilities[index];

                        return CardWidget(
                          facilityImage: facility.thumbnail,
                          facilityName: facility.name,
                          cityName: facility.city,
                          sports: facility.sports,

                          courtsNumber: facility.courts.length,
                        );
                      },
                    );
                  } else if (state is FacilitiesLoading) {
                    return CircularProgressIndicator(color: Colors.black);
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
