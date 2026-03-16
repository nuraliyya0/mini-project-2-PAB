import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/penyewaan_controller.dart';
import '../models/penyewaan.dart';

class FormUpdatePenyewaanPage extends StatefulWidget {
  final Penyewaan rental;

  const FormUpdatePenyewaanPage({super.key, required this.rental});

  @override
  State<FormUpdatePenyewaanPage> createState() =>
      _FormUpdatePenyewaanPageState();
}

class _FormUpdatePenyewaanPageState extends State<FormUpdatePenyewaanPage> {
  final nameController = TextEditingController();
  final rentDateController = TextEditingController();
  final returnDateController = TextEditingController();
  final priceController = TextEditingController();

  final controller = Get.find<PenyewaanController>();

  int? selectedGaunId;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.rental.namaPenyewa;
    rentDateController.text = widget.rental.tanggalSewa;
    returnDateController.text = widget.rental.tanggalKembali;
    priceController.text = widget.rental.harga.toString();
    selectedGaunId = widget.rental.idGaun;
  }

  @override
  void dispose() {
    nameController.dispose();
    rentDateController.dispose();
    returnDateController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Penyewaan"),
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
                  if (selectedGaunId == null || nameController.text.isEmpty) {
                    Get.snackbar("Peringatan", "Lengkapi semua data");

                    return;
                  }

                  await controller.updateRental(widget.rental.id!, {
                    'nama_penyewa': nameController.text,
                    'tanggal_sewa': rentDateController.text,
                    'tanggal_kembali': returnDateController.text,
                    'harga': int.parse(priceController.text),
                    'id_gaun': selectedGaunId,
                  });
                },

                child: const Text(
                  "Update Penyewaan",
                  style: TextStyle(color: Colors.black),
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
