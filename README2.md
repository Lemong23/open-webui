# HOW TO USE

env를 참조하는 형태로 run.sh 변경하여 설치 및 사용법을 남깁니다. 
Ollama 까지 PC에 설치시 docker-compose 가 편할수 있습니다. (아래 버전은 Ollama 설치 제외, OPENAI 연동 기준)

설치 전 필수 사항 도커 실행 

1. Pull web-ui Image & alias

```zsh
  docker pull ghcr.io/open-webui/open-webui:main && docker tag ghcr.io/open-webui/open-webui:main open-webui:latest
```

2. .env.sample 를 참조해서, .env 작성 (최소 OPENAI 설정 필요)

3. Act run shell script

```zsh
  sh ./run.sh
```


## HOW TO USE DEV

[dev mode](https://docs.openwebui.com/getting-started/advanced-topics/development/)

DEV 모드 사용전 설치 필요 사항

- [anaconda](https://www.anaconda.com/download)
- [nodejs](https://nodejs.org/ko/download)


Backend Setup

```
cd backend
```

최초 conda 활용시 등록

```
conda create --name open-webui python=3.11 
```

```
conda activate open-webui
```

```
pip install -r requirements.txt -U
```

```
sh dev.sh
```


Frontend Setup

```
cp -RPp .env.example .env
```

```
npm install
```

```
npm run dev
```
