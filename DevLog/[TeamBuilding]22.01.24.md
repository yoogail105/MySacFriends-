### Team Uno 팀빌딩 일지
- 일시: 2022/01/24

- 내용
1. 🧑‍💻 현재 진행 상황 공유<br/>
    ◦ 경후: 회원가입 로직 구현<br/>
    ◦ 정민: 젠더 뷰<br/>
    ◦ 민주: 젠더 뷰<br/>
2. 🙋 질문 및 논의 사항<br/>
    ◦ 뷰컨트롤러에서 pushViewController()가 안돼요🥲<br/>
        👉 NavigationController에 rootViewcontroller로 뷰컨을 넣어주어야 합니다.<br/>
    ◦ 젠더 값 처리 어떻게 하시나요? UserDefaults 기본값이 0이라, 화면에 들어가면 이미 선택되어 있는 것으로 처리됩니다🥲<br/>
        👉 enum Gender: Int { case women = 0 ,,,} 으로 처리하는것 어떤가요?<br/>
