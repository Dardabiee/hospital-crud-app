import 'package:crud_hospital_app/domain/hospital_provider.dart';
import 'package:crud_hospital_app/presentation/pages/add_hospital_page.dart';
import 'package:crud_hospital_app/presentation/pages/hospital_detail_page.dart';
import 'package:crud_hospital_app/presentation/widgets/default_button.dart';
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
       appBar: AppBar(
        centerTitle: true,
        title: const Text('Daftar Rumah Sakit')),
       body: 
       Column(
         children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultButton(
              text: 'Tambah Rumah Sakit',
              icon: Icons.add, 
              press: () { 
                Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddHospitalPage()),
                );
               },    
            ),
          ),
           Expanded(
             child: provider.isLoading
             ? const Center(child: CircularProgressIndicator(),)
             : ListView.builder(
              itemCount: provider.hospitals.length,
              itemBuilder: (context, index){
                final hospital = provider.hospitals[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (_) => HospitalDetailPage(hospital: hospital)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(hospital.name,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                    ),
                                       Text(hospital.type),
                                  ],
                                ),
                                IconButton(onPressed: () async {
                                   final confirm = await showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Hapus Data'),
                                      content: const Text('Yakin ingin menghapus rumah sakit ini?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          onPressed: () => Navigator.pop(context, true),
                                          child: const Text('Hapus',style: TextStyle(color: Colors.white),),
                                        ),
                                        ],
                                      ),
                                    );
                    
                                      if (confirm == true) {
                                        try {
                                          await Provider.of<HospitalProvider>(context, listen: false)
                                              .api
                                              .deleteHospital(hospital.id);
                    
                                          await Provider.of<HospitalProvider>(context, listen: false)
                                              .loadHospitals();
                    
                                          if (context.mounted) Navigator.pop(context); // Kembali ke list
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Gagal hapus data: $e')),
                                          );
                                        }
                                      }
                                }, icon: Icon(Icons.delete))
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text("Nomor telepon",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            Text(hospital.phone, style: TextStyle(fontSize: 16),),
                            SizedBox(height: 10,),
                            Text("Alamat",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            Text(hospital.address,style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
           ),
         ],
       ),
    );
  }
}
