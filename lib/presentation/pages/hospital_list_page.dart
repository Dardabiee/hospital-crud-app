import 'package:crud_hospital_app/domain/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalListPage extends StatefulWidget {
  const HospitalListPage({super.key});
  
  @override
  State<HospitalListPage> createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HospitalProvider>(context, listen: false).loadHospitals());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HospitalProvider>(context);
    return Scaffold(
       appBar: AppBar(title: const Text('Daftar Rumah Sakit')),
       body: provider.isLoading
       ? const Center(child: CircularProgressIndicator(),)
       : ListView.builder(
        itemCount: provider.hospitals.length,
        itemBuilder: (context, index){
          final hospital = provider.hospitals[index];
          return Card(
            child: ListTile(
              title: Text(hospital.name),
              subtitle: Text(hospital.address),
              trailing: Text(hospital.type),
              onTap: () {
                // detail
              },
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // nanti ke halaman tambah
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}