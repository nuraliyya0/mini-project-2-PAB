import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/penyewaan_controller.dart';
import '../models/gaun.dart';
import '../models/penyewaan.dart';

class FormSewaPage extends StatefulWidget {
  final Gaun? gaun;
  final Penyewaan? existingRental;

  const FormSewaPage({super.key, this.gaun, this.existingRental});

  @override
  State<FormSewaPage> createState() => _FormSewaPageState();
}

class _FormSewaPageState extends State<FormSewaPage> {
  final nameController = TextEditingController();
  final rentDateController = TextEditingController();
  final returnDateController = TextEditingController();
  final priceController = TextEditingController();

  final controller = Get.find<PenyewaanController>();

  int? selectedGaunId;

  @override
  void initState() {
    super.initState();

    if (widget.existingRental != null) {
      final data = widget.existingRental!;

      nameController.text = data.namaPenyewa;
      rentDateController.text = data.tanggalSewa;
      returnDateController.text = data.tanggalKembali;
      priceController.text = data.harga.toString();

      selectedGaunId = data.idGaun;
    } else if (widget.gaun != null) {
      selectedGaunId = widget.gaun!.idGaun;
      priceController.text = widget.gaun!.harga.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.existingRental != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Update Penyewaan" : "Form Penyewaan"),
        backgroundColor: const Color.fromARGB(255, 255, 158, 172),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: selectedGaunId,
              decoration: InputDecoration(
                labelText: "Pilih Gaun",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              items: controller.gaunList.map((gaun) {
                return DropdownMenuItem(
                  value: gaun.idGaun,
                  child: Text(gaun.nama),
                );
              }).toList(),

              onChanged: (val) {
                setState(() {
                  selectedGaunId = val;

                  final selected = controller.gaunList.firstWhere(
                    (g) => g.idGaun == val,
                  );

                  priceController.text = selected.harga.toString();
                });
              },
            ),

            const SizedBox(height: 15),

            _buildTextField(nameController, "Nama Penyewa", Icons.person),

            const SizedBox(height: 15),

            _buildTextField(
              rentDateController,
              "Tanggal Sewa (YYYY-MM-DD)",
              Icons.calendar_today,
            ),

            const SizedBox(height: 15),

            _buildTextField(
              returnDateController,
              "Tanggal Kembali (YYYY-MM-DD)",
              Icons.event,
            ),

            const SizedBox(height: 15),

            _buildTextField(
              priceController,
              "Harga",
              Icons.money,
              readOnly: true,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 158, 172),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),

                onPressed: () async {
                  if (selectedGaunId == null ||
                      nameController.text.isEmpty ||
                      rentDateController.text.isEmpty ||
                      returnDateController.text.isEmpty) {
                    Get.snackbar("Peringatan", "Lengkapi semua data");

                    return;
                  }

                  if (isEdit) {
                    await controller.updateRental(widget.existingRental!.id!, {
                      'nama_penyewa': nameController.text,
                      'tanggal_sewa': rentDateController.text,
                      'tanggal_kembali': returnDateController.text,
                      'harga': int.parse(priceController.text),
                      'id_gaun': selectedGaunId,
                    });
                  } else {
                    await controller.addRental(
                      Penyewaan(
                        namaPenyewa: nameController.text,
                        tanggalSewa: rentDateController.text,
                        tanggalKembali: returnDateController.text,
                        harga: int.parse(priceController.text),
                        idGaun: selectedGaunId!,
                      ),
                    );
                  }
                },

                child: Text(
                  isEdit ? "Update Penyewaan" : "Simpan Penyewaan",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    bool readOnly = false,
  }) {
    return TextField(
      controller: ctrl,
      readOnly: readOnly,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
