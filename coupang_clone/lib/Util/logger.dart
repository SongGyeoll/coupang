import 'package:logger/logger.dart';
import 'dart:developer';


/* 로그를 단계별로 찍기 위한 공통 유틸
* ex)
logger.v("Verbose log");
logger.d("Debug log" );
logger.i("Info log");
logger.w("Warning log");
logger.e("Error log");
logger.wtf("What a terrible failure log");
*  */
var logger = Logger();