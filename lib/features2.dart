import 'package:flutter/material.dart';
import 'package:mechanic_app/taskmodel.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.model});
  Taskmodel model;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: _mediaQuery.size.height * 0.07,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: _mediaQuery.size.height * 0.04,
                  width: _mediaQuery.size.height * 0.04,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 19, 18, 18),
                          width: _mediaQuery.size.height * 0.0002),
                      // color: Colors.pink,
                      borderRadius: BorderRadius.all(
                          Radius.circular(_mediaQuery.size.height * 0.03))),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: _mediaQuery.size.height * 0.1),
                child: Text(
                  'ProductDetails',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: _mediaQuery.size.height * 0.03),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _mediaQuery.size.height * 0.04,
                  ),
                  Center(
                    child: Text(
                      model.productname,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: _mediaQuery.size.height * 0.02 * 1.3,
                          fontFamily: 'MyFont'),
                    ),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey[700],
                    thickness: _mediaQuery.size.height * 0.001,
                  ),

                  SizedBox(
                    height: _mediaQuery.size.height * 0.03,
                  ),

                  Text(
                    'Performance',
                    style: TextStyle(
                        fontSize: _mediaQuery.size.height * 0.02 * 1.1,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'MyFont'),
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.05,
                  ),

                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          // width: _mediaQuery.size.height * 0.06,
                          child: Text(
                            'EngineType',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          model.enginetype,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey[700],
                    thickness: _mediaQuery.size.height * 0.0002,
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.03,
                  ),

                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'HorsePower',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          model.horsepower,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey[700],
                    thickness: _mediaQuery.size.height * 0.0002,
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.03,
                  ),

                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Torque',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          model.torque,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey[700],
                    thickness: _mediaQuery.size.height * 0.0002,
                  ),
                  // If the document exists, update 'productname' field

                  SizedBox(
                    height: _mediaQuery.size.height * 0.03,
                  ),

                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Fuel Efficiency',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          model.fuelefficiency,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey[700],
                    thickness: _mediaQuery.size.height * 0.0002,
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.03,
                  ),

                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Engine Oil Level',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          model.engineoil,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _mediaQuery.size.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey[700],
                    thickness: _mediaQuery.size.height * 0.0002,
                  ),
                ])));
    ;
  }
}
