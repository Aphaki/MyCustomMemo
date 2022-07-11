# MyCustomMemo
- 데스노트 감성의 메모장

- 데스노트의 실제 룰을 가져와서 좀 더 그럴듯하게 꾸며줌

- 메모 추가, 제거, 비밀 메모, 메모간 순서변경 등등의 기본적인 메모 작업이 가능

- 프리뷰 움짤:




![DeathNotePreview](https://user-images.githubusercontent.com/90740892/175364382-7796adf4-5b30-4571-a206-0e2686e48378.gif)


- 아이콘 이미지![appstore](https://user-images.githubusercontent.com/90740892/178170908-9f2a180b-2203-4960-b641-8c393a5efd44.png)


- 데이터는 UserDefault 를 사용하여 메모의 배열을 Encoding 해서 보관하는 방식

- 폰트가 중요하므로 app 쪽에서 UIKit 의 뷰들을 조금 커스터마이징 해줌.

- MVVM의 형식을 따르지만 구조가 비교적 간단하고 로직도 간단하여 ViewModel 과 View 만으로 처리함
