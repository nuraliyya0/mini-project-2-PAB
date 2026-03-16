import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/penyewaan.dart';
import '../models/gaun.dart';

class PenyewaanController extends GetxController {
  final supabase = Supabase.instance.client;
  var gaunList = <Gaun>[].obs;
  var rentalList = <Penyewaan>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchGaun();
    fetchRentals();
    super.onInit();
  }

  Future<void> fetchGaun() async {
    final data = await supabase.from('Gaun').select();
    gaunList.value = (data as List).map((e) => Gaun.fromMap(e)).toList();
  }

  Future<void> fetchRentals() async {
    isLoading(true);
    try {
      final data = await supabase.from('Penyewaan').select('*, Gaun(*)');
      rentalList.value = (data as List)
          .map((e) => Penyewaan.fromMap(e))
          .toList();
    } finally {
      isLoading(false);
    }
  }

  Future<void> addRental(Penyewaan rental) async {
    try {
      await supabase.from('Penyewaan').insert(rental.toMap());
      await fetchRentals();
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Data penyewaan telah disimpan",
        backgroundColor: const Color.fromARGB(255, 255, 158, 172),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: const Color.fromARGB(255, 255, 158, 172),
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateRental(int id, Map<String, dynamic> data) async {
    await supabase.from('Penyewaan').update(data).eq('id', id);

    await fetchRentals();

    Get.back();
  }

  Future<void> deleteRental(int id) async {
    await supabase.from('Penyewaan').delete().eq('id', id);
    fetchRentals();
  }
}
