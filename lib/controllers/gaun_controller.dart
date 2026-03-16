import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/gaun.dart';

class GaunController extends GetxController {
  var gaunList = <Gaun>[].obs;
  var isLoading = true.obs;
  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    fetchGaun();
    super.onInit();
  }

  Future<void> fetchGaun() async {
    try {
      isLoading(true);

      final response = await supabase.from('Gaun').select();
      gaunList.value = response.map((e) => Gaun.fromMap(e)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data gaun: $e');
    } finally {
      isLoading(false);
    }
  }
}
