double doubleSetPrecision({ required double num, required int setPrecision}){
  String numText = num.toString();
  print("$num .. $numText");
  String goodText = "";
  int cnt = 0;
  
  for(int index=0; index<numText.length; index++){
    goodText = goodText + numText[index];
    if(numText[index]=='.'||cnt>0){
      cnt = cnt+1;
      if(cnt>setPrecision)break;
    }
    
  }
  print("$numText $goodText");
  return double.parse(goodText);
}