import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final controller = Injector.get<HomeController>();

  final _formKey = GlobalKey<FormState>();
  final _deskNumberEC = TextEditingController();

  @override
  void initState() {
    messageListener(controller);

    effect(() {
      if (controller.informationForm != null) {
        Navigator.of(context).pushReplacementNamed('/pre-checkin', arguments: controller.informationForm);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _deskNumberEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Center(
        child: Container(
          width: sizeOf.width * .4,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.orangeColor),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Bem-vindo',
                  style: AppTheme.titleStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Preencha o número do guichê que você está atendendo',
                  style: AppTheme.subTitleStyle,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _deskNumberEC,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Número do guichê de atendimento'),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: Validatorless.multiple([
                    Validatorless.required(AppValidatorMessages.required),
                    Validatorless.number(AppValidatorMessages.number),
                  ]),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final formIsValid = _formKey.currentState?.validate() ?? false;

                      if (formIsValid) {
                        controller.startService(int.parse(_deskNumberEC.trimmedText));
                      }
                    },
                    child: const Text('CHAMAR PRÓXIMO PACIENTE'),
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
