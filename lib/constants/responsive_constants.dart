import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

var defaultColor = Colors.grey[300];

double responsiveSearchWidth({ required BoxConstraints boxConstraints}){
  if(boxConstraints.maxWidth<500)return 100;
  if(boxConstraints.maxWidth<1000){
    return 200;
  }
  else {
  return 400;
  }
}

double responsiveNormalButtonFontSize({ required BoxConstraints boxConstraints}){
  if(boxConstraints.maxWidth<500)return 11;
  if(boxConstraints.maxWidth<100){
    return 13;
  }
  else {
  return 17;
  }
}

