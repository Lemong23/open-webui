# HOW TO USE

env를 참조하는 형태로 run.sh 변경하여 설치 및 사용법을 남깁니다.  

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