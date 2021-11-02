import 'package:despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onRemove;
  const TransactionList(
      {Key? key, required this.transaction, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transaction.isEmpty
          ? Column(
              children: [
                const Text('Nenhuma transação cadastrada!'),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                final t = transaction[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(child: Text('R\$${t.value}')),
                      ),
                    ),
                    title: Text(
                      t.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(t.date),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        return onRemove(t.id.toString());
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
