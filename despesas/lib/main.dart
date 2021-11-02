import 'dart:math';

import 'package:despesas/components/transaction_form.dart';
import 'package:despesas/components/transaction_list.dart';
import 'package:despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Roboto',
                ))),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transaction = [];
  List<Transaction> get recentTransaction {
    //se a data foi registrada em menos de 7 dias atras, retorna verdadeiro
    //se nao, retorna false
    return transaction.where((t) {
      return t.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despesas Pessoais",
        ),
        actions: [
          IconButton(
              onPressed: () {
                openTRansactionFormModal(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openTRansactionFormModal(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  body() {
    return ListView(
      shrinkWrap: true,
      children: [
        Chart(recentTransaction),
        TransactionList(
          transaction: transaction,
          onRemove: removeTransaction,
        ),
      ],
    );
  }

  addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextInt(60),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      transaction.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  removeTransaction(String id) {
    setState(() {
      transaction.removeWhere((t) {
        return t.id.toString() == id;
      });
    });
  }

  openTRansactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(addTransaction);
        });
  }
}
