
import 'dart:math';

class ZKRandom {

  static String random({int lenght}) {

    String alphabet = '12356789';
    int strlenght = 4; /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }


}