## ✍️ Projects
  <img src="https://github.com/kimsoohyun3/Development_Lesson_Project/assets/127597074/65bdb367-d48c-4f5a-9eb5-210ddb0154ee" alt=""/>

> 2022.06.10 - 2022.07.05
> **Back-End Developer**

<br/>

## 🛠 사용 기술
- Java
- Spring
- MyBatis
- JSP
- JavaScript, jQuery, HTML5, CSS

<br/>
<br/>

|프론트엔드, 백엔드 유효성 검사, 이메일 인증을 통한 회원가입|아이디, 비밀번호 찾기, 로그인 (+ 소셜 로그인), 로그아웃|
|------|---|
|![111](https://user-images.githubusercontent.com/108200179/177039710-0b4dda93-a69a-4158-905c-2ebcad915c69.gif)|![444](https://user-images.githubusercontent.com/108200179/177088647-de52244c-5881-4d5c-ae2a-359269a0418d.gif)|
|프로필 조회, 수정|공지사항 조회, 등록 수정 삭제(관리자 권한 계정만 허용), 페이징 처리|
|![2222](https://user-images.githubusercontent.com/108200179/177089392-6b07b7df-0e5b-427c-876a-d6f30317d509.gif)|![3333](https://user-images.githubusercontent.com/108200179/177089399-5b9cd1ac-4263-405f-ae12-6a410e81dd63.gif)|

<br/>

## 🖥 기능
- 프론트엔드, 백엔드 유효성 검사, 이메일 인증을 통한 회원가입 구현
- 아이디, 비밀번호 찾기 구현
- 로그인 (+ 소셜 로그인), 로그아웃 구현
- 프로필 조회, 수정 구현
- 공지사항 조회, 등록 수정 삭제(관리자 권한 계정만 허용), 페이징 처리 구현 등

<br/>

❗네이버 로그인 구현 후 검수 요청 관련입니다.

![Untitled](https://github.com/kimsoohyun3/Development_Lesson_Project/assets/127597074/9e85366f-1c4f-49f1-9211-9aeafc6cb77d)

위 사항을 현재 충족할 수 없어 네이버 로그인은 네이버 개발자센터에 관리자, 테스터 ID 로 설정된 ID 만 로그인이 가능합니다.

<br/>
<br/>

## 💬 아쉬운 점
- Dependency 버전 맞추기 등 Spring Legacy 특성상 일일이 세팅해 줘야 할 부분을 초반에 신경 쓰지 못한 것이 아쉬웠습니다.
  하지만 바로 수정해 주고, Spring 의 작동 방식도 다시금 들여다보게 되었습니다.
- Spring Security 를 적용했으면 일일이 보안 관련 로직을 작성할 필요가 없었던 점이 아쉬웠습니다.
  추후 Spring Security 공부의 필요성을 알게 되었습니다.

<br/>

## 💡생각에 남는 문제 직면 과정

네이버 로그인 기능이 Local 서버에서 잘 동작되었습니다.

도메인 구입 후 REDIRECT_URL 을 로컬 URL 에서 구입한 도메인으로 변경해 주었고,

네이버 개발자 센터 서비스 URL, 로그인 Callback URL 경로도 올바르게 변경해 주었음에도

EC2 서버로 배포 후에는 기능이 앞단에서부터 동작되지 않았습니다.

![스크린샷 2023-06-27 오후 6 16 31](https://github.com/kimsoohyun3/Development_Lesson_Project/assets/127597074/4d5b7e4c-19e7-45ad-a3e5-e8d3fb09250f)

위와 같이 확인해 보니 변경한 URL 경로가 적용되지 않는 표면적인 문제를 확인했습니다.

여러 가지 경우를 두고 이유를 찾아본 결과

![스크린샷 2023-06-27 오후 8 07 15](https://github.com/kimsoohyun3/Development_Lesson_Project/assets/127597074/49212d53-8225-43f1-989b-87d83de2091d)

위와 같이 URL 변경 후 Maven Build 가 계속 실패되고 있는 근본적인 문제를 확인했습니다. 

그래서 Maven 프로젝트 목표 설정을 통해 해결하였고,

Spring 의 깊은 이해와 정립이 더욱 필요하다고 생각이 드는 문제였습니다.
