import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/pages/consumtion/consumtion.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:alcohol_check/utils/enums/gender_enum.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:flutter/material.dart';

class PersonDeatils extends StatefulWidget {
  const PersonDeatils({super.key});

  @override
  _PersonDeatilsState createState() => _PersonDeatilsState();
}

class _PersonDeatilsState extends State<PersonDeatils> {
  Gender gender = Gender.man;
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    UserData userData = UserData(
      height: height,
      weight: weight,
      gender: gender,
    );
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: userDetaills(userData),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Padding userDetaills(UserData userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Vänligen fyll i dina uppgifter:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20.0),
          // Height input field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.whiteColor,
                    onChanged: (value) {
                      setState(() {
                        int? parsedHeight = int.tryParse(value);
                        if (parsedHeight != null) {
                          height = parsedHeight;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.whiteColor)),
                        labelText: 'Längd (cm)',
                        labelStyle: TextStyle(color: AppColor.whiteColor)),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                if (height.toString().length == 3)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          // Weight input field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.whiteColor,
                    onChanged: (value) {
                      setState(() {
                        int? parsedWeight = int.tryParse(value);
                        if (parsedWeight != null) {
                          weight = parsedWeight;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                        labelText: 'Vikt (kg)',
                        labelStyle: TextStyle(color: AppColor.whiteColor),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.whiteColor))),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                if (weight.toString().length == 2 ||
                    weight.toString().length == 3)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
              ],
            ),
          ),
          const SizedBox(height: 14.0),
          // Gender dropdown
          DropdownButton<Gender>(
            value: gender,
            onChanged: (newValue) {
              setState(() {
                gender = newValue!;
              });
            },
            items: Gender.values
                .map<DropdownMenuItem<Gender>>(
                  (Gender value) => DropdownMenuItem<Gender>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        '${value.toString().split('.').last[0].toUpperCase()}${value.toString().split('.').last.substring(1)}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20.0),

          if (height > 0 && weight > 0)
            CustomNavigationButton(
                text: 'Vidare',
                widgetNavigation: Consumtion(userData: userData))
        ],
      ),
    );
  }
}
