import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerInputNumberAccount =
      TextEditingController();
  final TextEditingController _controllerInputValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controllerInputNumberAccount,
            dica: '000',
            rotulo: 'Número da conta',
          ),
          Editor(
            controlador: _controllerInputValue,
            icone: Icons.monetization_on,
            rotulo: 'Valor',
            dica: '0.00',
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () => _criarTransferencia(),
            child: Text('confirmar'),
          ),
        ],
      ),
    );
  }

  void _criarTransferencia() {
    final int accountNumber =
        int.tryParse(_controllerInputNumberAccount.text);
    final double value = double.tryParse(_controllerInputValue.text);

    if (accountNumber != null && value != null) {
      final newTransfer =
          Transferencia(value, accountNumber.toString());
      debugPrint(newTransfer.toString());
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica
        ),
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transference's"),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.0, '0001')),
          ItemTransferencia(Transferencia(250.0, '0002')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.value.toString()),
      subtitle: Text(_transferencia.accountNumber),
    ));
  }
}

class Transferencia {
  final double value;
  final String accountNumber;

  Transferencia(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transferência \n valor: $value, número da conta: $accountNumber}';
  }
}
