import 'package:flutter/cupertino.dart';

abstract class ResponsiveSizeConstants{
    static double widthScreen  (BuildContext context) => MediaQuery.of(context).size.width;
    static double heightScreen (BuildContext context) => MediaQuery.of(context).size.height;
    static double shortestSide(BuildContext context) => MediaQuery.of(context).size.shortestSide;
}