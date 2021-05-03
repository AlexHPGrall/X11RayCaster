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
	.type	DrawCol, @function
DrawCol:
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
	movq	%r8, -48(%rbp)
	movq	%r9, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L24
.L25:
	movl	-24(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, %esi
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rdi
	movl	-32(%rbp), %edx
	movl	-20(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	DrawPixel
	addl	$1, -4(%rbp)
.L24:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L25
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	DrawCol, .-DrawCol
	.type	FillRect, @function
FillRect:
.LFB12:
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
	jmp	.L27
.L30:
	movl	-20(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L28
.L29:
	movq	16(%rbp), %rcx
	movq	24(%rbp), %rdi
	movl	-36(%rbp), %edx
	movl	-4(%rbp), %esi
	movl	-8(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	DrawPixel
	addl	$1, -8(%rbp)
.L28:
	movl	-20(%rbp), %edx
	movl	-28(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L29
	addl	$1, -4(%rbp)
.L27:
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L30
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	FillRect, .-FillRect
	.globl	gameMap
	.data
	.align 32
	.type	gameMap, @object
	.size	gameMap, 136
gameMap:
	.long	8
	.long	16
	.string	"\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	"\001"
	.string	""
	.string	"\001\001\001"
	.string	""
	.string	"\001"
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	"\001"
	.string	""
	.string	""
	.string	"\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	"\001\001\001"
	.string	"\001"
	.string	""
	.string	""
	.string	""
	.string	"\001"
	.string	"\001\001"
	.string	"\001\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	"\001\001"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.ascii	"\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001"
	.ascii	"\001\001"
	.globl	CellSize
	.align 4
	.type	CellSize, @object
	.size	CellSize, 4
CellSize:
	.long	64
	.text
	.type	GetMapIndex, @function
GetMapIndex:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movss	%xmm0, -36(%rbp)
	movss	%xmm1, -40(%rbp)
	movq	%rdi, -48(%rbp)
	movq	%rdx, %rcx
	movq	%rsi, %rax
	movq	%rdi, %rdx
	movq	%rcx, %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movl	-64(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-48(%rbp), %rax
	movl	4(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -4(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-48(%rbp), %rax
	movl	(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -8(%rbp)
	movl	-36(%rbp), %eax
	movd	%eax, %xmm0
	call	roundf
	comiss	.LC1(%rip), %xmm0
	jnb	.L32
	cvttss2siq	%xmm0, %rax
	jmp	.L33
.L32:
	movss	.LC1(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L33:
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	subq	%rdx, %rax
	movl	CellSize(%rip), %edx
	movslq	%edx, %rsi
	movl	$0, %edx
	divq	%rsi
	movq	%rax, -16(%rbp)
	movl	-40(%rbp), %eax
	movd	%eax, %xmm0
	call	roundf
	comiss	.LC1(%rip), %xmm0
	jnb	.L34
	cvttss2siq	%xmm0, %rax
	jmp	.L35
.L34:
	movss	.LC1(%rip), %xmm1
	subss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movabsq	$-9223372036854775808, %rdx
	xorq	%rdx, %rax
.L35:
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	subq	%rdx, %rax
	movl	CellSize(%rip), %edx
	movslq	%edx, %rdi
	movl	$0, %edx
	divq	%rdi
	movq	%rax, -24(%rbp)
	movq	-48(%rbp), %rax
	movl	4(%rax), %eax
	cltq
	imulq	-24(%rbp), %rax
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	GetMapIndex, .-GetMapIndex
	.type	GetYOffset, @function
GetYOffset:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rcx, -40(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-32(%rbp), %rax
	movl	4(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -4(%rbp)
	movl	-20(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	CellSize(%rip), %ecx
	cltd
	idivl	%ecx
	movl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	GetYOffset, .-GetYOffset
	.type	GetXOffset, @function
GetXOffset:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rcx, -40(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-32(%rbp), %rax
	movl	4(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -4(%rbp)
	movl	-20(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	CellSize(%rip), %ecx
	cltd
	idivl	%ecx
	movl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	GetXOffset, .-GetXOffset
	.type	CastRay, @function
CastRay:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	%edi, -100(%rbp)
	movl	%esi, -104(%rbp)
	movss	%xmm0, -108(%rbp)
	movss	%xmm1, -112(%rbp)
	movq	%rdx, -120(%rbp)
	movq	%rcx, %rax
	movq	%r8, %rcx
	movq	%rcx, %rdx
	movq	%rax, -144(%rbp)
	movq	%rdx, -136(%rbp)
	pxor	%xmm0, %xmm0
	ucomiss	-108(%rbp), %xmm0
	jp	.L88
	pxor	%xmm0, %xmm0
	ucomiss	-108(%rbp), %xmm0
	je	.L42
.L88:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	ucomisd	.LC2(%rip), %xmm0
	jp	.L89
	ucomisd	.LC2(%rip), %xmm0
	je	.L42
.L89:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	ucomisd	.LC3(%rip), %xmm0
	jp	.L90
	ucomisd	.LC3(%rip), %xmm0
	je	.L42
.L90:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	ucomisd	.LC4(%rip), %xmm0
	jp	.L46
	ucomisd	.LC4(%rip), %xmm0
	jne	.L46
.L42:
	pxor	%xmm0, %xmm0
	jmp	.L48
.L46:
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-104(%rbp), %xmm0
	pxor	%xmm4, %xmm4
	cvtsi2ssl	-100(%rbp), %xmm4
	movd	%xmm4, %eax
	movq	-144(%rbp), %rsi
	movq	-136(%rbp), %rdx
	movq	-120(%rbp), %rcx
	movq	%rcx, %rdi
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	GetMapIndex
	movq	%rax, -24(%rbp)
	movl	$0, -36(%rbp)
	movq	-144(%rbp), %rax
	movq	-136(%rbp), %rdx
	movq	-120(%rbp), %rsi
	movl	-100(%rbp), %edi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	GetXOffset
	movl	%eax, -52(%rbp)
	movq	-144(%rbp), %rax
	movq	-136(%rbp), %rdx
	movq	-120(%rbp), %rsi
	movl	-104(%rbp), %edi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	call	GetYOffset
	movl	%eax, -56(%rbp)
	pxor	%xmm0, %xmm0
	ucomiss	-108(%rbp), %xmm0
	jp	.L91
	pxor	%xmm0, %xmm0
	ucomiss	-108(%rbp), %xmm0
	je	.L49
.L91:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	ucomisd	.LC3(%rip), %xmm0
	jp	.L51
	ucomisd	.LC3(%rip), %xmm0
	jne	.L51
.L49:
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, -12(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -16(%rbp)
	jmp	.L53
.L51:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	ucomisd	.LC2(%rip), %xmm0
	jp	.L92
	ucomisd	.LC2(%rip), %xmm0
	je	.L54
.L92:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	ucomisd	.LC4(%rip), %xmm0
	jp	.L56
	ucomisd	.LC4(%rip), %xmm0
	jne	.L56
.L54:
	pxor	%xmm0, %xmm0
	movss	%xmm0, -12(%rbp)
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, -16(%rbp)
	jmp	.L53
.L56:
	movl	-108(%rbp), %eax
	movd	%eax, %xmm0
	call	tanf
	movaps	%xmm0, %xmm1
	movss	.LC5(%rip), %xmm0
	divss	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L99
	movl	-108(%rbp), %eax
	movd	%eax, %xmm0
	call	tanf
	movaps	%xmm0, %xmm1
	movss	.LC5(%rip), %xmm0
	divss	%xmm1, %xmm0
	jmp	.L60
.L99:
	movl	-108(%rbp), %eax
	movd	%eax, %xmm0
	call	tanf
	movaps	%xmm0, %xmm1
	movss	.LC5(%rip), %xmm0
	divss	%xmm1, %xmm0
	movss	.LC6(%rip), %xmm1
	xorps	%xmm1, %xmm0
.L60:
	movss	%xmm0, -12(%rbp)
	movl	-108(%rbp), %eax
	movd	%eax, %xmm0
	call	tanf
	movd	%xmm0, %eax
	pxor	%xmm0, %xmm0
	movd	%eax, %xmm5
	comiss	%xmm0, %xmm5
	jbe	.L100
	movl	-108(%rbp), %eax
	movd	%eax, %xmm0
	call	tanf
	movd	%xmm0, %eax
	jmp	.L63
.L100:
	movl	-108(%rbp), %eax
	movd	%eax, %xmm0
	call	tanf
	movd	%xmm0, %eax
	movss	.LC6(%rip), %xmm0
	movd	%eax, %xmm3
	xorps	%xmm0, %xmm3
	movd	%xmm3, %eax
.L63:
	movl	%eax, -16(%rbp)
.L53:
	pxor	%xmm1, %xmm1
	cvtss2sd	-108(%rbp), %xmm1
	movsd	.LC2(%rip), %xmm0
	comisd	%xmm1, %xmm0
	ja	.L64
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	comisd	.LC4(%rip), %xmm0
	jbe	.L101
.L64:
	movl	$1, -28(%rbp)
	jmp	.L67
.L101:
	movl	$-1, -28(%rbp)
.L67:
	pxor	%xmm0, %xmm0
	cvtss2sd	-108(%rbp), %xmm0
	comisd	.LC3(%rip), %xmm0
	jbe	.L102
	movl	$-1, -32(%rbp)
	jmp	.L70
.L102:
	movl	$1, -32(%rbp)
.L70:
	cmpl	$1, -28(%rbp)
	jne	.L71
	movl	CellSize(%rip), %eax
	subl	-52(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	-16(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
	jmp	.L72
.L71:
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-52(%rbp), %xmm0
	movss	-16(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
.L72:
	cmpl	$1, -32(%rbp)
	jne	.L73
	movl	CellSize(%rip), %eax
	subl	-56(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	-12(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, -8(%rbp)
	jmp	.L74
.L73:
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-56(%rbp), %xmm0
	movss	-12(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, -8(%rbp)
.L74:
	movl	-100(%rbp), %eax
	subl	-52(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	-104(%rbp), %eax
	subl	-56(%rbp), %eax
	movl	%eax, -44(%rbp)
	cmpl	$1, -28(%rbp)
	jne	.L75
	movl	CellSize(%rip), %eax
	addl	%eax, -40(%rbp)
.L75:
	cmpl	$1, -32(%rbp)
	jne	.L77
	movl	CellSize(%rip), %eax
	addl	%eax, -44(%rbp)
	jmp	.L77
.L80:
	pxor	%xmm1, %xmm1
	cvtsi2ssl	-32(%rbp), %xmm1
	pxor	%xmm2, %xmm2
	cvtsi2ssl	-104(%rbp), %xmm2
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-32(%rbp), %xmm0
	mulss	-4(%rbp), %xmm0
	addss	%xmm2, %xmm0
	mulss	%xmm0, %xmm1
	movl	-32(%rbp), %eax
	imull	-44(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	comiss	%xmm1, %xmm0
	jbe	.L103
	movl	$0, -48(%rbp)
	movl	-28(%rbp), %eax
	cltq
	addq	%rax, -24(%rbp)
	movq	-120(%rbp), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	addq	$8, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jne	.L77
	movl	CellSize(%rip), %eax
	imull	-28(%rbp), %eax
	addl	%eax, -40(%rbp)
	movl	CellSize(%rip), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	mulss	-16(%rbp), %xmm0
	movss	-4(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
	jmp	.L77
.L103:
	movl	$1, -48(%rbp)
	movq	-120(%rbp), %rax
	movl	4(%rax), %eax
	imull	-32(%rbp), %eax
	cltq
	addq	%rax, -24(%rbp)
	movq	-120(%rbp), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	addq	$8, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jne	.L77
	movl	CellSize(%rip), %eax
	imull	-32(%rbp), %eax
	addl	%eax, -44(%rbp)
	movl	CellSize(%rip), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	mulss	-12(%rbp), %xmm0
	movss	-8(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -8(%rbp)
.L77:
	cmpl	$0, -36(%rbp)
	je	.L80
	cmpl	$0, -48(%rbp)
	jne	.L81
	movl	-40(%rbp), %eax
	subl	-100(%rbp), %eax
	cltd
	xorl	%edx, %eax
	subl	%edx, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -76(%rbp)
	movss	-4(%rbp), %xmm0
	movss	%xmm0, -80(%rbp)
	movss	-76(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	mulss	%xmm0, %xmm1
	movss	-80(%rbp), %xmm0
	mulss	%xmm0, %xmm0
	addss	%xmm1, %xmm0
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movq	%xmm6, %rax
	movq	%rax, %xmm0
	call	sqrt
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -84(%rbp)
	pxor	%xmm7, %xmm7
	cvtss2sd	-84(%rbp), %xmm7
	movsd	%xmm7, -128(%rbp)
	movss	-112(%rbp), %xmm0
	subss	-108(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L104
	movss	-112(%rbp), %xmm0
	subss	-108(%rbp), %xmm0
	jmp	.L84
.L104:
	movss	-112(%rbp), %xmm0
	subss	-108(%rbp), %xmm0
	movss	.LC6(%rip), %xmm1
	xorps	%xmm1, %xmm0
.L84:
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	call	cos
	mulsd	-128(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -88(%rbp)
	movss	-88(%rbp), %xmm0
	movss	.LC6(%rip), %xmm1
	xorps	%xmm1, %xmm0
	jmp	.L48
.L81:
	movss	-8(%rbp), %xmm0
	movss	%xmm0, -60(%rbp)
	movl	-44(%rbp), %eax
	subl	-104(%rbp), %eax
	cltd
	xorl	%edx, %eax
	subl	%edx, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -64(%rbp)
	movss	-60(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	mulss	%xmm0, %xmm1
	movss	-64(%rbp), %xmm0
	mulss	%xmm0, %xmm0
	addss	%xmm1, %xmm0
	pxor	%xmm5, %xmm5
	cvtss2sd	%xmm0, %xmm5
	movq	%xmm5, %rax
	movq	%rax, %xmm0
	call	sqrt
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -68(%rbp)
	pxor	%xmm6, %xmm6
	cvtss2sd	-68(%rbp), %xmm6
	movsd	%xmm6, -128(%rbp)
	movss	-112(%rbp), %xmm0
	subss	-108(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L105
	movss	-112(%rbp), %xmm0
	subss	-108(%rbp), %xmm0
	jmp	.L87
.L105:
	movss	-112(%rbp), %xmm0
	subss	-108(%rbp), %xmm0
	movss	.LC6(%rip), %xmm1
	xorps	%xmm1, %xmm0
.L87:
	pxor	%xmm7, %xmm7
	cvtss2sd	%xmm0, %xmm7
	movq	%xmm7, %rax
	movq	%rax, %xmm0
	call	cos
	mulsd	-128(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -72(%rbp)
	movss	-72(%rbp), %xmm0
.L48:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	CastRay, .-CastRay
	.type	CheckCollision, @function
CheckCollision:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movl	%edx, -84(%rbp)
	movq	%rcx, %rax
	movq	%r8, %rcx
	movq	%rcx, %rdx
	movq	%rax, -112(%rbp)
	movq	%rdx, -104(%rbp)
	movq	-72(%rbp), %rax
	movss	(%rax), %xmm0
	movss	%xmm0, -8(%rbp)
	movq	-72(%rbp), %rax
	movss	4(%rax), %xmm0
	movss	%xmm0, -12(%rbp)
	movss	-8(%rbp), %xmm0
	movss	.LC7(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	%xmm0, -16(%rbp)
	movss	-8(%rbp), %xmm1
	movss	.LC7(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -20(%rbp)
	movss	-12(%rbp), %xmm0
	movss	.LC7(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
	movss	-12(%rbp), %xmm1
	movss	.LC7(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -28(%rbp)
	movss	-16(%rbp), %xmm0
	movss	%xmm0, -48(%rbp)
	movss	-16(%rbp), %xmm0
	movss	%xmm0, -44(%rbp)
	movss	-20(%rbp), %xmm0
	movss	%xmm0, -40(%rbp)
	movss	-20(%rbp), %xmm0
	movss	%xmm0, -36(%rbp)
	movss	-24(%rbp), %xmm0
	movss	%xmm0, -64(%rbp)
	movss	-28(%rbp), %xmm0
	movss	%xmm0, -60(%rbp)
	movss	-24(%rbp), %xmm0
	movss	%xmm0, -56(%rbp)
	movss	-28(%rbp), %xmm0
	movss	%xmm0, -52(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L107
.L110:
	movl	-4(%rbp), %eax
	cltq
	movss	-64(%rbp,%rax,4), %xmm0
	movl	-4(%rbp), %eax
	cltq
	movl	-48(%rbp,%rax,4), %eax
	movq	-112(%rbp), %rsi
	movq	-104(%rbp), %rdx
	movq	-80(%rbp), %rcx
	movq	%rcx, %rdi
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	GetMapIndex
	movq	-80(%rbp), %rdx
	movzbl	8(%rdx,%rax), %eax
	testb	%al, %al
	je	.L108
	movq	-72(%rbp), %rax
	movss	(%rax), %xmm2
	movss	%xmm2, -88(%rbp)
	pxor	%xmm1, %xmm1
	cvtsi2ssl	-84(%rbp), %xmm1
	movss	.LC8(%rip), %xmm0
	mulss	%xmm0, %xmm1
	movss	%xmm1, -92(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	cosf
	mulss	-92(%rbp), %xmm0
	addss	-88(%rbp), %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, (%rax)
	movq	-72(%rbp), %rax
	movss	4(%rax), %xmm3
	movss	%xmm3, -88(%rbp)
	pxor	%xmm1, %xmm1
	cvtsi2ssl	-84(%rbp), %xmm1
	movss	.LC8(%rip), %xmm0
	mulss	%xmm0, %xmm1
	movss	%xmm1, -92(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	sinf
	mulss	-92(%rbp), %xmm0
	addss	-88(%rbp), %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 4(%rax)
	movq	-112(%rbp), %rcx
	movq	-104(%rbp), %rdi
	movl	-84(%rbp), %edx
	movq	-80(%rbp), %rsi
	movq	-72(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	CheckCollision
	jmp	.L109
.L108:
	addl	$1, -4(%rbp)
.L107:
	cmpl	$3, -4(%rbp)
	jle	.L110
	nop
.L109:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	CheckCollision, .-CheckCollision
	.type	DrawMap, @function
DrawMap:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rdx, %rcx
	movq	%rsi, %rax
	movq	%rdi, %rdx
	movq	%rcx, %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-24(%rbp), %rax
	movl	4(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	negl	%eax
	addl	%ecx, %eax
	movl	%eax, -12(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %ecx
	movq	-24(%rbp), %rax
	movl	(%rax), %edx
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
	jmp	.L112
.L117:
	movl	$0, -8(%rbp)
	jmp	.L113
.L116:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	imull	-4(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movq	-24(%rbp), %rdx
	cltq
	movzbl	8(%rdx,%rax), %eax
	testb	%al, %al
	je	.L114
	movl	CellSize(%rip), %eax
	leal	-1(%rax), %ecx
	movl	CellSize(%rip), %eax
	leal	-1(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	-4(%rbp), %eax
	movl	%eax, %esi
	movl	-16(%rbp), %eax
	addl	%eax, %esi
	movl	CellSize(%rip), %eax
	imull	-8(%rbp), %eax
	movl	%eax, %edi
	movl	-12(%rbp), %eax
	addl	%edi, %eax
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	movl	$16777215, %r8d
	movl	%eax, %edi
	call	FillRect
	addq	$16, %rsp
	jmp	.L115
.L114:
	movl	CellSize(%rip), %eax
	leal	-1(%rax), %ecx
	movl	CellSize(%rip), %eax
	leal	-1(%rax), %edx
	movl	CellSize(%rip), %eax
	imull	-4(%rbp), %eax
	movl	%eax, %esi
	movl	-16(%rbp), %eax
	addl	%eax, %esi
	movl	CellSize(%rip), %eax
	imull	-8(%rbp), %eax
	movl	%eax, %edi
	movl	-12(%rbp), %eax
	addl	%edi, %eax
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	movl	$0, %r8d
	movl	%eax, %edi
	call	FillRect
	addq	$16, %rsp
.L115:
	addl	$1, -8(%rbp)
.L113:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L116
	addl	$1, -4(%rbp)
.L112:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L117
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	DrawMap, .-DrawMap
	.type	DrawPlayer, @function
DrawPlayer:
.LFB19:
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
	movss	.LC9(%rip), %xmm1
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
	movss	.LC9(%rip), %xmm1
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
.LFE19:
	.size	DrawPlayer, .-DrawPlayer
	.type	GameUpdate, @function
GameUpdate:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 3, -24
	movq	%rdi, %rcx
	movq	%rsi, %rax
	movq	%rax, %rbx
	movq	%rcx, -64(%rbp)
	movq	%rbx, -56(%rbp)
	movq	%rdx, -72(%rbp)
	movss	%xmm0, -76(%rbp)
	movl	$1, -20(%rbp)
	movl	32(%rbp), %eax
	testl	%eax, %eax
	je	.L120
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm0
	movq	-72(%rbp), %rax
	movss	16(%rax), %xmm1
	mulss	-76(%rbp), %xmm1
	subss	%xmm1, %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 8(%rax)
	jmp	.L121
.L120:
	movl	36(%rbp), %eax
	testl	%eax, %eax
	je	.L121
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm1
	movq	-72(%rbp), %rax
	movss	16(%rax), %xmm0
	mulss	-76(%rbp), %xmm0
	addss	%xmm1, %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 8(%rax)
.L121:
	movl	16(%rbp), %eax
	testl	%eax, %eax
	je	.L122
	movl	$-1, -20(%rbp)
	movq	-72(%rbp), %rax
	movss	(%rax), %xmm3
	movss	%xmm3, -80(%rbp)
	movq	-72(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-76(%rbp), %xmm0
	movss	%xmm0, -84(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	cosf
	mulss	-84(%rbp), %xmm0
	addss	-80(%rbp), %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, (%rax)
	movq	-72(%rbp), %rax
	movss	4(%rax), %xmm4
	movss	%xmm4, -80(%rbp)
	movq	-72(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-76(%rbp), %xmm0
	movss	%xmm0, -84(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	sinf
	mulss	-84(%rbp), %xmm0
	addss	-80(%rbp), %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 4(%rax)
	jmp	.L123
.L122:
	movl	24(%rbp), %eax
	testl	%eax, %eax
	je	.L123
	movl	$1, -20(%rbp)
	movq	-72(%rbp), %rax
	movss	(%rax), %xmm6
	movss	%xmm6, -80(%rbp)
	movq	-72(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-76(%rbp), %xmm0
	movss	%xmm0, -84(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	cosf
	movss	-84(%rbp), %xmm1
	mulss	%xmm0, %xmm1
	movss	-80(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, (%rax)
	movq	-72(%rbp), %rax
	movss	4(%rax), %xmm7
	movss	%xmm7, -80(%rbp)
	movq	-72(%rbp), %rax
	movss	12(%rax), %xmm0
	mulss	-76(%rbp), %xmm0
	movss	%xmm0, -84(%rbp)
	movq	-72(%rbp), %rax
	movl	8(%rax), %eax
	movd	%eax, %xmm0
	call	sinf
	movss	-84(%rbp), %xmm1
	mulss	%xmm0, %xmm1
	movss	-80(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 4(%rax)
.L123:
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	comisd	.LC10(%rip), %xmm0
	jb	.L149
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	.LC10(%rip), %xmm1
	subsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 8(%rax)
	jmp	.L126
.L149:
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm1
	pxor	%xmm0, %xmm0
	comiss	%xmm1, %xmm0
	jbe	.L126
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movsd	.LC10(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movq	-72(%rbp), %rax
	movss	%xmm0, 8(%rax)
.L126:
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rsi
	movl	-20(%rbp), %edx
	movq	-72(%rbp), %rax
	movq	%rsi, %r8
	movl	$gameMap, %esi
	movq	%rax, %rdi
	call	CheckCollision
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rax
	movl	$3355443, %edx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	call	FillBuffer
	movl	$0, -24(%rbp)
	jmp	.L128
.L141:
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movsd	.LC11(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movl	-64(%rbp), %eax
	subl	-24(%rbp), %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movl	-64(%rbp), %eax
	pxor	%xmm3, %xmm3
	cvtsi2sdl	%eax, %xmm3
	movsd	.LC12(%rip), %xmm1
	divsd	%xmm3, %xmm1
	mulsd	%xmm2, %xmm1
	subsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -28(%rbp)
	pxor	%xmm0, %xmm0
	cvtss2sd	-28(%rbp), %xmm0
	comisd	.LC10(%rip), %xmm0
	jb	.L150
	pxor	%xmm0, %xmm0
	cvtss2sd	-28(%rbp), %xmm0
	movsd	.LC10(%rip), %xmm1
	subsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -28(%rbp)
	jmp	.L131
.L150:
	pxor	%xmm0, %xmm0
	comiss	-28(%rbp), %xmm0
	jbe	.L131
	pxor	%xmm1, %xmm1
	cvtss2sd	-28(%rbp), %xmm1
	movsd	.LC10(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -28(%rbp)
.L131:
	movq	-72(%rbp), %rax
	movss	8(%rax), %xmm5
	movss	%xmm5, -80(%rbp)
	movq	-72(%rbp), %rax
	movss	4(%rax), %xmm0
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movq	%xmm6, %rax
	movq	%rax, %xmm0
	call	floor
	cvttsd2sil	%xmm0, %ebx
	movq	-72(%rbp), %rax
	movss	(%rax), %xmm0
	pxor	%xmm7, %xmm7
	cvtss2sd	%xmm0, %xmm7
	movq	%xmm7, %rax
	movq	%rax, %xmm0
	call	floor
	cvttsd2sil	%xmm0, %eax
	movq	-64(%rbp), %rdx
	movq	-56(%rbp), %rdi
	movl	-28(%rbp), %esi
	movq	%rdx, %rcx
	movq	%rdi, %r8
	movl	$gameMap, %edx
	movss	-80(%rbp), %xmm1
	movd	%esi, %xmm0
	movl	%ebx, %esi
	movl	%eax, %edi
	call	CastRay
	movd	%xmm0, %eax
	movl	%eax, -40(%rbp)
	pxor	%xmm0, %xmm0
	comiss	-40(%rbp), %xmm0
	jbe	.L151
	movl	$16711680, -32(%rbp)
	jmp	.L135
.L151:
	movl	$5570560, -32(%rbp)
.L135:
	movss	-40(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L152
	movss	-40(%rbp), %xmm0
	jmp	.L138
.L152:
	movss	-40(%rbp), %xmm0
	movss	.LC6(%rip), %xmm1
	xorps	%xmm1, %xmm0
.L138:
	movss	%xmm0, -40(%rbp)
	movl	-60(%rbp), %edx
	movl	CellSize(%rip), %eax
	imull	%edx, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	divss	-40(%rbp), %xmm0
	movss	%xmm0, -36(%rbp)
	movl	-60(%rbp), %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	-36(%rbp), %xmm0
	comiss	%xmm1, %xmm0
	jb	.L139
	movl	-60(%rbp), %eax
	subl	$1, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -36(%rbp)
.L139:
	movl	-60(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	-36(%rbp), %xmm0
	movss	.LC13(%rip), %xmm2
	divss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -44(%rbp)
	movss	-36(%rbp), %xmm0
	cvttss2sil	%xmm0, %r10d
	movss	-44(%rbp), %xmm0
	cvttss2sil	%xmm0, %esi
	movq	-64(%rbp), %rax
	movq	-56(%rbp), %rdx
	movl	-32(%rbp), %ecx
	movl	-24(%rbp), %edi
	movq	%rax, %r8
	movq	%rdx, %r9
	movl	%r10d, %edx
	call	DrawCol
	addl	$1, -24(%rbp)
.L128:
	movl	-64(%rbp), %eax
	cmpl	%eax, -24(%rbp)
	jl	.L141
	nop
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	GameUpdate, .-GameUpdate
	.section	.rodata
.LC14:
	.string	"Cannot open display\n"
.LC15:
	.string	"WM_DELETE_WINDOW"
	.text
	.globl	main
	.type	main, @function
main:
.LFB21:
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
	jne	.L154
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$20, %edx
	movl	$1, %esi
	movl	$.LC14, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L154:
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
	movl	$.LC15, %esi
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
	jmp	.L155
.L156:
	movq	-24(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movl	$3355443, (%rax)
	addl	$1, -28(%rbp)
.L155:
	movl	width(%rip), %edx
	movl	height(%rip), %eax
	imull	%edx, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L156
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
	movss	.LC16(%rip), %xmm0
	movss	%xmm0, -424(%rbp)
	movss	.LC17(%rip), %xmm0
	movss	%xmm0, -420(%rbp)
	movss	.LC18(%rip), %xmm0
	movss	%xmm0, -416(%rbp)
	jmp	.L157
.L178:
	leaq	-400(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XNextEvent
	movl	-400(%rbp), %eax
	cmpl	$19, %eax
	je	.L157
	movl	-400(%rbp), %eax
	cmpl	$12, %eax
	je	.L157
	movl	-400(%rbp), %eax
	cmpl	$33, %eax
	jne	.L158
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	XCloseDisplay
	movl	$0, %eax
	jmp	.L182
.L158:
	movl	-400(%rbp), %eax
	cmpl	$2, %eax
	jne	.L160
	leaq	-400(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	subq	$97, %rax
	cmpq	$22, %rax
	ja	.L183
	movq	.L163(,%rax,8), %rax
	jmp	*%rax
	.section	.rodata
	.align 8
	.align 4
.L163:
	.quad	.L168
	.quad	.L183
	.quad	.L183
	.quad	.L167
	.quad	.L166
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L165
	.quad	.L183
	.quad	.L164
	.quad	.L183
	.quad	.L183
	.quad	.L183
	.quad	.L162
	.text
.L162:
	movl	$1, -208(%rbp)
	jmp	.L157
.L168:
	movl	$1, -204(%rbp)
	jmp	.L157
.L164:
	movl	$1, -200(%rbp)
	jmp	.L157
.L167:
	movl	$1, -196(%rbp)
	jmp	.L157
.L165:
	movl	$1, -192(%rbp)
	jmp	.L157
.L166:
	movl	$1, -188(%rbp)
	jmp	.L157
.L183:
	nop
	jmp	.L157
.L160:
	movl	-400(%rbp), %eax
	cmpl	$3, %eax
	jne	.L184
	leaq	-400(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	subq	$97, %rax
	cmpq	$22, %rax
	ja	.L157
	movq	.L172(,%rax,8), %rax
	jmp	*%rax
	.section	.rodata
	.align 8
	.align 4
.L172:
	.quad	.L177
	.quad	.L157
	.quad	.L157
	.quad	.L176
	.quad	.L175
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L174
	.quad	.L157
	.quad	.L173
	.quad	.L157
	.quad	.L157
	.quad	.L157
	.quad	.L171
	.text
.L171:
	movl	$0, -208(%rbp)
	jmp	.L157
.L177:
	movl	$0, -204(%rbp)
	jmp	.L157
.L173:
	movl	$0, -200(%rbp)
	jmp	.L157
.L176:
	movl	$0, -196(%rbp)
	jmp	.L157
.L174:
	movl	$0, -192(%rbp)
	jmp	.L157
.L175:
	movl	$0, -188(%rbp)
	jmp	.L157
.L184:
	nop
.L157:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	XPending
	testl	%eax, %eax
	jne	.L178
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	-136(%rbp), %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jl	.L179
	movq	-96(%rbp), %rax
	subq	-8(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	.LC19(%rip), %xmm1
	divss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L180
.L179:
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-96(%rbp), %xmm1
	pxor	%xmm2, %xmm2
	cvtsi2sdq	-8(%rbp), %xmm2
	movsd	.LC20(%rip), %xmm0
	subsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	.LC21(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
.L180:
	movsd	.LC22(%rip), %xmm0
	divsd	-16(%rbp), %xmm0
	movsd	%xmm0, -104(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, -8(%rbp)
	movsd	-16(%rbp), %xmm0
	movsd	.LC22(%rip), %xmm1
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
	jmp	.L157
.L182:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC1:
	.long	1593835520
	.align 8
.LC2:
	.long	1413754136
	.long	1073291771
	.align 8
.LC3:
	.long	1413754136
	.long	1074340347
	.align 8
.LC4:
	.long	2134057426
	.long	1074977148
	.align 4
.LC5:
	.long	1065353216
	.align 16
.LC6:
	.long	-2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC7:
	.long	1084227584
	.align 4
.LC8:
	.long	1056964608
	.align 4
.LC9:
	.long	1103626240
	.align 8
.LC10:
	.long	1413754136
	.long	1075388923
	.align 8
.LC11:
	.long	942502757
	.long	1071694162
	.align 8
.LC12:
	.long	942502757
	.long	1072742738
	.align 4
.LC13:
	.long	1073741824
	.align 4
.LC16:
	.long	1061752795
	.align 4
.LC17:
	.long	1128792064
	.align 4
.LC18:
	.long	1070386381
	.align 4
.LC19:
	.long	1232348160
	.align 8
.LC20:
	.long	0
	.long	1104006501
	.align 8
.LC21:
	.long	0
	.long	1093567616
	.align 8
.LC22:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 10.2.1 20201125 (Red Hat 10.2.1-9)"
	.section	.note.GNU-stack,"",@progbits
