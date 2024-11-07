000011ad     push    ebp {__saved_ebp}
000011ae     mov     ebp, esp {__saved_ebp}
000011b0     push    ebx {__saved_ebx}  {_GLOBAL_OFFSET_TABLE_}
000011b1     sub     esp, 0x14
000011b4     call    __x86.get_pc_thunk.bx
000011b9     add     ebx, 0x2e47  {_GLOBAL_OFFSET_TABLE_}
000011bf     sub     esp, 0xc
000011c2     push    dword [ebp+0x8 {arg1}] {var_2c}
000011c5     call    strlen
000011ca     add     esp, 0x10
000011cd     mov     dword [ebp-0xc {var_10}], eax
000011d0     sub     esp, 0xc
000011d3     push    dword [ebp+0xc {arg2}] {var_2c_1}
000011d6     call    strlen
000011db     add     esp, 0x10
000011de     mov     dword [ebp-0x10 {var_14}], eax
000011e1     mov     edx, dword [ebp-0xc {var_10}]
000011e4     mov     eax, dword [ebp-0x10 {var_14}]
000011e7     add     eax, edx
000011e9     add     eax, 0x1
000011ec     sub     esp, 0x8
000011ef     push    eax {var_28}
000011f0     push    dword [ebp+0x8 {arg1}] {var_2c_2}
000011f3     call    realloc
000011f8     add     esp, 0x10
000011fb     mov     dword [ebp+0x8 {arg1}], eax
000011fe     mov     eax, dword [ebp-0x10 {var_14}]
00001201     lea     edx, [eax+0x1]
00001204     mov     ecx, dword [ebp+0x8 {arg1}]
00001207     mov     eax, dword [ebp-0xc {var_10}]
0000120a     add     eax, ecx
0000120c     sub     esp, 0x4
0000120f     push    edx {var_24}
00001210     push    dword [ebp+0xc {arg2}] {var_28_1}
00001213     push    eax {var_2c_3}
00001214     call    memcpy
00001219     add     esp, 0x10
0000121c     mov     eax, dword [ebp+0x8 {arg1}]
0000121f     mov     ebx, dword [ebp-0x4 {__saved_ebx}]  {_GLOBAL_OFFSET_TABLE_}
00001222     leave    {__saved_ebp}
00001223     retn     {__return_addr}
