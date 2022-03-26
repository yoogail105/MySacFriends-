## 22/01/25 Team Uno 팀빌딩 일지
### ☀️ 오전미팅 11:00 ~ 12:30 AM
0. 🗓 헉 2월!!
1. 🧑‍💻 현재 진행 상황 공유<br/>
2. 🙋 질문 및 논의 사항(feat. 🎄Dustin&Jack)<br/>
      ◦ 스크롤뷰 왜 안되는 것 입니까🤔<br/>
  • 🥕 더스틴님과 코드리뷰<br/>
      ◦ 접근제어자 쓰기<br/>
          ▪ final, private, ∙∙∙ 잘쓰면 평타, 안쓰면 마이너스임<br/>
      ◦ 커밋메세지를 잘 작성하자<br/>
          ▪ https://blog.ull.im/engineering/2019/03/10/logs-on-git.html <br/>
          ▪ https://overcome-the-limits.tistory.com/entry/%ED%98%91%EC%97%85-%ED%98%91%EC%97%85%EC%9D%84-%EC%9C%84%ED%95%9C-%EA%B8%B0%EB%B3%B8%EC%A0%81%EC%9D%B8-git-%EC%BB%A4%EB%B0%8B%EC%BB%A8%EB%B2%A4%EC%85%98-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0 <br/>
          ▪ 다른 사람들의 깃헙을 참고해봐요<br/>
      ◦ 네트워크 통신 등 에러 헨들링에 신경써봅시다<br/>
          ▪ 아래 두개는 옛날에 공유했던것. 두번째는 제 깃헙임 많관부<br/>
          ▪ https://benoitpasquier.com/error-handling-swift-mvvm/ <br/>
          ▪ https://github.com/yoogail105/MySacFriends-/blob/main/DevLog/%5B22.01.26%5DMVVM%EA%B3%BC%20Error%20%EC%BD%94%EB%93%9C%20%EC%B2%98%EB%A6%AC.md <br/>
      ◦ 정규식 만든거 모듈화해서 사용해보기<br/>
      ◦ RxSwift 제대로 이해하고 활용하자<br/>
          ▪ ex) AddTarget → ControlEvent<br/>
          ▪ 애매한 지점들에 대해서 팀원끼리 코드리뷰 해보고 멘토님 찾아가기<br/>
      ◦ 디렉토리구조<br/>
          ▪ 보편적으로 사용하는 폼을 맞춰서 하기<br/>
              • 다르게 쓸거면 남을 설득할 수 있는 그렇게 쓰게 된 명확한 이유 있어야 한다.<br/>
          ▪ 스타 많이 받은 깃헙 들어가서 참고하기<br/>
  • ☕️ 중간점검은 5시에 봐요<br/>

<br/><br/>
<br/>

### ☕️ 오후미팅 17:00 ~ 17:45 PM
1. 🧑‍💻 현재 진행 상황 공유<br/>
2. 🙋 질문 및 논의 사항(feat. 🎄Dustin&Jack)<br/>
    ◦ 🥲 스크롤뷰 오류를 함께 해결했다……
          ▪핵심은 scrollView(스크롤이 되는 화면)와, contentView(스크롤을 통해 보여지는 화면)의 4 부분 top, bottom, leading, trailing가 잘 잡혀 있어야 한다.<br/>
          ▪많은 우여곡절이 있었지만 결국 내 스크롤뷰가 움직이지 않았던 이유는 detailView의 height때문이었다. (내 스크롤뷰의 구조: scrollView > contentView > cardView, detailView)<br/>
          ▪ 나는 detailView 내에서 각 뷰의 절대 높이를 지정해 두었는데, scrollView에서 detailView의 bottom을 오토레이아웃으로 지정하려고 하니까 오류가 났던 것.
            • ??: 너의 높이는 48인데,, 니가 어떳케 늘어나서 컨텐츠뷰의 바닥까지 붙었음 조켓는데,,🤥(근데 이거 마자?)
        ▪ 👉 그래서 detailView의 높이를 지정해 주니까 해결되었다. ex) $0.height.equalTo(350)
    ◦ 🥕 경원캡틴의 포폴 피드백 공유
        ▪ 예시 이력서 공유 <br/>
