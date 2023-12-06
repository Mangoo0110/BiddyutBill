bool isValidDoubleText({ required String text}){
  //print(text);
  int textLen = text.length;
  int dotCount = 0;
  for(int index = 0; index<textLen; index++){
    if(text[index]=="."){
    dotCount = dotCount + 1;
    if(dotCount>1)return false;
    }
    else{
    if(text.codeUnitAt(index) < "0".codeUnitAt(0) || text.codeUnitAt(index) > "9".codeUnitAt(0)){
      //print(text.codeUnitAt(index) < "0".codeUnitAt(0));
      //print("${text[index]}");
      return false;
    }
    }
  }
  return true;
} 