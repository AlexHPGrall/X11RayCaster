	.file	"X11_RayTacer.c"
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
	.type	DrawPixel, @function
DrawPixel:
.LFB6:
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
.LFE6:
	.size	DrawPixel, .-DrawPixel
	.type	BresenLine, @function
BresenLine:
.LFB7:
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
	jns	.L3
	movl	$-1, %eax
	jmp	.L4
.L3:
	movl	$1, %eax
.L4:
	movl	%eax, -32(%rbp)
	movl	-64(%rbp), %eax
	subl	-56(%rbp), %eax
	testl	%eax, %eax
	jns	.L5
	movl	$-1, %eax
	jmp	.L6
.L5:
	movl	$1, %eax
.L6:
	movl	%eax, -36(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.L7
	movl	-20(%rbp), %eax
	addl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	%eax, -16(%rbp)
	movl	$1, -4(%rbp)
.L7:
	movl	-20(%rbp), %eax
	addl	%eax, %eax
	subl	-16(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -24(%rbp)
	movl	$1, -28(%rbp)
	jmp	.L8
.L15:
	movq	16(%rbp), %rcx
	movq	24(%rbp), %rdi
	movl	-68(%rbp), %edx
	movl	-12(%rbp), %esi
	movl	-8(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	DrawPixel
	jmp	.L9
.L12:
	cmpl	$0, -4(%rbp)
	je	.L10
	movl	-32(%rbp), %eax
	addl	%eax, -8(%rbp)
	jmp	.L11
.L10:
	movl	-36(%rbp), %eax
	addl	%eax, -12(%rbp)
.L11:
	movl	-16(%rbp), %eax
	addl	%eax, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	-24(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
.L9:
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jnb	.L12
	cmpl	$0, -4(%rbp)
	je	.L13
	movl	-36(%rbp), %eax
	addl	%eax, -12(%rbp)
	jmp	.L14
.L13:
	movl	-32(%rbp), %eax
	addl	%eax, -8(%rbp)
.L14:
	movl	-20(%rbp), %eax
	addl	%eax, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movss	-24(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
	addl	$1, -28(%rbp)
.L8:
	movl	-28(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.L15
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	BresenLine, .-BresenLine
	.type	DrawLine, @function
DrawLine:
.LFB8:
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
.LFE8:
	.size	DrawLine, .-DrawLine
	.type	DrawQuad, @function
DrawQuad:
.LFB9:
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
	jmp	.L18
.L19:
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
.L18:
	cmpl	$3, -4(%rbp)
	jle	.L19
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
.LFE9:
	.size	DrawQuad, .-DrawQuad
	.type	FillRect, @function
FillRect:
.LFB10:
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
	jmp	.L21
.L24:
	movl	-20(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L22
.L23:
	movq	16(%rbp), %rcx
	movq	24(%rbp), %rdi
	movl	-36(%rbp), %edx
	movl	-4(%rbp), %esi
	movl	-8(%rbp), %eax
	movq	%rdi, %r8
	movl	%eax, %edi
	call	DrawPixel
	addl	$1, -8(%rbp)
.L22:
	movl	-20(%rbp), %edx
	movl	-28(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L23
	addl	$1, -4(%rbp)
.L21:
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L24
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	FillRect, .-FillRect
	.type	FillBuffer, @function
FillBuffer:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, %rax
	movq	%rsi, %rcx
	movq	%rcx, %rdx
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L26
.L29:
	movl	$0, -16(%rbp)
	jmp	.L27
.L28:
	movl	-12(%rbp), %eax
	sall	$8, %eax
	movl	%eax, %ecx
	movq	-8(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -8(%rbp)
	movl	%ecx, %edx
	orl	-16(%rbp), %edx
	movl	%edx, (%rax)
	addl	$1, -16(%rbp)
.L27:
	movl	-32(%rbp), %eax
	cmpl	%eax, -16(%rbp)
	jl	.L28
	addl	$1, -12(%rbp)
.L26:
	movl	-28(%rbp), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L29
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	FillBuffer, .-FillBuffer
	.section	.rodata
.LC1:
	.string	"Cannot open display\n"
.LC2:
	.string	"WM_DELETE_WINDOW"
.LC3:
	.string	"w"
.LC6:
	.string	"%0.2fms / %0.2ffps\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$368, %rsp
	movl	%edi, -356(%rbp)
	movq	%rsi, -368(%rbp)
	movq	$0, -128(%rbp)
	movq	$0, -120(%rbp)
	leaq	-128(%rbp), %rax
	movq	%rax, %rsi
	movl	$4, %edi
	call	clock_gettime
	movq	-120(%rbp), %rax
	movq	%rax, -8(%rbp)
	movl	$0, %edi
	call	XOpenDisplay
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L31
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$20, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L31:
	movq	-32(%rbp), %rax
	movl	224(%rax), %eax
	movl	%eax, -36(%rbp)
	movq	-32(%rbp), %rax
	movq	232(%rax), %rdx
	movl	-36(%rbp), %eax
	cltq
	salq	$7, %rax
	addq	%rdx, %rax
	movq	88(%rax), %rax
	movl	%eax, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	232(%rax), %rdx
	movl	-36(%rbp), %eax
	cltq
	salq	$7, %rax
	addq	%rdx, %rax
	movq	96(%rax), %rax
	movl	%eax, -44(%rbp)
	movl	-44(%rbp), %ecx
	movl	-40(%rbp), %edx
	movl	height(%rip), %eax
	movl	%eax, %r8d
	movl	width(%rip), %eax
	movl	%eax, %edi
	movq	-32(%rbp), %rax
	movq	232(%rax), %rsi
	movl	-36(%rbp), %eax
	cltq
	salq	$7, %rax
	addq	%rsi, %rax
	movq	16(%rax), %rsi
	movq	-32(%rbp), %rax
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
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rcx
	movq	-32(%rbp), %rax
	movl	$425985, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSelectInput
	movq	-56(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XMapWindow
	movq	-56(%rbp), %rsi
	movq	-32(%rbp), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateGC
	movq	%rax, -64(%rbp)
	movl	-40(%rbp), %edx
	movq	-64(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground
	movq	-32(%rbp), %rax
	movl	$0, %edx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	call	XInternAtom
	movq	%rax, -136(%rbp)
	leaq	-136(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-32(%rbp), %rax
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
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L32
.L33:
	movq	-16(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -16(%rbp)
	movl	$3355443, (%rax)
	addl	$1, -20(%rbp)
.L32:
	movl	width(%rip), %edx
	movl	height(%rip), %eax
	imull	%edx, %eax
	cmpl	%eax, -20(%rbp)
	jl	.L33
	movl	height(%rip), %eax
	movl	%eax, %esi
	movl	width(%rip), %eax
	movl	%eax, %ecx
	movq	-72(%rbp), %rdx
	movq	-32(%rbp), %rax
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
	movq	%rax, -80(%rbp)
	movl	width(%rip), %eax
	movl	%eax, -160(%rbp)
	movl	height(%rip), %eax
	movl	%eax, -156(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -152(%rbp)
	leaq	-352(%rbp), %rdx
	movl	$0, %eax
	movl	$24, %ecx
	movq	%rdx, %rdi
	rep stosq
	jmp	.L34
.L37:
	leaq	-352(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XNextEvent
	movl	-352(%rbp), %eax
	cmpl	$19, %eax
	je	.L34
	movl	-352(%rbp), %eax
	cmpl	$12, %eax
	je	.L34
	movl	-352(%rbp), %eax
	cmpl	$33, %eax
	jne	.L35
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	XCloseDisplay
	movl	$0, %eax
	jmp	.L39
.L35:
	movl	-352(%rbp), %eax
	cmpl	$2, %eax
	jne	.L34
	leaq	-352(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym
	movq	%rax, -112(%rbp)
	cmpq	$119, -112(%rbp)
	jne	.L34
	call	rand
	movslq	%eax, %rdx
	imulq	$-2147483519, %rdx, %rdx
	shrq	$32, %rdx
	addl	%eax, %edx
	sarl	$23, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	movl	%edx, %ecx
	sall	$24, %ecx
	subl	%edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	movl	height(%rip), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%ecx, %eax
	sarl	%eax
	movl	%eax, %esi
	movl	width(%rip), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%ecx, %eax
	sarl	%eax
	pushq	-152(%rbp)
	pushq	-160(%rbp)
	movl	%edx, %r8d
	movl	$20, %ecx
	movl	$20, %edx
	movl	%eax, %edi
	call	FillRect
	addq	$16, %rsp
	movl	$.LC3, %edi
	call	puts
.L34:
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	XPending
	testl	%eax, %eax
	jne	.L37
	movl	height(%rip), %eax
	movl	%eax, %r8d
	movl	width(%rip), %eax
	movl	%eax, %edi
	movq	-80(%rbp), %rcx
	movq	-64(%rbp), %rdx
	movq	-56(%rbp), %rsi
	movq	-32(%rbp), %rax
	pushq	%r8
	pushq	%rdi
	pushq	$0
	pushq	$0
	movl	$0, %r9d
	movl	$0, %r8d
	movq	%rax, %rdi
	call	XPutImage
	addq	$32, %rsp
	leaq	-128(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	clock_gettime
	movq	-120(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	subq	-8(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	.LC4(%rip), %xmm1
	divss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movsd	%xmm0, -96(%rbp)
	movsd	.LC5(%rip), %xmm0
	divsd	-96(%rbp), %xmm0
	movsd	%xmm0, -104(%rbp)
	movq	stdout(%rip), %rax
	movsd	-104(%rbp), %xmm0
	movq	-96(%rbp), %rdx
	movapd	%xmm0, %xmm1
	movq	%rdx, %xmm0
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$2, %eax
	call	fprintf
	movq	-88(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L34
.L39:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC4:
	.long	1232348160
	.align 8
.LC5:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 10.2.1 20200723 (Red Hat 10.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
