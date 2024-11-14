## 커밋 규칙

### 브랜치 전략

1. develop 브랜치를 생성하여 개발을 진행한다.

2. 기본적으로 기능 구현이 필요할 경우 develop 브랜치에서 feature 브랜치를 하나 생성해서 기능 구현을 진행한다. (예: feature/login)

3. 기능 구현이 완료된 feature 브랜치는 검토 후 develop 브랜치에 merge한다.

4. 최종 기능 개발 및 테스트가 완료된 이후 master 브랜치에 merge한다.

5. 배포한다.

### 커밋 메세지 작성법

|메세지명|작업 유형|예시|
|:--:|:--:|:--|
|Feat|새 기능 구현|feat: 락커 회원 목록 검색 기능 추가|
|Fix|버그 수정|fix: 상점 목록의 에러처리 예외케이스 대응|
|Docs|문서 관련 작업|docs: 데코레이터 옵션에 대한 문서 추가|
|Refactor|리팩토링|refactor: createStore의 함수를 작은 함수로 분리|
|Test|테스트 관련 작업|test: 상점 생성 테스트 추가|
|Chore|기타 작업|chore: 프로덕션 빌드시 소스맵 생성하도록 변경|

#
#### 🏷️ 작업중인 브랜치가 master인 경우
      > git branch -M main을 실행해 branch의 이름을 master에서 main으로 변경  
      
#### 🏷️ git push를 했는데  ! [rejected]  main -> main (fetch first) 에러 발생한 경우
      >  git pull --rebase origin main으로 로컬과 원격 저장소를 동기화 한 후에 push 진행

- `issue 규칙`
  -참고: <https://velog.io/@junh0328/협업을-위한-깃허브-이슈-작성하기>  
  -레이블 참고: <https://github.com/modolee/github-initial-settings>  
  -제목 참고: <https://doublesprogramming.tistory.com/256>

    - 템플릿
        - issue 제목
            - 예시:[Feat] 이슈 정리
        - issue 템플릿

          `## 🧾이슈 내용 `  
          `## ✅체크리스트`     
          `## 📚레퍼런스`

        - 제목 예시
            - [Add] UI button 구현

- `branch 규칙`
    - 각자의 영어 이름을 딴 branch 명을 사용한다
    - 예시:
      ` git checkout -b <브랜치명>`  
      ` git checkout -b songhyeon`
- `commit message 규칙`
    - 참고 : <https://doublesprogramming.tistory.com/256>
    - [종류] 메시지 - #이슈번호
    - 예시
        - [Feat] todo-list 회원 API 엔티티 구현 - #2
        - [Fix] todo-list 회원 단건 조회 서비스 에러 수정 - #2

    - PR 규칙
        - PR 템플릿
          ` 이슈번호`  
          ` 구현 사항`   
          `기타
