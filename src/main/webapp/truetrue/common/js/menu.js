/*
 * 프론트 MENU JSON
 */
var MenuInfo =[
	{ "id" : "00", "menu_code" : "000000", "nm" : "메인", "link" : ""},
	{ "id" : "01", "menu_code" : "010000", "nm" : "브랜드 소식", "link" : "/story/intro.asp", "child" :
		[
		 	{ "id" : "01", "menu_code" : "010100", "nm" : "브랜드 스토리", "link" : "/story/intro.asp"},
		 	{ "id" : "02", "menu_code" : "010200", "nm" : "뚜레쥬르 광고", "link" : "/story/ad/tv.asp"},
		 	{ "id" : "03", "menu_code" : "010300", "nm" : "뚜레쥬르 웹진", "link" : "/story/webzine/list.asp"},
		 	{ "id" : "04", "menu_code" : "010400", "nm" : "뚜레쥬르 라뜰리에", "link" : "/store/ratelier/default.asp"},
		 	{ "id" : "05", "menu_code" : "010500", "nm" : "글로벌 뚜레쥬르", "link" : "/story/global.asp"},
		 	{ "id" : "06", "menu_code" : "010600", "nm" : "뉴스 & 공지사항", "link" : "/community/news/list.asp"},
			{ "id" : "07", "menu_code" : "010700", "nm" : "뚜레쥬르 착한빵", "link" : "/story/goodBread.asp"},
			{ "id" : "08", "menu_code" : "010800", "nm" : "재료이야기", "link" : "/story/health/summary.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "010801", "nm" : "재료이야기 개요", "link" : "/story/health/summary.asp"},
				 	{ "id" : "02", "menu_code" : "010802", "nm" : "밀가루", "link" : "/story/health/flour.asp"},
				 	{ "id" : "03", "menu_code" : "010803", "nm" : "천일염", "link" : "/story/health/salt.asp"},
		 		 	{ "id" : "04", "menu_code" : "010804", "nm" : "순우유", "link" : "/story/health/milk.asp"},
		 		 	{ "id" : "05", "menu_code" : "010805", "nm" : "순치즈", "link" : "/story/health/cheese.asp"},
		 		 	{ "id" : "06", "menu_code" : "010806", "nm" : "순꿀", "link" : "/story/health/honey.asp"},
					{ "id" : "07", "menu_code" : "010807", "nm" : "순감자", "link" : "/story/health/potato.asp"},
					{ "id" : "08", "menu_code" : "010808", "nm" : "땅콩호박", "link" : "/story/health/butternut_squash.asp"}
				]
			},
		]
	},
	{ "id" : "02", "menu_code" : "020000", "nm" : "제품", "link" : "/product/new.asp", "child" :
		[
			{ "id" : "01", "menu_code" : "020100", "nm" : "신제품", "link" : "/product/new.asp"},
			{ "id" : "02", "menu_code" : "020200", "nm" : "빵", "link" : "/product/list.asp?ref=2", "child" :
		 		[
					{ "id" : "01", "menu_code" : "020201", "nm" : "전체", "link" : "/product/list.asp?ref=2"},
		 		 	{ "id" : "02", "menu_code" : "020202", "nm" : "간식빵", "link" : "/product/list.asp?ref=2&cg_num=11"},
		 		 	{ "id" : "03", "menu_code" : "020203", "nm" : "식빵", "link" : "/product/list.asp?ref=2&cg_num=12"},
		 		 	{ "id" : "04", "menu_code" : "020204", "nm" : "도넛/고로케", "link" : "/product/list.asp?ref=2&cg_num=16"},
		 		 	{ "id" : "05", "menu_code" : "020205", "nm" : "파이/패스트리", "link" : "/product/list.asp?ref=2&cg_num=15"},
		 		 	{ "id" : "06", "menu_code" : "020206", "nm" : "건강빵", "link" : "/product/list.asp?ref=2&cg_num=13"},
		 		 	{ "id" : "07", "menu_code" : "020207", "nm" : "조리빵", "link" : "/product/list.asp?ref=2&cg_num=14"}
		 		]
			},
			{ "id" : "03", "menu_code" : "020300", "nm" : "케이크", "link" : "/product/list.asp?ref=3", "child" :
		 		[
					{ "id" : "01", "menu_code" : "020301", "nm" : "전체", "link" : "/product/list.asp?ref=3"},
		 		 	{ "id" : "02", "menu_code" : "020302", "nm" : "생크림케이크", "link" : "/product/list.asp?ref=3&cg_num=22"},
		 		 	{ "id" : "03", "menu_code" : "020303", "nm" : "무스케이크", "link" : "/product/list.asp?ref=3&cg_num=21"},
		 		 	{ "id" : "04", "menu_code" : "020304", "nm" : "스페셜케이크", "link" : "/product/list.asp?ref=3&cg_num=17"},
		 		 	{ "id" : "05", "menu_code" : "020305", "nm" : "대형케이크", "link" : "/product/list.asp?ref=3&cg_num=76"},
		 		 	{ "id" : "06", "menu_code" : "020306", "nm" : "조각케이크", "link" : "/product/list.asp?ref=3&cg_num=23"},
					{ "id" : "07", "menu_code" : "020307", "nm" : "캐릭터케이크", "link" : "/product/list.asp?ref=3&cg_num=20"},
					{ "id" : "08", "menu_code" : "020308", "nm" : "파티용품", "link" : "/product/list.asp?ref=3&cg_num=85"}
			 	]
			},
			{ "id" : "04", "menu_code" : "020400", "nm" : "델리", "link" : "/product/list.asp?ref=39", "child" :
		 		[
		 		 	{ "id" : "01", "menu_code" : "020401", "nm" : "전체", "link" : "/product/list.asp?ref=39"},
					{ "id" : "02", "menu_code" : "020402", "nm" : "샌드위치", "link" : "/product/list.asp?ref=39&cg_num=43"},
					{ "id" : "03", "menu_code" : "020403", "nm" : "샐러드", "link" : "/product/list.asp?ref=39&cg_num=80"},
					{ "id" : "04", "menu_code" : "020404", "nm" : "간편식", "link" : "/product/list.asp?ref=39&cg_num=81"}
			 	]
			},
			{ "id" : "05", "menu_code" : "020500", "nm" : "음료", "link" : "/product/list.asp?ref=4", "child" :
		 		[
					{ "id" : "01", "menu_code" : "020501", "nm" : "전체", "link" : "/product/list.asp?ref=4"},
		 		 	{ "id" : "02", "menu_code" : "020502", "nm" : "커피", "link" : "/product/list.asp?ref=4&cg_num=25"},
					{ "id" : "03", "menu_code" : "020503", "nm" : "블랜디드", "link" : "/product/list.asp?ref=4&cg_num=57"}	,
		 		 	{ "id" : "04", "menu_code" : "020504", "nm" : "빙수", "link" : "/product/list.asp?ref=4&cg_num=27"},
		 		 	{ "id" : "05", "menu_code" : "020505", "nm" : "과일주스/에이드", "link" : "/product/list.asp?ref=4&cg_num=26"},
					{ "id" : "06", "menu_code" : "020506", "nm" : "티/라떼류", "link" : "/product/list.asp?ref=4&cg_num=58"},
		 		 	{ "id" : "07", "menu_code" : "020507", "nm" : "우유/병음료", "link" : "/product/list.asp?ref=4&cg_num=28"}
			 	]
			},
			{ "id" : "06", "menu_code" : "020600", "nm" : "디저트&스낵", "link" : "/product/list.asp?ref=5", "child" :
				[
					{ "id" : "01", "menu_code" : "020601", "nm" : "전체", "link" : "/product/list.asp?ref=5"},
		 		 	{ "id" : "02", "menu_code" : "020602", "nm" : "구움양과", "link" : "/product/list.asp?ref=5&cg_num=82"},
		 		 	{ "id" : "03", "menu_code" : "020603", "nm" : "마카롱", "link" : "/product/list.asp?ref=5&cg_num=83"},
		 		 	{ "id" : "04", "menu_code" : "020604", "nm" : "잼/스프레드", "link" : "/product/list.asp?ref=5&cg_num=44"},
		 		 	{ "id" : "05", "menu_code" : "020605", "nm" : "초콜릿/캔디", "link" : "/product/list.asp?ref=5&cg_num=35"},
		 		 	{ "id" : "06", "menu_code" : "020606", "nm" : "아이스크림", "link" : "/product/list.asp?ref=5&cg_num=37"}
			 	]
			},
			{ "id" : "07", "menu_code" : "020700", "nm" : "캐릭터제품", "link" : "/product/character.asp"},
			{ "id" : "08", "menu_code" : "020800", "nm" : "검색결과", "link" : "/product/result.asp"},
			{ "id" : "09", "menu_code" : "020900", "nm" : "선물", "link" : "/product/list.asp?ref=77", "child" :
		 		[
		 		 	{ "id" : "01", "menu_code" : "020901", "nm" : "전체", "link" : "/product/list.asp?ref=77"},
					{ "id" : "02", "menu_code" : "020902", "nm" : "롤/파운드/카스테라", "link" : "/product/list.asp?ref=77&cg_num=78"},
					{ "id" : "03", "menu_code" : "020903", "nm" : "선물세트", "link" : "/product/list.asp?ref=77&cg_num=79"}
			 	]
			}
		]
	},
	{ "id" : "03", "menu_code" : "030000", "nm" : "새로워진 뚜레쥬르", "link" : "/bread/new.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "030100", "nm" : "New 뚜레쥬르 살펴보기", "link" : "/bread/new.asp"},
					{ "id" : "02", "menu_code" : "030200", "nm" : "건강한 데일리 베이커리", "link" : "/bread/intro.asp"}
				]
			},
	{ "id" : "04", "menu_code" : "040000", "nm" : "이벤트&멤버십", "link" : "/community/event_tpl/list.asp", "child" :
		[
			{ "id" : "01", "menu_code" : "040100", "nm" : "진행중인 이벤트", "link" : "/community/event_tpl/list.asp"},
			{ "id" : "02", "menu_code" : "040200", "nm" : "이벤트 당첨자", "link" : "/community/winner/list.asp"},
			{ "id" : "03", "menu_code" : "040300", "nm" : "CJ ONE 멤버십", "link" : "/membership/member.asp"},
		]
	},
	{ "id" : "16", "menu_code" : "160000", "nm" : "제휴혜택&기프트카드", "link" : "/benefit/partner.asp", "child" :
		[
			{ "id" : "01", "menu_code" : "160100", "nm" : "제휴 혜택", "link" : "/benefit/partner.asp", "child" :
				[
					{ "id" : "01", "menu_code" : "160101", "nm" : "통신사 멤버십 혜택", "link" : "/benefit/partner.asp"},
					{ "id" : "02", "menu_code" : "160102", "nm" : "신용카드&멤버십 제휴카드 혜택", "link" : "/benefit/partner2.asp"},
					{ "id" : "03", "menu_code" : "160103", "nm" : "포인트&보너스 적립 혜택", "link" : "/benefit/partner3.asp"},
					{ "id" : "04", "menu_code" : "160104", "nm" : "상품권 혜택", "link" : "/benefit/partner4.asp"}
				]
			},
			{ "id" : "02", "menu_code" : "160200", "nm" : "기프트카드", "link" : "/benefit/giftcard.asp"},
		]
	},
	{ "id" : "05", "menu_code" : "050000", "nm" : "기사 채용안내", "link" : "/recruit/recruit_index.asp", "child" :
		[
		 	{ "id" : "01", "menu_code" : "050100", "nm" : "기사 채용안내", "link" : "/recruit/recruit_index.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "050101", "nm" : "제빵교육원 채용안내", "link" : "/recruit/bakery/intro.asp"},
				 	{ "id" : "02", "menu_code" : "050102", "nm" : "테크니컬센터 채용안내", "link" : "/recruit/recruit_tech.asp"},
				 	{ "id" : "03", "menu_code" : "050103", "nm" : "경력기사 채용안내", "link" : "/recruit/career_intro.asp"},
				 	{ "id" : "04", "menu_code" : "050104", "nm" : "아르바이트채용", "link" : "/recruit/alba/alba_list.asp"}
				 ]
		 	},
		 	{ "id" : "02", "menu_code" : "050200", "nm" : "기사 채용공고", "link" : "/recruit/notice/list.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "050201", "nm" : "온라인 지원", "link" : "/recruit/apply_start.asp"},
				 	{ "id" : "02", "menu_code" : "050202", "nm" : "온라인 지원", "link" : "/recruit/apply_start_career.asp"}
				 ]
		 	},
		 	{ "id" : "03", "menu_code" : "050300", "nm" : "전형결과", "link" : "/recruit/result.asp"},
		 	{ "id" : "04", "menu_code" : "050400", "nm" : "채용지역", "link" : "/recruit/faq.asp"},
			{ "id" : "05", "menu_code" : "050500", "nm" : "교육일정", "link" : "/recruit/training.asp"}
		 ]
	},
	{ "id" : "06", "menu_code" : "060000", "nm" : "창업안내", "link" : "/franchise/index.asp", "child" :
		[
		 	{ "id" : "01", "menu_code" : "060100", "nm" : "뚜레쥬르 신모델소개", "link" : "/franchise/introduction/new.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "060101", "nm" : "새로워진 뚜레쥬르", "link" : "/franchise/introduction/new.asp"},
				 	{ "id" : "02", "menu_code" : "060102", "nm" : "신모델의 장점", "link" : "/franchise/introduction/advantages.asp"}
				 ]
			},
		 	{ "id" : "02", "menu_code" : "060200", "nm" : "창업성공스토리", "link" : "/franchise/story/story.asp"},
		 	{ "id" : "03", "menu_code" : "060300", "nm" : "창업준비하기", "link" : "/franchise/preparation/procedure.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "060301", "nm" : "창업준비절차", "link" : "/franchise/preparation/procedure.asp"},
				 	{ "id" : "02", "menu_code" : "060302", "nm" : "창업투자비", "link" : "/franchise/preparation/investment.asp"},
				 	{ "id" : "03", "menu_code" : "060303", "nm" : "창업대출안내", "link" : "/franchise/preparation/loanInvitation.asp"},
					{ "id" : "04", "menu_code" : "060304", "nm" : "창업FAQ", "link" : "/franchise/preparation/faq.asp"},
					{ "id" : "05", "menu_code" : "060305", "nm" : "창업상담", "link" : "/franchise/preparation/consultation.asp"},
					{ "id" : "06", "menu_code" : "060306", "nm" : "창업문의연락처", "link" : "/franchise/preparation/contactUs.asp"}
				 ]
			},
			{ "id" : "04", "menu_code" : "060400", "nm" : "창업 설명회", "link" : "/franchise/briefing/periodic.asp", "child" :
				[
				 	{ "id" : "01", "menu_code" : "060401", "nm" : "정기창업설명회", "link" : "/franchise/briefing/periodic.asp"},
				 	{ "id" : "02", "menu_code" : "060402", "nm" : "우리동네창업설명회", "link" : "/franchise/briefing/village.asp"},
				 	{ "id" : "03", "menu_code" : "060403", "nm" : "주부창업설명회", "link" : "/franchise/briefing/weekend.asp"}
				 ]
			}
		 ]
	},
	{ "id" : "07", "menu_code" : "070000", "nm" : "로그인", "link" : "/CJFVSite/login.html", "child" :
		[
			{ "id" : "01", "menu_code" : "070100", "nm" : "아이디 찾기", "link" : "/CJFVSite/search_id.html"},
			{ "id" : "02", "menu_code" : "070200", "nm" : "비밀번호 찾기", "link" : "/CJFVSite/search_pw.html"},
			{ "id" : "03", "menu_code" : "070300", "nm" : "회원 약관 동의", "link" : "/CJFVSite/mem_subscrib.html", "child" :
				[
					{ "id" : "01", "menu_code" : "070301", "nm" : "완료", "link" : "/CJFVSite/mem_subscrib_end.html"}
				]
			},
			{ "id" : "04", "menu_code" : "070400", "nm" : "회원 약관 동의", "link" : "/CJFVSite/mem_lra.html"}
		]
	},
	{ "id" : "08", "menu_code" : "080000", "nm" : "매장안내", "link" : "/store/search.asp"},
	{ "id" : "09", "menu_code" : "090000", "nm" : "고객센터", "link" : "/center/main.asp", "child" :
		[
			{ "id" : "01", "menu_code" : "090100", "nm" : "FAQ", "link" : "/center/faq.asp"},
			{ "id" : "02", "menu_code" : "090200", "nm" : "온라인 상담", "link" : "/center/qna.asp"},
			{ "id" : "03", "menu_code" : "090300", "nm" : "온라인 상담 내역", "link" : "/center/myQna/gate.asp"}
		]
	},
	{ "id" : "10", "menu_code" : "100000", "nm" : "마이페이지", "link" : "/mypage/main.asp", "child" :
		[
			{ "id" : "01", "menu_code" : "100100", "nm" : "마이멤버십", "link" : "/mypage/membership/point.asp", "child" :
				[
					{ "id" : "01", "menu_code" : "100101", "nm" : "포인트 조회", "link" : "/mypage/membership/point.asp"},
					{ "id" : "02", "menu_code" : "100102", "nm" : "쿠폰 조회", "link" : "/mypage/membership/coupon.asp"}
				]
			},
			{ "id" : "02", "menu_code" : "100200", "nm" : "온라인 상담 내역", "link" : "/mypage/myQna.asp"},
			{ "id" : "03", "menu_code" : "100300", "nm" : "개인정보관리", "link" : "/CJFVSite/member_mgt.html"}
		]
	},
	{ "id" : "11", "menu_code" : "110000", "nm" : "이용약관", "link" : "/etc/agree_v5-6.asp"},
	{ "id" : "12", "menu_code" : "120000", "nm" : "개인정보처리방침", "link" : "/etc/privacy.asp"},
	{ "id" : "13", "menu_code" : "130000", "nm" : "법적고지", "link" : "/etc/legal.asp"},
	{ "id" : "14", "menu_code" : "140000", "nm" : "이메일 무단수집거부", "link" : "/etc/email.asp"},
	{ "id" : "15", "menu_code" : "150000", "nm" : "사이트맵", "link" : "/etc/sitemap.asp"}

	,
	{ "id" : "99", "menu_code" : "990000", "nm" : "뚜레쥬르 앱&amp;온라인 쇼핑몰", "link" : "/shop/app/intro.asp", "child" :
		[
			{ "id" : "01", "menu_code" : "990100", "nm" : "뚜레쥬르 앱", "link" : "/shop/app/intro.asp"},
			{ "id" : "02", "menu_code" : "990200", "nm" : "홈페이지 전용 예약 배송", "link" : "/shop/shopping/goodsList.asp?cate=1"},
			{ "id" : "03", "menu_code" : "990300", "nm" : "꽃&케이크 택배 배송", "link" : "/shop/shopping/goodsList.asp?cate=7"},
			{ "id" : "04", "menu_code" : "990400", "nm" : "대량 구매 문의", "link" : "/shop/cs/b2b.asp"}
		]
	}
];

function searchStore() {
    var keyword = document.getElementById("keyword").value;
    if (keyword.trim() === '') {
        alert("매장명이나 시/군/구 명을 입력하세요.");
        return false;
    }
    window.location.href = '/truetrue/store/store_list.jsp?keyword=' + encodeURIComponent(keyword);
}

/*
 * 프론트 MENU 정보 표시 (type T:페이지 타이틀, L:라인맵)
 */
function showMenuInfo(menu_id, type){
	try{
		if(menu_id != null && menu_id.length == 6){
			var depth1_id = menu_id.substring(0,2);
			var depth2_id = menu_id.substring(2,4);
			var depth3_id = menu_id.substring(4,6);
			var arrPT =  new Array();
			var arrLM =  new Array();
			var arrLM2 = new Array();
			var link = '';

			jQuery.map(MenuInfo, function(obj1) { // 1depth 검색
				if(obj1.id == depth1_id){
					arrPT[0] = obj1.nm;
					arrLM[0] = "<a href='"+obj1.link+"'>"+obj1.nm+"</a>";
					arrLM2[0] = "<a>"+obj1.nm+"</a>";
					link = obj1.link;

					if(depth2_id != "00" && obj1.child){
						jQuery.map(obj1.child, function(obj2) {  // 2depth 검색
							 if(obj2.id == depth2_id){
									arrPT[1] = obj2.nm;
									arrLM[1] = "<a href='"+obj2.link+"'>"+obj2.nm+"</a>";
									arrLM2[1] = "<a>"+obj2.nm+"</a>";
									link = obj2.link;

							 		if(depth3_id != "00" && obj2.child){
										jQuery.map(obj2.child, function(obj3) {  // 3depth 검색
											 if(obj3.id == depth3_id){
													arrPT[2] = obj3.nm;
													arrLM[2] = "<a href='"+obj3.link+"'>"+obj3.nm+"</a>";
													arrLM2[2] = "<a>"+obj3.nm+"</a>";
													link = obj3.link;
											 }
										});
									}
							  }
						});
					}
				}
			});

			var arrLen = arrPT.length;
			if (menu_id == "000000")	arrLen = arrLen - 1;

			if (type == "T") { // 페이지 타이틀
				var page_title = "";
				for(var i = arrLen; i > 0; i--){
					page_title += arrPT[i-1] + " | ";
				}
				page_title += "뚜레쥬르";
				//document.write(page_title);
				$('title').html(page_title);

			} else if(type == "L") { // 라인맵
				var line_map = "<a href='/'>Home</a>";
				for(var i = 0; i < arrLen; i++){
					if(i == arrLen-1){
						line_map += "" + arrLM2[i];
					}else{
						line_map += "" + arrLM[i];
					}
				}
				$('.path').html('<ul><li>' + line_map + '</li></ul>');

			} else if(type == 'U') { //링크 url
				location.href = link;
			}
		}
	}catch(e){}
}