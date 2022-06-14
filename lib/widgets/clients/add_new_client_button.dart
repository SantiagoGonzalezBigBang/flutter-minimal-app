import 'package:flutter/material.dart';

import 'package:minimal_app/widgets/widgets.dart';

class AddNewClientButton extends StatelessWidget {
  const AddNewClientButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Add New',
      isSmall: true,
      onPressed: () {},
    );
  }
}