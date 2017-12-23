; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX

; TODO - shuffle+sext are superfluous
define <2 x i64> @combine_shuffle_sext_pmuldq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_shuffle_sext_pmuldq:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE-NEXT:    pmovsxdq %xmm0, %xmm2
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[0,2,2,3]
; SSE-NEXT:    pmovsxdq %xmm0, %xmm0
; SSE-NEXT:    pmuldq %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_sext_pmuldq:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; AVX-NEXT:    vpmovsxdq %xmm0, %xmm0
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; AVX-NEXT:    vpmovsxdq %xmm1, %xmm1
; AVX-NEXT:    vpmuldq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shufflevector <4 x i32> %a0, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %2 = shufflevector <4 x i32> %a1, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %3 = sext <2 x i32> %1 to <2 x i64>
  %4 = sext <2 x i32> %2 to <2 x i64>
  %5 = mul nuw <2 x i64> %3, %4
  ret <2 x i64> %5
}

; TODO - shuffle+zext are superfluous
define <2 x i64> @combine_shuffle_zext_pmuludq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_shuffle_zext_pmuludq:
; SSE:       # %bb.0:
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE-NEXT:    pmovzxdq {{.*#+}} xmm2 = xmm0[0],zero,xmm0[1],zero
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[0,2,2,3]
; SSE-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE-NEXT:    pmuludq %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_zext_pmuludq:
; AVX:       # %bb.0:
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shufflevector <4 x i32> %a0, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %2 = shufflevector <4 x i32> %a1, <4 x i32> undef, <2 x i32> <i32 0, i32 2>
  %3 = zext <2 x i32> %1 to <2 x i64>
  %4 = zext <2 x i32> %2 to <2 x i64>
  %5 = mul nuw <2 x i64> %3, %4
  ret <2 x i64> %5
}

; TODO - blends are superfluous
define <2 x i64> @combine_shuffle_zero_pmuludq(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_shuffle_zero_pmuludq:
; SSE:       # %bb.0:
; SSE-NEXT:    pxor %xmm2, %xmm2
; SSE-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; SSE-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; SSE-NEXT:    pmuludq %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_zero_pmuludq:
; AVX:       # %bb.0:
; AVX-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX-NEXT:    vpblendd {{.*#+}} xmm0 = xmm0[0],xmm2[1],xmm0[2],xmm2[3]
; AVX-NEXT:    vpblendd {{.*#+}} xmm1 = xmm1[0],xmm2[1],xmm1[2],xmm2[3]
; AVX-NEXT:    vpmuludq %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shufflevector <4 x i32> %a0, <4 x i32> zeroinitializer, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  %2 = shufflevector <4 x i32> %a1, <4 x i32> zeroinitializer, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  %3 = bitcast <4 x i32> %1 to <2 x i64>
  %4 = bitcast <4 x i32> %2 to <2 x i64>
  %5 = mul <2 x i64> %3, %4
  ret <2 x i64> %5
}

; TODO - blends are superfluous
define <4 x i64> @combine_shuffle_zero_pmuludq_256(<8 x i32> %a0, <8 x i32> %a1) {
; SSE-LABEL: combine_shuffle_zero_pmuludq_256:
; SSE:       # %bb.0:
; SSE-NEXT:    pxor %xmm4, %xmm4
; SSE-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1],xmm4[2,3],xmm1[4,5],xmm4[6,7]
; SSE-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm4[2,3],xmm0[4,5],xmm4[6,7]
; SSE-NEXT:    pblendw {{.*#+}} xmm3 = xmm3[0,1],xmm4[2,3],xmm3[4,5],xmm4[6,7]
; SSE-NEXT:    pmuludq %xmm3, %xmm1
; SSE-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1],xmm4[2,3],xmm2[4,5],xmm4[6,7]
; SSE-NEXT:    pmuludq %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_shuffle_zero_pmuludq_256:
; AVX:       # %bb.0:
; AVX-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0],ymm2[1],ymm0[2],ymm2[3],ymm0[4],ymm2[5],ymm0[6],ymm2[7]
; AVX-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0],ymm2[1],ymm1[2],ymm2[3],ymm1[4],ymm2[5],ymm1[6],ymm2[7]
; AVX-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %1 = shufflevector <8 x i32> %a0, <8 x i32> zeroinitializer, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  %2 = shufflevector <8 x i32> %a1, <8 x i32> zeroinitializer, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  %3 = bitcast <8 x i32> %1 to <4 x i64>
  %4 = bitcast <8 x i32> %2 to <4 x i64>
  %5 = mul <4 x i64> %3, %4
  ret <4 x i64> %5
}
