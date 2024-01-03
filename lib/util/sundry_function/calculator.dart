import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

String timeCalculator(String createdAt) {


  String timeCalculator = '';

  List<int> timeDifference = [0, 0, 0, 0, 0, 0];

  timeDifference[0] = DateTime.now().year - int.parse(createdAt.substring(0, 4));
  timeDifference[1] = DateTime.now().month - int.parse(createdAt.substring(5, 7));
  timeDifference[2] = DateTime.now().day - int.parse(createdAt.substring(8, 10));
  timeDifference[3] = DateTime.now().hour - int.parse(createdAt.substring(11, 13));
  timeDifference[4] = DateTime.now().minute - int.parse(createdAt.substring(14, 16));
  timeDifference[5] = DateTime.now().second - int.parse(createdAt.substring(17, 19));




  if (timeDifference[0] != 0) {
    timeCalculator = '${timeDifference[0]}년전';
  } else {
    if (timeDifference[1] != 0) {
      timeCalculator = '${timeDifference[1]}달전';
    } else {
      if (timeDifference[2] != 0) {
        timeCalculator = '${timeDifference[2]}일전';
      } else {
        if (timeDifference[3] != 0) {
          if (timeDifference[3] == 1) {
            if ((DateTime.now().minute + 60 - int.parse(createdAt.substring(14, 16))) < 59) {
              timeCalculator = '${DateTime.now().minute + 60 - int.parse(createdAt.substring(14, 16))}분전';
            } else {
              timeCalculator = '1시간전';
            }
          } else {
            timeCalculator = '${timeDifference[4]}분전';
          }
        } else {

          if (timeDifference[4] != 0) {
            timeCalculator = '${timeDifference[4]}분전';
          } else {
            if (timeDifference[5] != 0) {
              timeCalculator = '방금전';
            }
          }
        }
      }
    }
  }
  return timeCalculator;
}

List<int> imageListCalculator(int index, List<int> splitPoint) {
  List<int> tempData = [];
  int itemNumber = 0;
  int imageNumber = index;

  int splitAdd = 0;

  for (int i = 0; i < splitPoint.length; i++) {
    splitAdd += splitPoint[i];
    if (index + 1 > splitAdd) {
      itemNumber++;
      imageNumber -= splitPoint[i];
    }
  }
  tempData.add(itemNumber);
  tempData.add(imageNumber);

  return tempData;
}

///풀리스트에 사용되는 인덱스를 다시 온전한 인덱스로 풀어제끼는 함수
int imageListCalculatorReverse(List<int> index, List<int> splitPoint) {
  int tempData = 0;

  int itemNumber = index[0];
  int subNumber = index[1];

  int splitAdd = 0;

  for (int i = 0; i < splitPoint.length; i++) {
    if (itemNumber > 0) {
      tempData += splitPoint[i];
      itemNumber--;
    }
  }
  tempData += subNumber;

  return tempData;
}

///카트 아이템에 이 url이 존재하는지 찾아내는 함수
bool checkInMyCart(String url){
  bool isContain = false;

  if(url=='empty'){
    return true;
  }else{
    for(int i=0; i<cartController.filteredCartList.length; i++){
      if(cartController.filteredCartList[i].url == url){
        isContain = true;
        return isContain;
      }
    }
  }


  return isContain;
}
