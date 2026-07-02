int getSizeOfEachRow(int rowNumber){
  switch(rowNumber){
    case 0 : return 4;
    case 1 : return 6;
    case 2 : return 8;
    case 3 : return 6;
    case 4 : return 4;
    default: return -1;
  }
}

String getRowName(int rowNumber){
  switch(rowNumber){
    case 0 : return "A";
    case 1 : return "B";
    case 2 : return "C";
    case 3 : return "D";
    case 4 : return "E";
    default: return "";
  }
}