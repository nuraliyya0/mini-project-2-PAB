import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/penyewaan_controller.dart';
import 'form_sewa_page.dart';

class GaunPage extends StatelessWidget {
  const GaunPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PenyewaanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Gaun"),
        backgroundColor: const Color.fromARGB(255, 255, 158, 172),
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.gaunList.length,
          itemBuilder: (context, index) {
            final gaun = controller.gaunList[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFE0BFB8).withOpacity(0.4),
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                title: Text(
                  gaun.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text("Ukuran: ${gaun.ukuran}\nRp ${gaun.harga}"),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 158, 172),
                  ),
                  onPressed: () => Get.to(() => FormSewaPage(gaun: gaun)),
                  child: const Text(
                    "Sewa",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
