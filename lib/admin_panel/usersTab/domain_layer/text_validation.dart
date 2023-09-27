String removeWhiteSpace(String text){
var len = text.length;
String goodText = "";
int space =0;
for(int index = 0; index<len; index++){
  if(text[index] == " "){
    space++;
    if(space<2) goodText = goodText + text[index];
  }
  else{
    goodText = goodText + text[index];
    space =0;
  }
}
return goodText;
}