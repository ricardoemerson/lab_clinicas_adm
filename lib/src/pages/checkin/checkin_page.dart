import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../core/widgets/item_data.dart';
import '../../data/models/patient_information_form_model.dart';
import 'checkin_controller.dart';
import 'widgets/checkin_image_link.dart';
import 'widgets/section_title.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with MessageViewMixin {
  final controller = Injector.get<CheckinController>();

  @override
  void initState() {
    messageListener(controller);

    effect(() {
      if (controller.endProcess()) {
        Navigator.of(context).pushReplacementNamed('/end-checkin');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final PatientInformationFormModel(:password, :patient, :medicalOrders, :healthInsuranceCard) =
        controller.patientInformationForm.watch(context)!;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.only(top: 56),
            width: sizeOf.width * .5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/patient_avatar.png'),
                const SizedBox(height: 16),
                const Text(
                  'A senha chamada foi',
                  style: AppTheme.titleSmallStyle,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 218,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    password,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                const SectionTitle(title: 'Cadastro'),
                const SizedBox(height: 24),
                ItemData(
                  label: 'Nome Paciente',
                  value: patient.name,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'e-Mail',
                  value: patient.email,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'Telefone de contato',
                  value: patient.phoneNumber,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'CPF',
                  value: patient.document,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'CEP',
                  value: patient.address.cep,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'Endereço',
                  value: '${patient.address.streetAddress}, ${patient.address.number}, '
                      '${patient.address.addressComplement}, ${patient.address.district}, '
                      '${patient.address.city} - ${patient.address.state}',
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'Responsável',
                  value: patient.guardian,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                ItemData(
                  label: 'Documento de Identificação',
                  value: patient.guardianIdentificationNumber,
                  padding: const EdgeInsets.only(bottom: 14),
                ),
                const SizedBox(height: 24),
                const SectionTitle(title: 'Validar Imagens Exames'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(label: 'Carteirinha', image: healthInsuranceCard),
                    Column(
                      children: [
                        for (final (index, medicalOrder) in medicalOrders.indexed)
                          CheckinImageLink(label: 'Pedido médico ${index + 1}', image: medicalOrder),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.endCheckin,
                    child: const Text('FINALIZAR ATENDIMENTO'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
