; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-apple-darwin -mattr=+sse2 | FileCheck %s

define void @test_x86_sse_storeu_ps(i8* %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_storeu_ps:
; SSE:       ## %bb.0:
; SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SSE-NEXT:    movups %xmm0, (%eax)
; SSE-NEXT:    retl
;
; KNL-LABEL: test_x86_sse_storeu_ps:
; KNL:       ## %bb.0:
; KNL-NEXT:    movl {{[0-9]+}}(%esp), %eax
; KNL-NEXT:    vmovups %xmm0, (%eax)
; KNL-NEXT:    retl
; CHECK-LABEL: test_x86_sse_storeu_ps:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movups %xmm0, (%eax)
; CHECK-NEXT:    retl
  call void @llvm.x86.sse.storeu.ps(i8* %a0, <4 x float> %a1)
  ret void
}
declare void @llvm.x86.sse.storeu.ps(i8*, <4 x float>) nounwind


define <4 x float> @test_x86_sse_add_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_add_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    addss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x58,0xc1]
; SSE-NEXT:    retl ## encoding: [0xc3]
;
; AVX2-LABEL: test_x86_sse_add_ss:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vaddss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x58,0xc1]
; AVX2-NEXT:    retl ## encoding: [0xc3]
;
; SKX-LABEL: test_x86_sse_add_ss:
; SKX:       ## %bb.0:
; SKX-NEXT:    vaddss %xmm1, %xmm0, %xmm0 ## encoding: [0x62,0xf1,0x7e,0x08,0x58,0xc1]
; SKX-NEXT:    retl ## encoding: [0xc3]
; CHECK-LABEL: test_x86_sse_add_ss:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    addss %xmm1, %xmm0
; CHECK-NEXT:    retl
  %res = call <4 x float> @llvm.x86.sse.add.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.add.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_sub_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_sub_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    subss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x5c,0xc1]
; SSE-NEXT:    retl ## encoding: [0xc3]
;
; AVX2-LABEL: test_x86_sse_sub_ss:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vsubss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x5c,0xc1]
; AVX2-NEXT:    retl ## encoding: [0xc3]
;
; SKX-LABEL: test_x86_sse_sub_ss:
; SKX:       ## %bb.0:
; SKX-NEXT:    vsubss %xmm1, %xmm0, %xmm0 ## encoding: [0x62,0xf1,0x7e,0x08,0x5c,0xc1]
; SKX-NEXT:    retl ## encoding: [0xc3]
; CHECK-LABEL: test_x86_sse_sub_ss:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    subss %xmm1, %xmm0
; CHECK-NEXT:    retl
  %res = call <4 x float> @llvm.x86.sse.sub.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.sub.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_mul_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_mul_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    mulss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x59,0xc1]
; SSE-NEXT:    retl ## encoding: [0xc3]
;
; AVX2-LABEL: test_x86_sse_mul_ss:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vmulss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x59,0xc1]
; AVX2-NEXT:    retl ## encoding: [0xc3]
;
; SKX-LABEL: test_x86_sse_mul_ss:
; SKX:       ## %bb.0:
; SKX-NEXT:    vmulss %xmm1, %xmm0, %xmm0 ## encoding: [0x62,0xf1,0x7e,0x08,0x59,0xc1]
; SKX-NEXT:    retl ## encoding: [0xc3]
; CHECK-LABEL: test_x86_sse_mul_ss:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    mulss %xmm1, %xmm0
; CHECK-NEXT:    retl
  %res = call <4 x float> @llvm.x86.sse.mul.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.mul.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_div_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_div_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    divss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x5e,0xc1]
; SSE-NEXT:    retl ## encoding: [0xc3]
;
; AVX2-LABEL: test_x86_sse_div_ss:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vdivss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x5e,0xc1]
; AVX2-NEXT:    retl ## encoding: [0xc3]
;
; SKX-LABEL: test_x86_sse_div_ss:
; SKX:       ## %bb.0:
; SKX-NEXT:    vdivss %xmm1, %xmm0, %xmm0 ## encoding: [0x62,0xf1,0x7e,0x08,0x5e,0xc1]
; SKX-NEXT:    retl ## encoding: [0xc3]
; CHECK-LABEL: test_x86_sse_div_ss:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    divss %xmm1, %xmm0
; CHECK-NEXT:    retl
  %res = call <4 x float> @llvm.x86.sse.div.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.div.ss(<4 x float>, <4 x float>) nounwind readnone


