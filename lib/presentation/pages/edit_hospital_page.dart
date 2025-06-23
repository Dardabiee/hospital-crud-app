import 'package:crud_hospital_app/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/hospital_model.dart';
import '../../../domain/hospital_provider.dart';

class EditHospitalPage extends StatefulWidget {
  final Hospital hospital;

  const EditHospitalPage({super.key, required this.hospital});

  @override
  State<EditHospitalPage> createState() => _EditHospitalPageState();
}

class _EditHospitalPageState extends State<EditHospitalPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _typeController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.hospital.name);
    _addressController = TextEditingController(text: widget.hospital.address);
    _phoneController = TextEditingController(text: widget.hospital.phone);
    _typeController = TextEditingController(text: widget.hospital.type);
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final updatedHospital = Hospital(
        id: widget.hospital.id,
        name: _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        type: _typeController.text,
      );

      try {
        await Provider.of<HospitalProvider>(context, listen: false)
            .api
            .updateHospital(widget.hospital.id, updatedHospital);

        await Provider.of<HospitalProvider>(context, listen: false)
            .loadHospitals();

        if (context.mounted) Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal update: $e')),
        );
      }

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Rumah Sakit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Nama Rumah Sakit'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Alamat'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'No Telepon'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(border: OutlineInputBorder(),labelText: 'Tipe Rumah Sakit'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DefaultButton(text: 'Simpan Perubahan', press: _submit)
            ],
          ),
        ),
      ),
    );
  }
}
