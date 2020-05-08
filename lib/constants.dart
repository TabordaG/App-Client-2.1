import 'package:flutter/material.dart';

import 'main.dart';

const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
const kTextColor = Color(0xFF1D150B);
const kPrimaryColor = Color(0xFFFB475F);  //Color(0xFF2e4c9e);
const kSecondaryColor = Color(0xFFF5E1CB);
const kBorderColor = Color(0xFFDDDDDD);

int carrinho = 0;
double scrollValue;
List<Food> cart = [];
TextEditingController search = TextEditingController();