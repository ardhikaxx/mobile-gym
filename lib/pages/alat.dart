import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detailalat.dart';


class AlatPage extends StatelessWidget {
  const AlatPage({super.key});

  List<Map<String, dynamic>> alatDiet() {
    return [
      {
        "judul": "Cardio & Fat Burn",
        "alat": ["Jump Rope", "Treadmill", "Exercise Bike"],
      },
      {
        "judul": "Bodyweight Training",
        "alat": ["Yoga Mat", "Resistance Band", "Pull Up Bar"],
      },
      {
        "judul": "Lower Body",
        "alat": ["Dumbbell (Ringan)", "Step Board"],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final data = alatDiet();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8A00C4),
        title: Text(
          "Alat Diet",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          final List<String> alatList =
              List<String>.from(item["alat"]); // ✅ FIX dynamic

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7FA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: const Color(0xFF555555)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// JUDUL
                  Text(
                    item["judul"],
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: const Color(0xFF8A00C4),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),

                  /// LIST ALAT (KLIKABLE)
                  ...alatList.map((alat) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailAlatPage(namaAlat: alat),
                          ),
                        );
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.fitness_center,
                              color: Color(0xFF8A00C4),
                            ),
                            SizedBox(width: 12),
                          ],
                        ),
                      ),
                    );
                  }),

                  /// TEKS ALAT (ikut DefaultTextStyle)
                  ...alatList.map(
                    (alat) => Padding(
                      padding:
                          const EdgeInsets.only(left: 36, bottom: 6),
                      child: Text(alat),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
