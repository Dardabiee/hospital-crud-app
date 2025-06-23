import 'package:crud_hospital_app/domain/hospital_provider.dart';
import 'package:crud_hospital_app/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/hospital_model.dart';
import '../../../domain/hospital_provider.dart';

class AddHospitalPage extends StatefulWidget {
  const AddHospitalPage({super.key});

  @override
  State<AddHospitalPage> createState() => _AddHospitalPageState();
}

class _AddHospitalPageState extends State<AddHospitalPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _typeController = TextEditingController();

  bool isLoading = false;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final newHospital = Hospital(
        id: 0, // ID akan di-generate oleh DB
        name: _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        type: _typeController.text,
      );

      try {
        await Provider.of<HospitalProvider>(context, listen: false)
            .api
            .addHospital(newHospital);

        await Provider.of<HospitalProvider>(context, listen: false)
            .loadHospitals();

        if (context.mounted) {
          Navigator.pop(context); // Kembali ke list
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal tambah data: $e')),
        );
      }

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Tambah Rumah Sakit", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),),
              SizedBox(height: 25,),
              Text("Nama Rumah Sakit", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),),
              SizedBox(height: 5,),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Masukan Nama Rumah Sakit Disini...",
                 ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 15,),
               Text("Alamat", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),),
              SizedBox(height: 5,),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixText: "",
                  hintText: "Masukan Alamat Rumah Sakit Disini...",
                  ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
                SizedBox(height: 15,),
              Text("No Telepon", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),),
              SizedBox(height: 5,),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixText: "",
                  hintText: "Masukan No Telepon Rumah Sakit Disini...",
                  ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
                SizedBox(height: 15,),
                 Text("Tipe", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w400),),
              SizedBox(height: 5,),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixText: "",
                  hintText: "Masukan Tipe Rumah Sakit Disini...",
                  ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DefaultButton(
                  text: 'Simpan', 
                  press: _submit)
            ],
          ),
        ),
      ),
    );
  }
}
