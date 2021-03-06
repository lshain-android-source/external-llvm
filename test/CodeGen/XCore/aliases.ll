; RUN: llc < %s -march=xcore | FileCheck %s
declare void @a_val() nounwind
@b_val = external constant i32, section ".cp.rodata"
@c_val = external global i32

@a = alias void ()* @a_val
@b = alias i32* @b_val
@c = alias i32* @c_val

; CHECK-LABEL: a_addr:
; CHECK: ldap r11, a
; CHECK: retsp
define void ()* @a_addr() nounwind {
entry:
  ret void ()* @a
}

; CHECK-LABEL: b_addr:
; CHECK: ldaw r11, cp[b]
; CHECK: retsp
define i32 *@b_addr() nounwind {
entry:
  ret i32* @b
}

; CHECK-LABEL: c_addr:
; CHECK: ldaw r0, dp[c]
; CHECK: retsp
define i32 *@c_addr() nounwind {
entry:
  ret i32* @c
}
