import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/penyewaan_controller.dart';
import 'form_update_penyewaan_page.dart';

class RentalListPage extends StatelessWidget {
  const RentalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PenyewaanController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Sewa"),
        backgroundColor: const Color.fromARGB(255, 255, 158, 172),
      ),
      body: Obx(
        () => controller.rentalList.isEmpty
            ? const Center(child: Text("Belum ada data"))
            : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: controller.rentalList.length,
                itemBuilder: (context, index) {
                  final data = controller.rentalList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            255,
                            158,
                            172,
                          ).withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.gaun?.nama ?? "Gaun",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 158, 172),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: const Color.fromARGB(255, 255, 158, 172),
                              ),
                              onPressed: () {
                                Get.to(
                                  () => FormUpdatePenyewaanPage(rental: data),
                                );
                              },
                            ),
                          ],
                        ),
                        Text("Penyewa: ${data.namaPenyewa}"),
                        Text(
                          "Periode: ${data.tanggalSewa} s/d ${data.tanggalKembali}",
                        ),
                        Text(
                          "Total: Rp ${data.harga}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: const Color.fromARGB(255, 255, 158, 172),
                            ),
                            onPressed: () => controller.deleteRental(data.id!),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
