import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color colorbg;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
    this.colorbg = Colors.blueGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      //primary: Color.fromRGBO(29, 194, 95, 1),
        primary: colorbg,
        //minimumSize: Size.fromHeight(50),
        //fixedSize: Size(200, 50)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    child: buildContent(),
    onPressed: onClicked,
  );

  Widget buildContent() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 28),
        SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
