import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

String? faviconGet(String url){

  String? path;

  if(url.contains("smartstore.naver.com")){path = CIconPath.naverSmartStore;}
  else if(url.contains("shopping.naver.com")){path = CIconPath.naverSmartStore;}
  else if(url.contains("coupang.com")){path = CIconPath.coupang;}
  else if(url.contains("11st.co.kr")){path = CIconPath.sipilst;}
  else if(url.contains("gmarket.co.kr")){path = CIconPath.gmarket;}
  else if(url.contains("interpark.com")){path = CIconPath.interpark;}
  else if(url.contains("tmon.co.kr")){path = CIconPath.tmon;}
  else if(url.contains("auction.co.kr")){path = CIconPath.auction;}
  else if(url.contains("wemakeprice.com")){path = CIconPath.wemakeprice;}
  else if(url.contains(".ssg.com")){path = CIconPath.ssg;}
  else if(url.contains("emart.ssg.com")){path = CIconPath.eMart;}
  else if(url.contains("homeplus.co.kr")){path = CIconPath.homePlus;}
  else if(url.contains("kakao.com")){path = CIconPath.kakaoGift;}
  else if(url.contains("lotteon.com")){path = CIconPath.lotteOn;}
  else if(url.contains("himart.co.kr")){path = CIconPath.hiMart;}
  else if(url.contains("gsshop.com")){path = CIconPath.gSShop;}
  else if(url.contains("aladin.co.kr")){path = CIconPath.aladin;}
  else if(url.contains("yes24.com")){path = CIconPath.yes24;}
  else if(url.contains("oliveyoung.co.kr")){path = CIconPath.oliveyoung;}
  else if(url.contains("kurly.com")){path = CIconPath.marketKurly;}
  else if(url.contains("danawa.com")){path = CIconPath.danawa;}
  else if(url.contains("ohou.se")){path = CIconPath.ohou;}
  else if(url.contains("musinsa.com")){path = CIconPath.musinsa;}
  else if(url.contains("zigzag.kr")){path = CIconPath.zigzag;}
  else if(url.contains("a-bly.com")){path = CIconPath.ably;}
  else if(url.contains("hmall.com")){path = CIconPath.hmall;}


  return path;
}

String? mallNameGet(String url){

  String? path;

  if(url.contains("smartstore.naver.com")){path = '네이버';}
  else if(url.contains("shopping.naver.com")){path = '네이버';}
  else if(url.contains("coupang.com")){path = '쿠팡';}
  else if(url.contains("11st.co.kr")){path = '11번가';}
  else if(url.contains("gmarket.co.kr")){path = 'G마켓';}
  else if(url.contains("interpark.com")){path = '인터파크';}
  else if(url.contains("tmon.co.kr")){path = '티몬';}
  else if(url.contains("auction.co.kr")){path = '옥션';}
  else if(url.contains("wemakeprice.com")){path = '위메프';}
  else if(url.contains(".ssg.com")){path = 'ssg';}
  else if(url.contains("emart.ssg.com")){path = '이마트';}
  else if(url.contains("homeplus.co.kr")){path = '홈플러스';}
  else if(url.contains("kakao.com")){path = '카카오';}
  else if(url.contains("lotteon.com")){path = '롯데ON';}
  else if(url.contains("himart.co.kr")){path = '하이마트';}
  else if(url.contains("gsshop.com")){path = 'GS샵';}
  else if(url.contains("aladin.co.kr")){path = '알라딘';}
  else if(url.contains("yes24.com")){path = 'yes24';}
  else if(url.contains("oliveyoung.co.kr")){path = '올리브영';}
  else if(url.contains("kurly.com")){path = '마켓컬리';}
  else if(url.contains("danawa.com")){path = '다나와';}
  else if(url.contains("ohou.se")){path = '오늘의집';}
  else if(url.contains("musinsa.com")){path = '무신사';}
  else if(url.contains("zigzag.kr")){path = '지그재그';}
  else if(url.contains("a-bly.com")){path = '에이블리';}
  else if(url.contains("hmall.com")){path = 'h몰';}

  return path;
}