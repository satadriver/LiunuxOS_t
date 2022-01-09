.386p

Kernel Segment public para use32
assume cs:Kernel


__kDriverProc proc
pushad

;mov dx,3f6h
;in al,dx

jmp _showDriverTips

_driverIntEnd:
mov al,20h
out 20h,al
out 0a0h,al

popad
iretd


_showDriverTips:
mov ebp,esp
add ebp,32
push dword ptr ICW2_SLAVE_INT_NO + 6
push dword ptr 0
push dword ptr [ebp]
push dword ptr [ebp + 4]
push dword ptr [ebp + 8]

test dword ptr [ebp + 4],3
jz _kDriverKernelModeInt
push dword ptr [ebp + 12]
push dword ptr [ebp + 16]
jmp _kDriverShowExpInfo
_kDriverKernelModeInt:
push dword ptr 0
push dword ptr 0
_kDriverShowExpInfo:
call  __exceptionInfo
add esp,28
jmp _driverIntEnd
__kDriverProc endp

Kernel ends
