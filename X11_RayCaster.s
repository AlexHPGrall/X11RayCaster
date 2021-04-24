	.file	"X11_RayCaster.c"
	.text
	.data
	.align 4
	.type	width, @object
	.size	width, 4
width:
	.long	1280
	.align 4
	.type	height, @object
	.size	height, 4
height:
	.long	720
	.text
	.type	FillBuffer, @function
FillBuffer:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, %rcx
	movq	%rsi, %rax
	movq	%rax, %rbx
	movq	%rcx, -48(%rbp)
	movq	%rbx, -40(%rbp)
	movl	%edx, -52(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L2
.L3:
	movq	-24(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movl	-52(%rbp), %edx
	movl	%edx, (%rax)
	addl	$1, -28(%rbp)
.L2:
	movl	-48(%rbp), %edx
	movl	-44(%rbp), %eax
	imull	%edx, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L3
	nop
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	FillBuffer, .-FillBuffer
	.type	DrawPixel, @function
DrawPixel:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movq	%rcx, %rax
	movq	%r8, %rcx
	movq	%rcx, %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movl	-32(%rbp), %eax
	imull	-8(%rbp), %eax
	movslq	%eax, %rcx
	movl	-4(%rbp), %eax
	cltq
	addq	%rcx, %rax
	salq	$2, %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	movl	%eax, (%rdx)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	DrawPixel, .-DrawPixel
	.type	BresenLine, @function
BresenLine:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	movl	%edx, -60(%rbp)
	movl	%ecx, -64(%rbp)
	movl	%r8d, -68(%rbp)
	movl	$0, -4(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-60(%rbp), %eax
	subl	-52(%rbp), %eax
	cltd
	xorl	%edx, %eax
	movl	%eax, -16(%rbp)
	subl	%edx, -16(%rbp)
	movl	-64(%rbp), %eax
	subl	-56(%rbp), %eax
	cltd
	xorl	%edx, %eax
	movl	%eax, -20(%rbp)
	subl	%edx, -20(%rbp)
	movl	-60(%rbp), %eax
	subl	-52(%rbp), %eax
	testl	%eax, %eax
	jns	.L6
	movl	$-1, %eax
	jmp	.L7
.L6:
	movl	$1, %eax
.L7:
	movl	%eax, -32(%rbp)
	movl	-64(%rbp), %eax
	subl	-56(%rbp), %eax
	testl	%eax, %eax
	jns	.L8
	movl	$-1, %eax
	jmp	.L9
.L8:
	movl	$1, %eax
.L9:
	movl	%eax, -36(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.L10
	movl	-20(%rbp), %eax
	addl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	%eax, -16(%rbp)
	movl	$1, -4(%rbp)
.L10:
	movl	-20(%rbp), %eax
	addl	%eax, %eax
	subl	-16(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -24(%rbp)
	movl	$1, -28(%rbp)
	jmp	.L11
.L18:
	movq	16(%rbp), %rcx
	movq	24(%rbp), %rdi
	movl	-68(%rbp), %edx
	movl	-12(%rbp), %esi
	movl	-8(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	DrawPixel
	jmp	.L12
.L15:
	cmpl	$0, -4(%rbp)
	je	.L13
	movl	-32(%rbp), %eax
	addl	%eax, -8(%rbp)
	jmp	.L14
.L13:
	movl	-36(%rbp), %eax
	addl	%eax, -12(%rbp)
.L14:
	movl	-16(%rbp), %eax
	addl	%eax, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	-24(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
.L12:
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jnb	.L15
	cmpl	$0, -4(%rbp)
	je	.L16
	movl	-36(%rbp), %eax
	addl	%eax, -12(%rbp)
	jmp	.L17
.L16:
	movl	-32(%rbp), %eax
	addl	%eax, -8(%rbp)
.L17:
	movl	-20(%rbp), %eax
	addl	%eax, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	-24(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
	addl	$1, -28(%rbp)
.L11:
	movl	-28(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.L18
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	BresenLine, .-BresenLine
	.type	DrawLine, @function
DrawLine:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %edi
	movl	-16(%rbp), %ecx
	movl	-12(%rbp), %edx
	movl	-8(%rbp), %esi
	movl	-4(%rbp), %eax
	pushq	24(%rbp)
	pushq	16(%rbp)
	movl	%edi, %r8d
	movl	%eax, %edi
	call	BresenLine
	addq	$16, %rsp
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	DrawLine, .-DrawLine
	.type	DrawQuad, @function
DrawQuad:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movq	%rcx, %rax
	movq	%r8, %rcx
	movq	%rcx, %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L21
.L22:
	movl	-4(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %ecx
	movl	-4(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rsi
	movq	-32(%rbp), %rax
	addq	%rsi, %rax
	movl	(%rax), %esi
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdi
	movq	-24(%rbp), %rax
	addq	%rdi, %rax
	movl	(%rax), %eax
	movl	-36(%rbp), %edi
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	movl	%edi, %r8d
	movl	%eax, %edi
	call	DrawLine
	addq	$16, %rsp
	addl	$1, -4(%rbp)
.L21:
	cmpl	$3, -4(%rbp)
	jle	.L22
	movq	-32(%rbp), %rax
	movl	(%rax), %ecx
	movq	-24(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	addq	$12, %rax
	movl	(%rax), %esi
	movq	-24(%rbp), %rax
	addq	$12, %rax
	movl	(%rax), %eax
	movl	-36(%rbp), %edi
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	movl	%edi, %r8d
	movl	%eax, %edi
	call	DrawLine
	addq	$16, %rsp
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	DrawQuad, .-DrawQuad
	.type	FillRect, @function
FillRect:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	%ecx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L24
.L27:
	movl	-20(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L25
.L26:
	movq	16(%rbp), %rcx
	movq	24(%rbp), %rdi
	movl	-36(%rbp), %edx
	movl	-4(%rbp), %esi
	movl	-8(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	DrawPixel
	addl	$1, -8(%rbp)
.L25:
	movl	-20(%rbp), %edx
	movl	-28(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L26
	addl	$1, -4(%rbp)
.L24:
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L27
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	FillRect, .-FillRect
	.globl	gameMap
	.data
	.align 32
	.type	gameMap, @object
	.size	gameMap, 72
gameMap:
	.long	8
	.long	8
	.string	"\001\001\001\001\001\001\001\001\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	"\001"
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	""
	.string	"\001"
	.string	"\001\001"
	.string	"\001"
	.string	""
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.ascii	"\001\001\001\001\001\001\001\001\001"
	.globl	CellSize
	.align 4
	.type	CellSize, @object
	.size	CellSize, 4
CellSize:
	.long	20
	.section	.rodata
.LC1:
	.string	"ok\n"
	.text
	.type	DrawMap, @function
DrawMap:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, %rax
	movq	%rsi, %rcx
	movq	%rcx, %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movl	20(%rbp), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -12(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movl	16(%rbp), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -16(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L29
.L33:
	movl	$0, -8(%rbp)
	jmp	.L30
.L32:
	movl	20(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	movzbl	24(%rbp,%rax), %eax
	testb	%al, %al
	je	.L31
	movq	stdout(%rip), %rax
	movq	%rax, %rcx
	movl	$3, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	movl	CellSize(%rip), %edx
	movl	CellSize(%rip), %eax
	movl	CellSize(%rip), %ecx
	movl	%ecx, %esi
	imull	-4(%rbp), %esi
	movl	-16(%rbp), %ecx
	addl	%ecx, %esi
	movl	CellSize(%rip), %ecx
	movl	%ecx, %edi
	imull	-8(%rbp), %edi
	movl	-12(%rbp), %ecx
	addl	%ecx, %edi
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	movl	$0, %r8d
	movl	%edx, %ecx
	movl	%eax, %edx
	call	FillRect
	addq	$16, %rsp
.L31:
	addl	$1, -8(%rbp)
.L30:
	movl	20(%rbp), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L32
	addl	$1, -4(%rbp)
.L29:
	movl	16(%rbp), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L33
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	DrawMap, .-DrawMap
	.type	DrawPlayer, @function
DrawPlayer:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, %rax
	movq	%rsi, %rcx
	movq	%rcx, %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movl	16(%rbp), %eax
	movd	%eax, %xmm0
	call	roundf
	cvttss2sil	%xmm0, %eax
	movl	%eax, -20(%rbp)
	movl	20(%rbp), %eax
	movd	%eax, %xmm0
	call	roundf
	cvttss2sil	%xmm0, %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	leal	-5(%rax), %esi
	movl	-20(%rbp), %eax
	subl	$5, %eax
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	movl	$16116034, %r8d
	movl	$11, %ecx
	movl	$11, %edx
	movl	%eax, %edi
	call	FillRect
	addq	$16, %rsp
	movl	24(%rbp), %eax
	movd	%eax, %xmm0
	call	sinf
	movss	.LC2(%rip), %xmm1
	mulss	%xmm0, %xmm1
	movss	20(%rbp), %xmm0
	addss	%xmm0, %xmm1
	movd	%xmm1, %eax
	movd	%eax, %xmm0
	call	roundf
	cvttss2sil	%xmm0, %ebx
	movl	24(%rbp), %eax
	movd	%eax, %xmm0
	call	cosf
	movss	.LC2(%rip), %xmm1
	mulss	%xmm0, %xmm1
	movss	16(%rbp), %xmm0
	addss	%xmm0, %xmm1
	movd	%xmm1, %eax
	movd	%eax, %xmm0
	call	roundf
	cvttss2sil	%xmm0, %edx
	movl	-24(%rbp), %esi
	movl	-20(%rbp), %eax
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	movl	$16073282, %r8d
	movl	%ebx, %ecx
	movl	%eax, %edi
	call	BresenLine
	addq	$16, %rsp
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	DrawPlayer, .-DrawPlayer
	.type	GameUpdate, @function
GameUpdate:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, %rcx
	movq	%rsi, %rax
	movq	%rax, %rbx
	movq	%rcx, -32(%rbp)
	movq	%rbx, -24(%rbp)
	movq	%rdx, -40(%rbp)
	movss	%xmm0, -44(%rbp)
	movl	32(%rbp), %eax
	testl	%eax, %eax
	je	.L36
	movq	-40(%rbp), %rax
	movss	8(%rax), %xmm1
	movq	-40(%rbp), %rax
	movss	16(%rax), %xmm0
	mulss	-44(%rbp), %xmm0
	addss	%xmm1, %xmm0
	movq	-40(%rbp), %rax
	movss	%xmm0, 8(%rax)
	jmp	.L37
.L36:
	movl	36(%rbp), %eax
	testl	%eax, %eax
	je	.L37
	movq	-40(%rbp), %rax
	movss	8(%rax), %xmm0
	movq	-40(%rbp), %rax
	movss	16(%rax), %xmm1
	mulss	-44(%rbp), %xmm1
	subss	%xmm1, %xmm0
	movq	-40(%rbp), %rax
	movss	%xmm0, 8(%rax)
.L37:
	movl	16(%rbp), %eax
	testl	%eax, %eax
	je	.L38
	movq	-40(%rbp), %rax
	movss	(%rax), %xmm6
	movss	%xmm6, -48(%rbp)
	movq	-40(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-44(%rbp), %xmm0
	movss	%xmm0, -52(%rbp)
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	cosf
	mulss	-52(%rbp), %xmm0
	addss	-48(%rbp), %xmm0
	movq	-40(%rbp), %rax
	movss	%xmm0, (%rax)
	movq	-40(%rbp), %rax
	movss	4(%rax), %xmm7
	movss	%xmm7, -48(%rbp)
	movq	-40(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-44(%rbp), %xmm0
	movss	%xmm0, -52(%rbp)
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	sinf
	mulss	-52(%rbp), %xmm0
	addss	-48(%rbp), %xmm0
	movq	-40(%rbp), %rax
	movss	%xmm0, 4(%rax)
	jmp	.L39
.L38:
	movl	24(%rbp), %eax
	testl	%eax, %eax
	je	.L39
	movq	-40(%rbp), %rax
	movss	(%rax), %xmm4
	movss	%xmm4, -48(%rbp)
	movq	-40(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-44(%rbp), %xmm0
	movss	%xmm0, -52(%rbp)
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	cosf
	movss	-52(%rbp), %xmm1
	mulss	%xmm0, %xmm1
	movss	-48(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movq	-40(%rbp), %rax
	movss	%xmm0, (%rax)
	movq	-40(%rbp), %rax
	movss	4(%rax), %xmm5
	movss	%xmm5, -48(%rbp)
	movq	-40(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-44(%rbp), %xmm0
	movss	%xmm0, -52(%rbp)
	movq	-40(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	sinf
	movss	-52(%rbp), %xmm1
	mulss	%xmm0, %xmm1
	movss	-48(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movq	-40(%rbp), %rax
	movss	%xmm0, 4(%rax)
.L39:
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movl	$3355443, %edx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	call	FillBuffer
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	subq	$8, %rsp
	pushq	gameMap+64(%rip)
	pushq	gameMap+56(%rip)
	pushq	gameMap+48(%rip)
	pushq	gameMap+40(%rip)
	pushq	gameMap+32(%rip)
	pushq	gameMap+24(%rip)
	pushq	gameMap+16(%rip)
	pushq	gameMap+8(%rip)
	pushq	gameMap(%rip)
	movq	%rdx, %rdi
	movq	%rax, %rsi
	call	DrawMap
	addq	$80, %rsp
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %r8
	subq	$8, %rsp
	movq	-40(%rbp), %rcx
	subq	$24, %rsp
	movq	%rsp, %rsi
	movq	(%rcx), %rax
	movq	8(%rcx), %rdx
	movq	%rax, (%rsi)
	movq	%rdx, 8(%rsi)
	movl	16(%rcx), %eax
	movl	%eax, 16(%rsi)
	movq	%r8, %rsi
	call	DrawPlayer
	addq	$32, %rsp
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	GameUpdate, .-GameUpdate
	.section	.rodata
.LC3:
	.string	"Cannot open display\n"
.LC4:
	.string	"WM_DELETE_WINDOW"
	.text
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$448, %rsp
	movl	%edi, -436(%rbp)
	movq	%rsi, -448(%rbp)
	movq	$0, -144(%rbp)
	movq	$0, -136(%rbp)
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	movl	$4, %edi
	call	clock_gettime
	movq	-136(%rbp), %rax
	movq	%rax, -8(%rbp)
	movl	$0, %edi
	call	XOpenDisplay
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L41
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$20, %edx
	movl	$1, %esi
	movl	$.LC3, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L41:
	movq	-40(%rbp), %rax
	movl	224(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-40(%rbp), %rax
	movq	232(%rax), %rdx
	movl	-44(%rbp), %eax
	cltq
	salq	$7, %rax
	addq	%rdx, %rax
	movq	88(%rax), %rax
	movl	%eax, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	232(%rax), %rdx
	movl	-44(%rbp), %eax
	cltq
	salq	$7, %rax
	addq	%rdx, %rax
	movq	96(%rax), %rax
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %ecx
	movl	-48(%rbp), %edx
	movl	height(%rip), %eax
	movl	%eax, %r8d
	movl	width(%rip), %eax
	movl	%eax, %edi
	movq	-40(%rbp), %rax
	movq	232(%rax), %rsi
	movl	-44(%rbp), %eax
	cltq
	salq	$7, %rax
	addq	%rsi, %rax
	movq	16(%rax), %rsi
	movq	-40(%rbp), %rax
	subq	$8, %rsp
	pushq	%rcx
	pushq	%rdx
	pushq	$10
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movl	$10, %ecx
	movl	$10, %edx
	movq	%rax, %rdi
	call	XCreateSimpleWindow
	addq	$32, %rsp
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rcx
	movq	-40(%rbp), %rax
	movl	$425987, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSelectInput
	movq	-64(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XMapWindow
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateGC
	movq	%rax, -72(%rbp)
	movl	-48(%rbp), %edx
	movq	-72(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground
	movq	-40(%rbp), %rax
	movl	$0, %edx
	movl	$.LC4, %esi
	movq	%rax, %rdi
	call	XInternAtom
	movq	%rax, -152(%rbp)
	leaq	-152(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rax
	movl	$1, %ecx
	movq	%rax, %rdi
	call	XSetWMProtocols
	movl	width(%rip), %edx
	movl	height(%rip), %eax
	imull	%edx, %eax
	sall	$2, %eax
	cltq
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L42
.L43:
	movq	-24(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movl	$3355443, (%rax)
	addl	$1, -28(%rbp)
.L42:
	movl	width(%rip), %edx
	movl	height(%rip), %eax
	imull	%edx, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L43
	movl	height(%rip), %eax
	movl	%eax, %esi
	movl	width(%rip), %eax
	movl	%eax, %ecx
	movq	-80(%rbp), %rdx
	movq	-40(%rbp), %rax
	pushq	$0
	pushq	$32
	pushq	%rsi
	pushq	%rcx
	movq	%rdx, %r9
	movl	$0, %r8d
	movl	$2, %ecx
	movl	$24, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	XCreateImage
	addq	$32, %rsp
	movq	%rax, -88(%rbp)
	movl	width(%rip), %eax
	movl	%eax, -176(%rbp)
	movl	height(%rip), %eax
	movl	%eax, -172(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, -168(%rbp)
	movq	$0, -208(%rbp)
	movq	$0, -200(%rbp)
	movq	$0, -192(%rbp)
	leaq	-400(%rbp), %rdx
	movl	$0, %eax
	movl	$24, %ecx
	movq	%rdx, %rdi
	rep stosq
	movl	width(%rip), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -432(%rbp)
	movl	height(%rip), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -428(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -424(%rbp)
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, -420(%rbp)
	movss	.LC6(%rip), %xmm0
	movss	%xmm0, -416(%rbp)
	jmp	.L44
.L65:
	leaq	-400(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XNextEvent
	movl	-400(%rbp), %eax
	cmpl	$19, %eax
	je	.L44
	movl	-400(%rbp), %eax
	cmpl	$12, %eax
	je	.L44
	movl	-400(%rbp), %eax
	cmpl	$33, %eax
	jne	.L45
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	XCloseDisplay
	movl	$0, %eax
	jmp	.L69
.L45:
	movl	-400(%rbp), %eax
	cmpl	$2, %eax
	jne	.L47
	leaq	-400(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	subq	$97, %rax
	cmpq	$22, %rax
	ja	.L70
	movq	.L50(,%rax,8), %rax
	jmp	*%rax
	.section	.rodata
	.align 8
	.align 4
.L50:
	.quad	.L55
	.quad	.L70
	.quad	.L70
	.quad	.L54
	.quad	.L53
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L52
	.quad	.L70
	.quad	.L51
	.quad	.L70
	.quad	.L70
	.quad	.L70
	.quad	.L49
	.text
.L49:
	movl	$1, -208(%rbp)
	jmp	.L44
.L55:
	movl	$1, -204(%rbp)
	jmp	.L44
.L51:
	movl	$1, -200(%rbp)
	jmp	.L44
.L54:
	movl	$1, -196(%rbp)
	jmp	.L44
.L52:
	movl	$1, -192(%rbp)
	jmp	.L44
.L53:
	movl	$1, -188(%rbp)
	jmp	.L44
.L70:
	nop
	jmp	.L44
.L47:
	movl	-400(%rbp), %eax
	cmpl	$3, %eax
	jne	.L71
	leaq	-400(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	subq	$97, %rax
	cmpq	$22, %rax
	ja	.L44
	movq	.L59(,%rax,8), %rax
	jmp	*%rax
	.section	.rodata
	.align 8
	.align 4
.L59:
	.quad	.L64
	.quad	.L44
	.quad	.L44
	.quad	.L63
	.quad	.L62
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L61
	.quad	.L44
	.quad	.L60
	.quad	.L44
	.quad	.L44
	.quad	.L44
	.quad	.L58
	.text
.L58:
	movl	$0, -208(%rbp)
	jmp	.L44
.L64:
	movl	$0, -204(%rbp)
	jmp	.L44
.L60:
	movl	$0, -200(%rbp)
	jmp	.L44
.L63:
	movl	$0, -196(%rbp)
	jmp	.L44
.L61:
	movl	$0, -192(%rbp)
	jmp	.L44
.L62:
	movl	$0, -188(%rbp)
	jmp	.L44
.L71:
	nop
.L44:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	XPending
	testl	%eax, %eax
	jne	.L65
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	-136(%rbp), %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jl	.L66
	movq	-96(%rbp), %rax
	subq	-8(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	.LC7(%rip), %xmm1
	divss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L67
.L66:
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-96(%rbp), %xmm1
	pxor	%xmm2, %xmm2
	cvtsi2sdq	-8(%rbp), %xmm2
	movsd	.LC8(%rip), %xmm0
	subsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	.LC9(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
.L67:
	movsd	.LC10(%rip), %xmm0
	divsd	-16(%rbp), %xmm0
	movsd	%xmm0, -104(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, -8(%rbp)
	movsd	-16(%rbp), %xmm0
	movsd	.LC10(%rip), %xmm1
	divsd	%xmm1, %xmm0
	pxor	%xmm3, %xmm3
	cvtsd2ss	%xmm0, %xmm3
	movd	%xmm3, %esi
	leaq	-432(%rbp), %rdx
	movq	-176(%rbp), %rcx
	movq	-168(%rbp), %rax
	subq	$8, %rsp
	pushq	-192(%rbp)
	pushq	-200(%rbp)
	pushq	-208(%rbp)
	movd	%esi, %xmm0
	movq	%rcx, %rdi
	movq	%rax, %rsi
	call	GameUpdate
	addq	$32, %rsp
	movl	height(%rip), %eax
	movl	%eax, %r8d
	movl	width(%rip), %eax
	movl	%eax, %edi
	movq	-88(%rbp), %rcx
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-40(%rbp), %rax
	pushq	%r8
	pushq	%rdi
	pushq	$0
	pushq	$0
	movl	$0, %r9d
	movl	$0, %r8d
	movq	%rax, %rdi
	call	XPutImage
	addq	$32, %rsp
	jmp	.L44
.L69:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC2:
	.long	1112014848
	.align 4
.LC5:
	.long	1128792064
	.align 4
.LC6:
	.long	1070386381
	.align 4
.LC7:
	.long	1232348160
	.align 8
.LC8:
	.long	0
	.long	1104006501
	.align 8
.LC9:
	.long	0
	.long	1093567616
	.align 8
.LC10:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 10.2.1 20200723 (Red Hat 10.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
