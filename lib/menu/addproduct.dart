import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final String FontPoppins = 'FontPoppins';
  final _formKey = GlobalKey<FormState>();
  String _selectedFactory = "Mandalasari";
  var factory = {'Mandalasari': 'ML', 'BunihKasih': 'BK'};

  List _factory = [];
  FactoryDependentDropDown() {
    factory.forEach((key, value) {
      _factory.add(key);
    });
  }

  String _selectedType = "Kilogram";
  var type = {'Kilogram': 'KG', 'Gram': 'G'};

  List _types = [];
  TypeDependentDropDown() {
    type.forEach((key, value) {
      _types.add(key);
    });
  }

  String _selectedProduct = "Production";
  var product = {'Production': 'P', 'Temporary(S)': 'TP'};

  List _products = [];
  ProductDependentDropDown() {
    product.forEach((key, value) {
      _products.add(key);
    });
  }

  @override
  void initState() {
    super.initState();
    FactoryDependentDropDown();
    TypeDependentDropDown();
    ProductDependentDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FB),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(FontAwesomeIcons.angleLeft),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add Production",
          style: GoogleFonts.sourceSansPro(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 80),
              height: 450,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color(0xFFFFFFFF)),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 25, left: 20),
                          child: SizedBox(
                            height: 25,
                            child: Text(
                              "Factory Name",
                              style: TextStyle(
                                fontFamily: FontPoppins,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        DropdownButton(
                          hint: Text("Select"),
                          padding: EdgeInsets.only(left: 20),
                          borderRadius: BorderRadius.circular(10),
                          value: _selectedFactory,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedFactory = "$newValue";
                            });
                          },
                          items: _factory.map((factory) {
                            return DropdownMenuItem(
                              child: Text(factory),
                              value: factory,
                            );
                          }).toList(),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 25),
                          child: SizedBox(
                            height: 25,
                            child: Text(
                              "Type Weight",
                              style: TextStyle(
                                fontFamily: FontPoppins,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        DropdownButton(
                          padding: EdgeInsets.only(left: 20),
                          borderRadius: BorderRadius.circular(10),
                          value: _selectedType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedType = "$newValue";
                            });
                          },
                          items: _types.map((type) {
                            return DropdownMenuItem(
                              child: Text(type),
                              value: type,
                            );
                          }).toList(),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 25),
                          child: SizedBox(
                            height: 25,
                            child: Text(
                              "Production Type",
                              style: TextStyle(
                                fontFamily: FontPoppins,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        DropdownButton(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          value: _selectedProduct,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedProduct = "$newValue";
                            });
                          },
                          items: _products.map((product) {
                            return DropdownMenuItem(
                              child: Text(product),
                              value: product,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 25,),
                        Container(
                          padding: EdgeInsets.only(left: 20,),
                          child: Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE9E9E9),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:   BorderRadius.circular(30),
                                borderSide: BorderSide(color: Color(0xFFE9E9E9), width: 0)
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
