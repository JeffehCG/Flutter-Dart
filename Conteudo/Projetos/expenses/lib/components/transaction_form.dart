import 'package:expenses/components/adaptative/adaptative_button.dart';
import 'package:expenses/components/adaptative/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative/adaptative_text_field.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;
  final void Function(Transaction) onUpdate;
  final Transaction _transaction;

  TransactionForm(this.onSubmit, this.onUpdate, [this._transaction]); // Recebe função que ira adicionar a transacao

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); 
  bool _firstAction = false;

  _submitForm(){

    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final date = _selectedDate;

    if(title.isEmpty || value <= 0 || date == null){
      return;
    }

    print('Teste');
    if(widget._transaction == null){
      widget.onSubmit(title, value, date); // Adicionando item na lista
    }
    else{
      widget._transaction.title = title;
      widget._transaction.value = value;
      widget._transaction.date = date;

      widget.onUpdate(widget._transaction);
    }
  }

  _startControllers(){
    if(widget._transaction != null && !_firstAction){
        _titleController.text = widget._transaction.title;
        _valueController.text = widget._transaction.value.toString();
        _selectedDate = widget._transaction.date;
        _firstAction = true;  
    }
  }
  
  // Metodos de Cliclo de vida do componente

  // Antes  dos metodos abaixo, tambem são executado o createState e o contructor
  // Executado apenas uma vez, quando o widget é iniciado
  @override
    void initState() {
      _startControllers();
      super.initState();
    }

  // Executado quando o widget é alterado
  @override
    void didUpdateWidget(covariant TransactionForm oldWidget) {
      super.didUpdateWidget(oldWidget);
    }

  // Executado quando o widget é finalidado
  @override
    void dispose() {
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only( //Componente para dar padding
            top: 10, 
            right: 10, 
            left: 10, 
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom // Pegando o tamnho do teclado
          ), 
          child: Column(
            children: [
              AdaptativeTextField( // Componente criado para adaptar de acordo com a plataform (Ios, Android)
                controller: _titleController,
                label: 'Titulo',
                onSubmit: _submitForm,
                keyBoardType: TextInputType.text,
              ),
              AdaptativeTextField(
                controller: _valueController,
                label: 'Valor R\$',
                onSubmit: _submitForm,
                keyBoardType: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate){
                  setState(() {
                    _selectedDate = newDate;              
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton( // Componente criado para adaptar de acordo com a plataform (Ios, Android)
                    label: 'Nova Transação', onPressed: _submitForm,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
