@echo off
:: ����ַ�
setlocal enabledelayedexpansion

set _out=

rem mimikatz�ļ�����
call :RandomStr 10
tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat "mimikatz" . | tools\xargs tools\sed -b -i "s/mimikatz/!_out!/g"
tools\mv ./mimikatz/mimikatz.h ./mimikatz/!_out!.h
tools\mv ./mimikatz/mimikatz.c ./mimikatz/!_out!.c
tools\mv ./mimikatz/mimikatz.ico ./mimikatz/!_out!.ico
tools\mv ./mimikatz/mimikatz.rc ./mimikatz/!_out!.rc
tools\mv ./mimikatz !_out!

echo ������Ҫ�������ļ���
for %%a in (_m_) do (
    call :RandomStr 10
    tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "%%a" . | tools\xargs tools\sed -b -i "s/%%a/!_out!/g"
    echo,!_out!
    call :FileRen %%a !_out!
)

echo ������Ҫ�������ļ���
for %%a in (gentilkiwi MIMIKATZ KIWI oe.eo Vincent) do (
    call :RandomStr 10
    tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "%%a" . | tools\xargs tools\sed -b -i "s/%%a/!_out!/g"
)



:: =================
:: ��������ַ���
:: =================
::
:RandomStr <int>
    set d_len=%1
    set d_StrList=abcdefghijVESklmnopqrstuvwxyzJKO

    set len=%d_len%
    @rem ���"��С�ַ�����-����ַ�����"
    for /f "tokens=1,2 delims=- " %%a in ("%len%") do (
            set /a min_len = %%a, max_len = %%a+5
            set /a "len = %random% %% (max_len-min_len+1) + min_len"
    )

    @rem ############## ��ȡ�ַ���
    set StrList=%d_StrList%

    @rem ############## �����ַ�������
    call :StrLen "%StrList%"


    set _out=
    for /l %%n in (1 1 %len%) do (
            set /a pos = !random! %% StrLen
            for %%p in (!pos!) do set _out=!_out!!StrList:~%%p,1!
    )
goto:eof

:: =================
:: �����ַ�������
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

:: =================
:: �ļ�/·��������
:: =================
::
:FileRen <string> <string>
    set str_1=%1
    set str_2=%2

    for /f %%i in ('dir /s /b *%str_1%*.c *%str_1%*.h') do (
        set _var=%%i
        if not !_var!.==. (
            set "_var=!_var:%str_1%=%str_2%!"
            tools\mv %%i !_var!
        )
    )
goto:eof