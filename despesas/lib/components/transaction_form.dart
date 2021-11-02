import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransactionForm extends StatefulWidget {
  late void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Titulo'),
        ),
        TextField(
          controller: valueController,
          onSubmitted: (value) => onSubmitForm(),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Valor (R\$)'),
        ),
        Row(
          children: [
            // ignore: unnecessary_null_comparison
            Expanded(
              child: Text(selectDate == null
                  ? 'Nenhuma data selecionada!'
                  : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectDate)}'),
            ),
            TextButton(
                onPressed: _showDatePicker,
                child: const Text("Selecionar data"))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onSubmitForm,
              child: const Text(
                "Nova transação",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ],
    );
  }

  onSubmitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    // ignore: unnecessary_null_comparison
    if (title.isEmpty || value <= 0 || selectDate == null) {
      return;
    }
    widget.onSubmit(title, value, selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectDate = pickedDate;
      });
      selectDate = pickedDate;
    });
  }
}
