# RespectZone-iOS
### 리스펙존 - 욕설과 혐오 없는 깨끗한 공간

- 2024-2 Data Analysis Capstone Design | 데이터분석캡스톤디자인 (SWCON321)
- 2024 SW중심대학 연합 SW Festival | Big data & AI 출품작

## 팀원
| [유혜지](https://github.com/HyejiYu) | [김건형](https://github.com/g-hyeong) | [이민재](https://github.com/mini-min) | 
| :--: | :--: | :--: | 
|  Team Leader, Data Engineer | Server Developer | iOS Developer |
| <img width="300" alt="혜지" src="https://github.com/user-attachments/assets/74055c1f-566c-416f-a566-9f79679f49d4"> | <img width="300" alt="건형" src="https://github.com/user-attachments/assets/a8d54a85-2ab7-4b74-a470-c37d8762e918"> | <img width="300" alt="민재" src="https://github.com/user-attachments/assets/7a5d7f57-68d6-4cee-97a8-160d8ddb2371"> | 

<br>

## 1. 프로젝트 배경 및 아이디어 정의
### 1-1. 프로젝트 배경
> 전 연령층에 걸쳐 나타나는 욕설, 비속어 사용 문제

비속어 사용 문제는 전 연령대에 걸쳐 일상 대화와 온라인 상에서 늘어나고 있으며, 이는 부적절한 사용이나 관계를 악화시키는 경우도 많아 사회적 문제로 자리잡고 있다. 
이에 국립국어원은 “온라인 소통이 일상화된 상황에서 욕설과 비속어가 쉽게 전파되고, 일상적으로 이런 말들을 접하게 되면서 문제의식 없이 습관적으로 욕설과 비속어를 사용하는 사람이 늘고 있는 것으로 분석된다”고 설명한다.

위 상황에 더해 주목해야 할 점은, 이런 잘못된 언어 사용이 특정한 의미를 지니거나, 자신의 기분과 뜻을 표현하는 경향보다 “그냥 습관적으로” “잘못된 것임을 알고 있음에도 친근함의 표현으로” 사용하는 경우가 높아지고 있다는 점이다.

단순히 비속어나 욕설의 사용은 말하는 사람의 정서나 건강에도 악영향을 유발하기도 하지만,  
그것을 넘어서 해당 언어를 듣는 사람 + 그리고 직접적으로 듣지 않더라도 간간히 듣게 되는 제 3자의 입장에서 더 문제가 될 수 있다는 점에서  
우리는 “무의식적” 혹은 “습관적”으로 사용하는 잘못된 언어 사용이 만연한 현재의 환경을 개선할 필요가 있다고 생각해 해당 프로젝트를 시작하게 되었다.

- [국민 절반 일상서 욕설·비속어 사용](https://www.ksilbo.co.kr/news/articleView.html?idxno=790785)
- [청소년 25% "비속어, 나쁜 것 알지만 습관적으로 사용"](https://www.datasom.co.kr/news/articleView.html?idxno=118477)
- [욕 사용이 건강에 치명적일 수 있다?! 오 박사가 말하는 ＂욕이 위험한 이유＂♨ | 오은영의 금쪽 상담소 76 회](https://www.youtube.com/watch?v=AjPrpku-7U0)
- [[무한도전] 🚫삐--삐--삐--🚫 아무렇지 않게 뱉어보는 비속어 PARTY,,★ 멤버들의 찐 일상을 파헤져보자! 한글날 특집!](https://www.youtube.com/watch?v=oxjMVjFrPrI&t=93s)



### 1-2. 아이디어 정의
> 일상 속에서 자신도 모르게 사용하는 “잘못된 언어 사용 습관”을 알려주고, 이를 개선할 수 있도록 유도해주자!
- “바른 언어 사용”이 필요한 공간에 스피커를 배치함으로, 해당 공간이 “Respect Zone”으로 형성되도록 함
- 아이 목소리와 이모지로 무의식적인 보호 본능을 이끌어내 일상 대화 속 욕설 및 혐오 등 표현 문제를 부드럽게 피드백
- “바른 언어 사용”이 필요한 공간의 개념을 교실, 카페, PC방, 아기를 키우는 집 등 다양하게 확장해 다양한 공간에서 서비스가 적용되도록 함

<br>

## 2. 아키텍처
![Frame 5](https://github.com/user-attachments/assets/674f1e84-93b6-4927-91e5-b9980373d2e5)

- `Speaker - Application` : 블루투스 연결을 통해 스피커의 입력 및 출력 장치를 사용하여 음성 데이터를 송수신합니다.
- `Application - Spring Boot` : 애플리케이션에서 처리한 실시간 문장 변환(Speech-To-Text) 결과를 Spring Boot 서버로 전송합니다
- `Spring Boot - Kafka` : Spring Boot는 분석된 문장 데이터를 Kafka 메시지 큐로 보내어 분류된 결과를 전송합니다.
- `Kafka - Model` : Kafka를 통해 분류된 데이터가 모델로 전달되어 텍스트를 text.all, text.abuse, text.clean 카테고리로 처리합니다.
  
<br>

## 3. 시연 설명
### 3-1. 화면 구성
| Main Scene | Detail Scene | Recording Scene (Clean) | Recording Scene (Detect) | 
| :--: | :--: | :--: | :--: | 
| 녹음 목록 조회, 삭제 | 세부 정보 (클린 스코어, 문장 횟수, 문장 분류 결과) 조회 | STT (Speech) 문장 변환 | STT 문장 변환, 문장 분류 결과 라벨링, 피드백 제공 |
| <img width="220" alt="Simulator Screen Recording - iPhone 16 Pro Max - 2024-12-18 at 21 38 16" src="https://github.com/user-attachments/assets/03973294-9c04-4a94-981b-f24d35b17774"> | <img width="220" alt="Simulator Screen Recording - iPhone 16 Pro Max - 2024-12-18 at 21 41 31" src="https://github.com/user-attachments/assets/a8697709-d770-4089-9ee5-af03165eb609"> | <img width="220" alt="Simulator Screen Recording - iPhone 16 Pro Max - 2024-12-18 at 21 34 30" src="https://github.com/user-attachments/assets/6ae6ec4e-dd88-4fa5-8d8a-bf6c56b350cd"> | <img width="220" alt="Simulator Screen Recording - iPhone 16 Pro Max - 2024-12-18 at 21 37 42" src="https://github.com/user-attachments/assets/fa331e61-7c3d-4b8d-9326-270f4305caa1"> | 


### 3-2. 나쁜 말 횟수에 따른 화면 변화
| Level 0 | Level 1 | Level 2 | Level 3 | Level 4 | Level 5 |
| :--: | :--: | :--: | :--: | :--: | :--: | 
| ![스크린샷 2024-12-18 오후 9 49 04 1](https://github.com/user-attachments/assets/430aa9c2-a51e-4da2-97bb-9f689c80cea2) | ![스크린샷 2024-12-18 오후 9 50 38 1](https://github.com/user-attachments/assets/3e4f76b8-0f59-4499-bfe3-d26648c81538) | ![스크린샷 2024-12-18 오후 9 51 38 1](https://github.com/user-attachments/assets/25402833-ed29-4cff-8184-8f2b22bc2fc5) | ![스크린샷 2024-12-18 오후 9 52 38 1](https://github.com/user-attachments/assets/9208c95c-518f-41eb-9e92-e219629e50dd) | ![스크린샷 2024-12-18 오후 9 53 32 1](https://github.com/user-attachments/assets/4254b4f4-4367-4ad1-926e-d9f32654ae5c) | ![스크린샷 2024-12-18 오후 9 54 26 1](https://github.com/user-attachments/assets/e4410e30-0084-4557-94da-450991ca6019) |

### 3-3. 피드백 음성
- 📢 Level 0 : “따뜻한 표현을 사용해주세요"
- 📢 Level 1 : “그 말을 들으니까 마음이 아파요”
- 📢 Level 2 : “나쁜 문장을 들으니 조금 속상해요”
- 📢 Level 3 : “오늘 들은 문장때문에 상처받았어요”
- 📢 Level 4 : “분위기를 정화해야겠어요" -> (리프레시 음악 - 스딸라) -> “이곳은 욕설과 혐오 없는 깨끗한 공간이에요. 우리 함께 리스펙존을 만들어가요”

<br>

## 4. 기대 효과
> 올바른 언어 사용을 통한 긍정적 환경 조성

블루투스 스피커와 해당 애플리케이션이 배치된 공간에서 비속어, 욕설, 부정적 표현 등이 줄어들고, 대화의 질이 개선될 것으로 기대됩니다.   
특히, 이는 공간의 특징에 따라 여러 효과로 나뉘어질 것으로 본 연구자들이 기대하는데, 예를 들어, 회의실에서는 생산적이고 건설적인 논의 분위기가 조성되며, 교실에서는 청소년들이 올바른 언어 습관을 자연스럽게 형성할 수 있는 방향, 카페와 같은 공공장소에서는 고객과 직원 간의 상호 존중 문화가 강화되고 주변 손님을 배려하는 올바른 언어 습관이 강화되는 데 사용 가능할 것입니다.


> 언어 사용에 대한 실시간 피드백 제공

문장 분석 모델은 사용자의 언어를 실시간으로 분석하여 피드백을 제공할 수 있습니다.   
이로 인해 현재의 공간 관리자의 개념은 사용자의 개념으로 확장될 수 있을 것입니다.   
스스로의 언어 습관을 점검하고 개선하고, 장기적으로는 이 사회에 건강한 언어사용 문화를 정착시킬 수 있을 것입니다.


> 사회적 문제 해결에 기여

청소년 언어 습관 문제, 공공장소에서의 언어 폭력 등 언어와 관련된 사회적 문제를 예방할 수 있을 것입니다.   
특히, 아이를 키우는 가정에서는 부모의 언어 습관 변화가 자녀의 언어 발달에 긍정적 영향을 미칠 수 있을 것으로 기대되며, 이는 궁극적으로 다음 세대의 언어 문화 개선으로 이어질 것입니다.


> 데이터 기반의 언어 문화 연구 지원

본 서비스는 사용자의 언어 데이터를 익명으로 분석함으로써, 특정 공간이나 환경에서의 언어 사용 패턴을 연구하는 데 기여할 수 있습니다.   
이를 통해 사회학, 교육학, 심리학 등 다양한 학문적 영역에서의 언어와 관련된 연구를 지원하며, 더 나아가 정책 수립과 캠페인에도 긍정적이고 보다 친숙하게 다가갈 수 있을 것으로 기대할 수 있습니다.
