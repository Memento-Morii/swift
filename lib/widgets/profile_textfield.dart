import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';

class ProfileTextField extends StatefulWidget {
  ProfileTextField({this.initalName, this.onChanged});
  final String initalName;
  final Function onChanged;
  @override
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  bool isDisabled;
  @override
  void initState() {
    isDisabled = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              onChanged: widget.onChanged,
              style: CustomTextStyles.mediumText,
              initialValue: widget.initalName,
              enabled: isDisabled ? false : true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: isDisabled ? Colors.grey : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isDisabled = !isDisabled;
              });
            },
          ),
        ],
      ),
    );
  }
}
