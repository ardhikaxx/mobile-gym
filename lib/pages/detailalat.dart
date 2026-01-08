import 'package:flutter/material.dart';

const Color ungu = Color(0xFF8A00C4);
const Color putih = Colors.white;
const Color abuTeks = Color(0xFF555555);

class DetailAlatPage extends StatelessWidget {
  final String namaAlat;

  const DetailAlatPage({super.key, required this.namaAlat});

  String getDeskripsi(String alat) {
    switch (alat) {
      case "Jump Rope":
        return "Alat cardio untuk meningkatkan stamina dan membakar lemak.";
      case "Treadmill":
        return "Alat lari di tempat untuk latihan cardio.";
      case "Exercise Bike":
        return "Sepeda statis untuk latihan kaki dan jantung.";
      case "Yoga Mat":
        return "Alas latihan untuk kenyamanan saat workout.";
      case "Resistance Band":
        return "Karet elastis untuk latihan kekuatan otot.";
      case "Pull Up Bar":
        return "Alat latihan tubuh bagian atas.";
      case "Dumbbell (Ringan)":
        return "Beban ringan untuk latihan otot.";
      case "Step Board":
        return "Papan step untuk latihan kaki dan cardio.";
      default:
        return "Alat olahraga untuk menunjang latihan.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: putih,
      appBar: AppBar(
        backgroundColor: ungu,
        foregroundColor: putih,
        title: Text(
          namaAlat,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: abuTeks),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.fitness_center,
                size: 80,
                color: ungu,
              ),
              const SizedBox(height: 20),
              Text(
                namaAlat,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      color: ungu,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(getDeskripsi(namaAlat)),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ungu.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  "Catatan:\nFitur upload foto hanya tersedia di versi mobile.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
