import 'package:crud_hospital_app/data/models/hospital_model.dart';
import 'package:crud_hospital_app/domain/hospital_provider.dart';
import 'package:crud_hospital_app/presentation/pages/edit_hospital_page.dart';
import 'package:crud_hospital_app/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalDetailPage extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailPage({super.key,required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hospital.name),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Alamat:', style: Theme.of(context).textTheme.titleMedium),
            Text(hospital.address),
            const SizedBox(height: 16),
            Text('Telepon:', style: Theme.of(context).textTheme.titleMedium),
            Text(hospital.phone),
            const SizedBox(height: 16),
            Text('Tipe:', style: Theme.of(context).textTheme.titleMedium),
            Text(hospital.type),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultButton(
                text: "Edit Data", 
                press: () async{
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditHospitalPage(hospital: hospital),
                 ),
              );
              await Provider.of<HospitalProvider>(context, listen: false).loadHospitals();
            }),
            )
          ],
        ),
        ),
    );
  }
}