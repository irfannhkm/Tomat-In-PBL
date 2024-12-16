import 'package:flutter/material.dart';

class ReminderSetting extends StatelessWidget {
  const ReminderSetting({super.key});

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      // Handle the selected date
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      // Handle the selected time
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Atur Pengingat', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF121212),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () {
              // Simpan pengingat
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDropdown(
                context,
                label: 'Tanaman',
                items: const ['Tomat 1', 'Tomat 2'],
                onChanged: (value) {
                  // Handle dropdown selection
                },
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                context,
                label: 'Jenis Perawatan',
                items: const ['Watering', 'Fertilizing', 'Pruning'],
                onChanged: (value) {
                  // Handle dropdown selection
                },
              ),
              const SizedBox(height: 20),
              _buildDateTile(
                context,
                label: 'Tanggal mulai',
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 20),
              _buildDateTile(
                context,
                label: 'Tanggal berakhir',
                onTap: () => _selectDate(context, false),
              ),
              // const SizedBox(height: 20),
              // ListTile(
              //   title: const Text('Perulangan', style: TextStyle(color: Colors.white)),
              //   // subtitle: const Text('Pilih opsi', style: TextStyle(color: Colors.white)),
              //   trailing: const Icon(Icons.repeat, color: Colors.white),
              //   onTap: () {
              //     // Handle repeat selection
              //   },
              //   tileColor: const Color(0xFF678983),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              // ),
              const SizedBox(height: 20),
              _buildDropdown(
                context,
                label: 'Perulangan',
                items: const ['1 hari', '2 Hari', '3 Hari'],
                onChanged: (value) {
                  // Handle dropdown selection untuk jenis waktu
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Jam', style: TextStyle(color: Colors.white)),
                // subtitle: const Text('Pilih jam', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.access_time, color: Colors.white),
                onTap: () => _selectTime(context),
                tileColor: const Color(0xFF678983),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white), // Label berwarna putih
        filled: true,
        fillColor: const Color(0xFF678983),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dropdownColor: const Color(0xFF678983),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateTile(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      // subtitle: const Text('Pilih tanggal', style: TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.calendar_today, color: Colors.white),
      tileColor: const Color(0xFF678983),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: onTap,
    );
  }
}
