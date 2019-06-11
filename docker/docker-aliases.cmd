@ECHO OFF

@REM Get latest container ID
DOSKEY dl=docker ps -l -q $*

@REM Get container process
DOSKEY dps=docker ps $*

@REM Get process included stop container
DOSKEY dpa=docker ps -a $*

@REM Get already stopped container
DOSKEY dpe=docker ps -f status=exited $*

@REM Get images
DOSKEY di=docker images $*

@REM Get container IP
DOSKEY dip=docker inspect --format "{{ .NetworkSettings.IPAddress }}" $*

@REM Run deamonized container, e.g., $dkd base /bin/echo hello
DOSKEY dkd=docker run -d -P $*
DOSKEY dpkd="%~f0" DOCKER_PROXY_DAEMON $*

@REM Run interactive container, e.g., $dki base /bin/bash
DOSKEY dki=docker run -i -t -P $*
DOSKEY didki=docker run -i -t -P -v /var/run/docker.sock:/var/run/docker.sock $*
DOSKEY dpki="%~f0" DOCKER_PROXY_INTERACTIVE $*
DOSKEY didpki="%~f0" DOCKER_IN_DOCKER_PROXY_INTERACTIVE $*

@REM Execute interactive container, e.g., $dex base /bin/bash
DOSKEY dex=docker exec -it $*

@REM Stop all containers
DOSKEY dstop=FOR /F "USEBACKQ TOKENS=*" %%A IN (`docker ps -a -q`) DO docker stop %%A

@REM Remove stopped containers
DOSKEY drm=FOR /F "USEBACKQ TOKENS=*" %%A IN (`docker ps -f status^^=exited -a -q`) DO docker rm %%A

@REM Build images under current directory
DOSKEY dbu=docker build -t=$1 .
DOSKEY dpbu="%~f0" DOCKER_PROXY_BUILD $*

@REM Docker4w utils
DOSKEY nsenter=docker run --rm -it --privileged --pid=host docker4w/nsenter-dockerd
DOSKEY ctop=docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
DOSKEY lquery=notary -s https://notary.docker.io list docker.io/library/$1

@REM Kubernetes utils
DOSKEY kga=kubectl get all --all-namespaces $*
DOSKEY kshell="%~f0" K8S_JOB_SHELL $*
DOSKEY kjob="%~f0" K8S_RESTART_JOB $*

@REM DOSKEY extended functions entrance...
IF NOT [%1]==[] (
  findstr /i /r /c:"^[ ]*:%~1\>" "%~f0" >nul && CALL :%*
)
GOTO :eof

@REM Functions implementations...
:DOCKER_PROXY_DAEMON
  SETLOCAL enabledelayedexpansion
    SET "CMDLINE=docker run -d -P"
    IF ["%http_proxy%"]==[""] (
      ECHO http_proxy is NOT set...
      GOTO :eof
    ) ELSE (
      SET "CMDLINE=!CMDLINE! -e http_proxy=%http_proxy%"
      IF NOT ["%https_proxy%"]==[""] SET "CMDLINE=!CMDLINE! -e https_proxy=%https_proxy%"
      IF NOT ["%no_proxy%"]==[""] SET "CMDLINE=!CMDLINE! -e no_proxy=%no_proxy%"
    )

    %CMDLINE% %*
  ENDLOCAL
GOTO :eof

:DOCKER_PROXY_INTERACTIVE
  SETLOCAL enabledelayedexpansion
    SET "CMDLINE=docker run -i -t -P"
    IF ["%http_proxy%"]==[""] (
      ECHO http_proxy is NOT set...
      GOTO :eof
    ) ELSE (
      SET "CMDLINE=!CMDLINE! -e http_proxy=%http_proxy%"
      IF NOT ["%https_proxy%"]==[""] SET "CMDLINE=!CMDLINE! -e https_proxy=%https_proxy%"
      IF NOT ["%no_proxy%"]==[""] SET "CMDLINE=!CMDLINE! -e no_proxy=%no_proxy%"
    )

    %CMDLINE% %*
  ENDLOCAL
GOTO :eof

:DOCKER_IN_DOCKER_PROXY_INTERACTIVE
  SETLOCAL enabledelayedexpansion
    SET "CMDLINE=docker run -i -t -P -v /var/run/docker.sock:/var/run/docker.sock"
    IF ["%http_proxy%"]==[""] (
      ECHO http_proxy is NOT set...
      GOTO :eof
    ) ELSE (
      SET "CMDLINE=!CMDLINE! -e http_proxy=%http_proxy%"
      IF NOT ["%https_proxy%"]==[""] SET "CMDLINE=!CMDLINE! -e https_proxy=%https_proxy%"
      IF NOT ["%no_proxy%"]==[""] SET "CMDLINE=!CMDLINE! -e no_proxy=%no_proxy%"
    )

    %CMDLINE% %*
  ENDLOCAL
GOTO :eof

:DOCKER_PROXY_BUILD
  SETLOCAL enabledelayedexpansion
    SET "CMDLINE=docker build"
    IF ["%http_proxy%"]==[""] (
      ECHO http_proxy is NOT set...
      GOTO :eof
    ) ELSE (
      SET "CMDLINE=!CMDLINE! --build-arg http_proxy=%http_proxy%"
      IF NOT ["%https_proxy%"]==[""] SET "CMDLINE=!CMDLINE! --build-arg https_proxy=%https_proxy%"
      IF NOT ["%no_proxy%"]==[""] SET "CMDLINE=!CMDLINE! --build-arg no_proxy=%no_proxy%"
    )

    IF NOT [%1]==[] (
      SET "ARGS=%1"
      IF "!ARGS:~0,1!"=="-" (
        SET "CMDLINE=!CMDLINE! %*"
      ) ELSE (
        SET "CMDLINE=!CMDLINE! -t !ARGS! ."
      )
    )

    %CMDLINE%
  ENDLOCAL
GOTO :eof

:K8S_JOB_SHELL
  SETLOCAL enabledelayedexpansion
    SET "CMDLINE=kubectl run -it --rm --restart=Never --image-pull-policy=IfNotPresent k8s-job-shell --command=true"
    IF NOT ["%http_proxy%"]==[""] SET "CMDLINE=!CMDLINE! --env=^"http_proxy=%http_proxy: =%^""
    IF NOT ["%https_proxy%"]==[""] SET "CMDLINE=!CMDLINE! --env=^"https_proxy=%https_proxy: =%^""
    IF NOT ["%no_proxy%"]==[""] SET "CMDLINE=!CMDLINE! --env=^"no_proxy=%no_proxy: =%^""

    IF [%1]==[] (
      SET "CMDLINE=!CMDLINE! -n default --image=alpine -- /bin/sh"
    ) ELSE (
      IF [%2]==[] (
        SET "CMDLINE=!CMDLINE! -n %~1 --image=alpine -- /bin/sh"
      ) ELSE (
        IF [%3]==[] (
          SET "CMDLINE=!CMDLINE! -n %~1 --image=%~2 -- /bin/sh"
        ) ELSE (
          SET "CMDLINE=!CMDLINE! -n %~1 --image=%~2 -- %~3"
        )
      )
    )

    %CMDLINE%
  ENDLOCAL
GOTO :eof

:K8S_RESTART_JOB
  SETLOCAL enabledelayedexpansion
    IF [%1]==[] GOTO :KJOB_PROMPT
    IF [%2]==[] GOTO :KJOB_PROMPT
    IF NOT [%3]==[] GOTO :KJOB_PROMPT

    SET "CMDLINE=kubectl get job/%2 -n %1 -ojson"
    SET "CMDLINE=!CMDLINE! | jq -r '.metadata.annotations.^"kubectl.kubernetes.io/last-applied-configuration^"'"
    SET "CMDLINE=!CMDLINE! | kubectl replace --save-config --force -f -"

    %CMDLINE%
    GOTO :eof

    @REM Usage prompt
:KJOB_PROMPT
    ECHO usage: kjob ^<namespace^> ^<jobname^>
  ENDLOCAL
GOTO :eof

