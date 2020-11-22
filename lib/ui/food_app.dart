import 'package:demo7/model/Food.dart';
import 'package:flutter/material.dart';
import 'food_list.dart';

class FoodApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FoodApp();
  }
}

class _FoodApp extends State<FoodApp> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Food _food = Food(name: '', price: 0);
  List<Food> _foods = List<Food>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'This is Demo 7',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(),
        body: SafeArea(
            minimum: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFromField('Name', context),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      buildTextFromField('Price', context),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      buildElevatedButton(context),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    ],
                  )),
            )),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Welcome To Food App',
        style: _titleToolBar,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget buildTextFromField(String valueLabel, BuildContext context) {
    final node = FocusScope.of(context);
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      validator: valueLabel == 'Name' ? validateName : validatePrice,
      style: _textFromField,
      controller: valueLabel == 'Name' ? _nameController : _priceController,
      keyboardType:
          valueLabel == 'Name' ? TextInputType.text : TextInputType.number,
      textInputAction:
          valueLabel == 'Name' ? TextInputAction.next : TextInputAction.go,
      onFieldSubmitted: (_) =>
          valueLabel == 'Name' ? node.nextFocus() : addToList(context),
      decoration: InputDecoration(
          labelText: valueLabel,
          prefixIcon: valueLabel == 'Name'
              ? Icon(Icons.fastfood)
              : Icon(Icons.monetization_on),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      onChanged: (value) {
        setState(() {
          valueLabel == 'Name'
              ? _food.name = value
              : _food.price = double.parse(value) ?? 0;
        });
      },
    );
  }

  Widget buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            onPrimary: Colors.yellow,
          ),
          onPressed: () => addToList(context),
          child: Text(
            'Add',
            style: _textFromField,
          )),
    );
  }

  var _titleToolBar =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  var _textFromField = TextStyle(fontSize: 18, color: Colors.black);

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Name is Required';
    } else {
      return null;
    }
  }

  String validatePrice(String value) {
    if (value.isEmpty) {
      return 'Price is Required';
    } else if (int.parse(value) == 0) {
      return 'Price other than 0';
    } else {
      return null;
    }
  }

  void addToList(BuildContext context) {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        _foods.add(_food);
        _food = Food(name: '', price: 0);
        _nameController.text = '';
        _priceController.text = '';
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Add To Successful'),
        duration: Duration(seconds: 3),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Add Fail'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
