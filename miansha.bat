tools\grep.exe -rl --exclude-dir .git --exclude-dir tools --exclude-dir .idea --exclude miansha.bat --exclude mimikatz.sln "mimikatz" . | tools\xargs tools\sed -b -i "s/mimikatz/mmk/g"

tools\mv ./mimikatz/mimikatz.h ./mimikatz/mmk.h
tools\mv ./mimikatz/mimikatz.c ./mimikatz/mmk.c
tools\mv ./mimikatz/mimikatz.ico ./mimikatz/mmk.ico
tools\mv ./mimikatz/mimikatz.rc ./mimikatz/mmk.rc
