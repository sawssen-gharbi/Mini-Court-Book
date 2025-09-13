import 'package:flutter/material.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/card_widget.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: 2,
              itemBuilder: (context, index) {
                return CardWidget(
                  facilityImage: "https://picsum.photos/seed/arena/300/200",
                  facilityName: "City Sports Arena",
                  cityName: "Tunis",
                  sports: ["football", "padel"],
                  sportName: "football",
                  courtsNumber: 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
