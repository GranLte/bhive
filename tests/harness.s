	.text
	.file	"harness.c"
	.globl	round_to_page_start             # -- Begin function round_to_page_start
	.p2align	4, 0x90
	.type	round_to_page_start,@function
round_to_page_start:                    # @round_to_page_start
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	shrq	$12, %rax
	shlq	$12, %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	round_to_page_start, .Lfunc_end0-round_to_page_start
	.cfi_endproc
                                        # -- End function
	.globl	round_to_next_page              # -- Begin function round_to_next_page
	.p2align	4, 0x90
	.type	round_to_next_page,@function
round_to_next_page:                     # @round_to_next_page
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	addq	$4096, %rax                     # imm = 0x1000
	shrq	$12, %rax
	shlq	$12, %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	round_to_next_page, .Lfunc_end1-round_to_next_page
	.cfi_endproc
                                        # -- End function
	.globl	attach_to_child                 # -- Begin function attach_to_child
	.p2align	4, 0x90
	.type	attach_to_child,@function
attach_to_child:                        # @attach_to_child
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %esi
	movl	$16902, %edi                    # imm = 0x4206
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	%rcx, %rdx
	movb	$0, %al
	callq	ptrace@PLT
	movl	-8(%rbp), %edi
	movabsq	$x, %rsi
	movl	$1, %edx
	callq	write@PLT
	movl	-8(%rbp), %edi
	callq	close@PLT
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	attach_to_child, .Lfunc_end2-attach_to_child
	.cfi_endproc
                                        # -- End function
	.globl	create_shm_fd                   # -- Begin function create_shm_fd
	.p2align	4, 0x90
	.type	create_shm_fd,@function
create_shm_fd:                          # @create_shm_fd
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	movl	$66, %esi
	movl	$511, %edx                      # imm = 0x1FF
	callq	shm_open@PLT
	movl	%eax, -12(%rbp)
	movq	-8(%rbp), %rdi
	callq	shm_unlink@PLT
	movl	-12(%rbp), %edi
	movl	$12288, %esi                    # imm = 0x3000
	callq	ftruncate@PLT
	movl	-12(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	create_shm_fd, .Lfunc_end3-create_shm_fd
	.cfi_endproc
                                        # -- End function
	.globl	perf_event_open                 # -- Begin function perf_event_open
	.p2align	4, 0x90
	.type	perf_event_open,@function
perf_event_open:                        # @perf_event_open
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movq	%r8, -32(%rbp)
	movq	-8(%rbp), %rsi
	movl	-12(%rbp), %edx
	movl	-16(%rbp), %ecx
	movl	-20(%rbp), %r8d
	movq	-32(%rbp), %r9
	movl	$298, %edi                      # imm = 0x12A
	movb	$0, %al
	callq	syscall@PLT
                                        # kill: def $eax killed $eax killed $rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	perf_event_open, .Lfunc_end4-perf_event_open
	.cfi_endproc
                                        # -- End function
	.globl	restart_child                   # -- Begin function restart_child
	.p2align	4, 0x90
	.type	restart_child,@function
restart_child:                          # @restart_child
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$256, %rsp                      # imm = 0x100
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movabsq	$.L.str, %rdi
	movb	$0, %al
	callq	printf@PLT
	movl	-4(%rbp), %esi
	movl	$12, %edi
	xorl	%eax, %eax
	movl	%eax, %edx
	leaq	-248(%rbp), %rcx
	movb	$0, %al
	callq	ptrace@PLT
	movabsq	$.L.str.1, %rdi
	callq	perror@PLT
	movq	-16(%rbp), %rax
	movq	%rax, -120(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -168(%rbp)
	movslq	-28(%rbp), %rax
	movq	%rax, -200(%rbp)
	movq	$1, -224(%rbp)
	movq	$3, -232(%rbp)
	movl	-4(%rbp), %esi
	movl	$13, %edi
	xorl	%eax, %eax
	movl	%eax, %edx
	leaq	-248(%rbp), %rcx
	movb	$0, %al
	callq	ptrace@PLT
	movabsq	$.L.str.2, %rdi
	callq	perror@PLT
	movl	-4(%rbp), %esi
	movl	$7, %edi
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	%rcx, %rdx
	movb	$0, %al
	callq	ptrace@PLT
	movabsq	$.L.str.3, %rdi
	callq	perror@PLT
	addq	$256, %rsp                      # imm = 0x100
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	restart_child, .Lfunc_end5-restart_child
	.cfi_endproc
                                        # -- End function
	.globl	emit_mov_rcx                    # -- Begin function emit_mov_rcx
	.p2align	4, 0x90
	.type	emit_mov_rcx,@function
emit_mov_rcx:                           # @emit_mov_rcx
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jge	.LBB6_2
# %bb.1:
	jmp	.LBB6_3
.LBB6_2:
	movq	-8(%rbp), %rax
	movb	$-71, (%rax)
	movl	-12(%rbp), %eax
	movb	%al, %cl
	movq	-8(%rbp), %rax
	movb	%cl, 1(%rax)
	movq	-8(%rbp), %rax
	movb	$0, 2(%rax)
	movq	-8(%rbp), %rax
	movb	$0, 3(%rax)
	movq	-8(%rbp), %rax
	movb	$0, 4(%rax)
.LBB6_3:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	emit_mov_rcx, .Lfunc_end6-emit_mov_rcx
	.cfi_endproc
                                        # -- End function
	.globl	is_event_supported              # -- Begin function is_event_supported
	.p2align	4, 0x90
	.type	is_event_supported,@function
is_event_supported:                     # @is_event_supported
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	leaq	-24(%rbp), %rsi
	xorl	%eax, %eax
	movl	%eax, %edx
	callq	rdpmc_open_attr@PLT
	cmpl	$0, %eax
	setne	%al
	xorb	$-1, %al
	andb	$1, %al
	movzbl	%al, %eax
	movl	%eax, -28(%rbp)
	leaq	-24(%rbp), %rdi
	callq	rdpmc_close@PLT
	movl	-28(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	is_event_supported, .Lfunc_end7-is_event_supported
	.cfi_endproc
                                        # -- End function
	.globl	measure                         # -- Begin function measure
	.p2align	4, 0x90
	.type	measure,@function
measure:                                # @measure
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$720, %rsp                      # imm = 0x2D0
	movl	16(%rbp), %eax
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movq	%rcx, -40(%rbp)
	movq	%r8, -48(%rbp)
	movq	%r9, -56(%rbp)
	leaq	-64(%rbp), %rdi
	callq	pipe@PLT
	movl	16(%rbp), %r8d
	xorl	%eax, %eax
	movl	%eax, %edi
	movl	$8192, %esi                     # imm = 0x2000
	movl	$3, %edx
	movl	$1, %ecx
	movl	$4096, %r9d                     # imm = 0x1000
	callq	mmap@PLT
	movq	%rax, -72(%rbp)
	movabsq	$.L.str.4, %rdi
	callq	perror@PLT
	movq	-72(%rbp), %rdi
	xorl	%esi, %esi
	movl	$8192, %edx                     # imm = 0x2000
	callq	memset@PLT
	callq	fork@PLT
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	je	.LBB8_25
# %bb.1:
	movl	-64(%rbp), %edi
	callq	close@PLT
	movl	16(%rbp), %r8d
	xorl	%eax, %eax
	movl	%eax, %r9d
	movl	$4096, %esi                     # imm = 0x1000
	movl	$3, %edx
	movl	$1, %ecx
	movq	%r9, %rdi
	callq	mmap@PLT
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	addq	$32, %rax
	movq	%rax, -96(%rbp)
	movl	-76(%rbp), %edi
	movl	-60(%rbp), %esi
	callq	attach_to_child
	movabsq	$l1_read_attr, %rdi
	callq	is_event_supported
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, (%rax)
	movabsq	$l1_write_attr, %rdi
	callq	is_event_supported
	movl	%eax, %ecx
	movq	-48(%rbp), %rax
	movl	%ecx, (%rax)
	movabsq	$icache_attr, %rdi
	callq	is_event_supported
	movl	%eax, %ecx
	movq	-56(%rbp), %rax
	movl	%ecx, (%rax)
	movq	$0, -104(%rbp)
	movl	$0, -108(%rbp)
	movl	$0, -112(%rbp)
.LBB8_2:                                # =>This Inner Loop Header: Depth=1
	cmpl	$1024, -112(%rbp)               # imm = 0x400
	jge	.LBB8_24
# %bb.3:                                #   in Loop: Header=BB8_2 Depth=1
	leaq	-116(%rbp), %rdi
	callq	wait@PLT
	movl	%eax, -76(%rbp)
	movl	-116(%rbp), %eax
	andl	$127, %eax
	cmpl	$0, %eax
	je	.LBB8_5
# %bb.4:                                #   in Loop: Header=BB8_2 Depth=1
	cmpl	$-1, -76(%rbp)
	jne	.LBB8_8
.LBB8_5:
	movl	-116(%rbp), %eax
	andl	$65280, %eax                    # imm = 0xFF00
	sarl	$8, %eax
	movl	%eax, -120(%rbp)
	cmpl	$0, -120(%rbp)
	jne	.LBB8_7
# %bb.6:
	movq	-96(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB8_38
.LBB8_7:
	movq	$0, -8(%rbp)
	jmp	.LBB8_38
.LBB8_8:                                #   in Loop: Header=BB8_2 Depth=1
	cmpl	$0, -108(%rbp)
	je	.LBB8_10
# %bb.9:
	jmp	.LBB8_24
.LBB8_10:                               #   in Loop: Header=BB8_2 Depth=1
	movl	-76(%rbp), %esi
	movl	$16898, %edi                    # imm = 0x4202
	xorl	%eax, %eax
	movl	%eax, %edx
	leaq	-248(%rbp), %rcx
	movb	$0, %al
	callq	ptrace@PLT
	movl	-76(%rbp), %esi
	movl	$12, %edi
	xorl	%eax, %eax
	movl	%eax, %edx
	leaq	-464(%rbp), %rcx
	movb	$0, %al
	callq	ptrace@PLT
	movq	-336(%rbp), %rsi
	movl	-248(%rbp), %edx
	movabsq	$.L.str.5, %rdi
	movb	$0, %al
	callq	printf@PLT
	movq	-312(%rbp), %rsi
	movabsq	$.L.str.6, %rdi
	movb	$0, %al
	callq	printf@PLT
	cmpl	$11, -248(%rbp)
	je	.LBB8_13
# %bb.11:                               #   in Loop: Header=BB8_2 Depth=1
	cmpl	$5, -248(%rbp)
	je	.LBB8_13
# %bb.12:
	jmp	.LBB8_24
.LBB8_13:                               #   in Loop: Header=BB8_2 Depth=1
	movq	-232(%rbp), %rax
	movq	%rax, -472(%rbp)
	movq	map_and_restart@GOTPCREL(%rip), %rax
	movq	%rax, -480(%rbp)
	cmpl	$5, -248(%rbp)
	jne	.LBB8_15
# %bb.14:                               #   in Loop: Header=BB8_2 Depth=1
	movl	$36847616, %eax                 # imm = 0x2324000
	movq	%rax, -472(%rbp)
.LBB8_15:                               #   in Loop: Header=BB8_2 Depth=1
	movq	-336(%rbp), %rax
	cmpq	-104(%rbp), %rax
	jne	.LBB8_17
# %bb.16:
	jmp	.LBB8_24
.LBB8_17:                               #   in Loop: Header=BB8_2 Depth=1
	movq	-336(%rbp), %rax
	movq	%rax, -104(%rbp)
	movq	-336(%rbp), %rax
	movq	first_legal_aux_mem_access@GOTPCREL(%rip), %rcx
	cmpq	%rcx, %rax
	jne	.LBB8_19
# %bb.18:                               #   in Loop: Header=BB8_2 Depth=1
	movl	$1, -108(%rbp)
	movq	map_aux_and_restart@GOTPCREL(%rip), %rax
	movq	%rax, -480(%rbp)
	jmp	.LBB8_22
.LBB8_19:                               #   in Loop: Header=BB8_2 Depth=1
	movabsq	$123145302310912, %rax          # imm = 0x700000000000
	cmpq	%rax, -472(%rbp)
	jne	.LBB8_21
# %bb.20:
	jmp	.LBB8_24
.LBB8_21:                               #   in Loop: Header=BB8_2 Depth=1
	jmp	.LBB8_22
.LBB8_22:                               #   in Loop: Header=BB8_2 Depth=1
	movl	-76(%rbp), %edi
	movq	-480(%rbp), %rsi
	movq	-472(%rbp), %rdx
	movl	16(%rbp), %ecx
	callq	restart_child
# %bb.23:                               #   in Loop: Header=BB8_2 Depth=1
	movl	-112(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -112(%rbp)
	jmp	.LBB8_2
.LBB8_24:
	movl	-76(%rbp), %edi
	movl	$9, %esi
	callq	kill@PLT
	movq	$0, -8(%rbp)
	jmp	.LBB8_38
.LBB8_25:
	movabsq	$l1_read_attr, %rdi
	leaq	-496(%rbp), %rsi
	xorl	%eax, %eax
	movl	%eax, %edx
	callq	rdpmc_open_attr@PLT
	movq	-488(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -500(%rbp)
	movq	-488(%rbp), %rax
	movl	12(%rax), %esi
	movabsq	$.L.str.7, %rdi
	movb	$0, %al
	callq	printf@PLT
	movabsq	$l1_write_attr, %rdi
	leaq	-496(%rbp), %rsi
	xorl	%eax, %eax
	movl	%eax, %edx
	callq	rdpmc_open_attr@PLT
	movq	-488(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -504(%rbp)
	movq	-488(%rbp), %rax
	movl	12(%rax), %esi
	movabsq	$.L.str.8, %rdi
	movb	$0, %al
	callq	printf@PLT
	movabsq	$icache_attr, %rdi
	leaq	-496(%rbp), %rsi
	xorl	%eax, %eax
	movl	%eax, %edx
	callq	rdpmc_open_attr@PLT
	movq	-488(%rbp), %rax
	movl	12(%rax), %eax
	subl	$1, %eax
	movl	%eax, -508(%rbp)
	movq	-488(%rbp), %rax
	movl	12(%rax), %esi
	movabsq	$.L.str.9, %rdi
	movb	$0, %al
	callq	printf@PLT
	movabsq	$ctx_swtch_attr, %rdi
	leaq	-496(%rbp), %rsi
	xorl	%eax, %eax
	movl	%eax, %edx
	callq	rdpmc_open_attr@PLT
	movl	%eax, -512(%rbp)
	cmpl	$0, -512(%rbp)
	je	.LBB8_27
# %bb.26:
	movabsq	$.L.str.10, %rdi
	movb	$0, %al
	callq	printf@PLT
	callq	abort@PLT
.LBB8_27:
	movl	-496(%rbp), %edi
	movl	$100, %esi
	callq	dup2@PLT
	movq	end_tmpl_end@GOTPCREL(%rip), %rax
	movq	end_tmpl_begin@GOTPCREL(%rip), %rcx
	subq	%rcx, %rax
	movq	%rax, -520(%rbp)
	movq	-24(%rbp), %rax
	movl	-28(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	imulq	%rcx, %rax
	addq	-520(%rbp), %rax
	addq	$5, %rax
	movq	%rax, -528(%rbp)
	movq	code_begin@GOTPCREL(%rip), %rdi
	callq	round_to_page_start
	movq	%rax, -536(%rbp)
	movq	code_end@GOTPCREL(%rip), %rdi
	addq	-528(%rbp), %rdi
	callq	round_to_next_page
	movq	%rax, -544(%rbp)
	callq	__errno_location@PLT
	movl	$0, (%rax)
	movq	-536(%rbp), %rdi
	movq	-544(%rbp), %rsi
	movq	-536(%rbp), %rax
	subq	%rax, %rsi
	movl	$3, %edx
	callq	mprotect@PLT
	movabsq	$.L.str.11, %rdi
	callq	perror@PLT
	movl	-500(%rbp), %esi
	movq	l1_read_misses_a@GOTPCREL(%rip), %rdi
	callq	emit_mov_rcx
	movl	-500(%rbp), %esi
	movq	l1_read_misses_b@GOTPCREL(%rip), %rdi
	callq	emit_mov_rcx
	movl	-504(%rbp), %esi
	movq	l1_write_misses_a@GOTPCREL(%rip), %rdi
	callq	emit_mov_rcx
	movl	-504(%rbp), %esi
	movq	l1_write_misses_b@GOTPCREL(%rip), %rdi
	callq	emit_mov_rcx
	movl	-508(%rbp), %esi
	movq	icache_misses_a@GOTPCREL(%rip), %rdi
	callq	emit_mov_rcx
	movl	-508(%rbp), %esi
	movq	icache_misses_b@GOTPCREL(%rip), %rdi
	callq	emit_mov_rcx
	movq	code_end@GOTPCREL(%rip), %rax
	movq	%rax, -552(%rbp)
	movl	$0, -556(%rbp)
.LBB8_28:                               # =>This Inner Loop Header: Depth=1
	movl	-556(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jae	.LBB8_31
# %bb.29:                               #   in Loop: Header=BB8_28 Depth=1
	movq	-552(%rbp), %rdi
	movq	-16(%rbp), %rsi
	movq	-24(%rbp), %rdx
	callq	memcpy@PLT
	movq	-24(%rbp), %rax
	addq	-552(%rbp), %rax
	movq	%rax, -552(%rbp)
# %bb.30:                               #   in Loop: Header=BB8_28 Depth=1
	movl	-556(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -556(%rbp)
	jmp	.LBB8_28
.LBB8_31:
	movq	-552(%rbp), %rdi
	movq	-520(%rbp), %rdx
	movq	end_tmpl_begin@GOTPCREL(%rip), %rsi
	callq	memcpy@PLT
	movq	-520(%rbp), %rax
	addq	-552(%rbp), %rax
	movq	%rax, -552(%rbp)
	movq	-552(%rbp), %rax
	movb	$-23, (%rax)
	movq	-528(%rbp), %rcx
	addq	$5, %rcx
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	subq	%rcx, %rax
	movl	%eax, %ecx
	movq	-552(%rbp), %rax
	movl	%ecx, 1(%rax)
	callq	__errno_location@PLT
	movl	$0, (%rax)
	movq	-536(%rbp), %rdi
	movq	-544(%rbp), %rsi
	movq	-536(%rbp), %rax
	subq	%rax, %rsi
	movl	$4, %edx
	callq	mprotect@PLT
	movabsq	$.L.str.11, %rdi
	callq	perror@PLT
	movl	-60(%rbp), %edi
	callq	close@PLT
	movl	-64(%rbp), %edi
	movabsq	$x, %rsi
	movl	$1, %edx
	callq	read@PLT
	movl	16(%rbp), %edi
	movl	$42, %esi
	callq	dup2@PLT
# %bb.32:
	leaq	-688(%rbp), %rdi
	xorl	%esi, %esi
	movl	$128, %edx
	callq	memset@PLT
# %bb.33:
	movq	$1, -696(%rbp)
	movq	-696(%rbp), %rax
	shrq	$3, %rax
	cmpq	$128, %rax
	jae	.LBB8_35
# %bb.34:
	movq	-696(%rbp), %rcx
	andq	$63, %rcx
	movl	$1, %eax
                                        # kill: def $cl killed $rcx
	shlq	%cl, %rax
	movq	-696(%rbp), %rcx
	shrq	$6, %rcx
	orq	-688(%rbp,%rcx,8), %rax
	movq	%rax, -688(%rbp,%rcx,8)
	movq	%rax, -712(%rbp)                # 8-byte Spill
	jmp	.LBB8_36
.LBB8_35:
	xorl	%eax, %eax
                                        # kill: def $rax killed $eax
	movq	%rax, -712(%rbp)                # 8-byte Spill
	jmp	.LBB8_36
.LBB8_36:
	movq	-712(%rbp), %rax                # 8-byte Reload
	movq	%rax, -704(%rbp)
	xorl	%edi, %edi
	movl	$128, %esi
	leaq	-688(%rbp), %rdx
	callq	sched_setaffinity@PLT
	xorl	%edx, %edx
	movl	%edx, %edi
	movl	%edx, %esi
	callq	setpriority@PLT
	movq	-528(%rbp), %rdi
	movb	$0, %al
	callq	run_test@PLT
# %bb.37:
	movq	$0, -8(%rbp)
.LBB8_38:
	movq	-8(%rbp), %rax
	addq	$720, %rsp                      # imm = 0x2D0
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	measure, .Lfunc_end8-measure
	.cfi_endproc
                                        # -- End function
	.type	l1_read_attr,@object            # @l1_read_attr
	.data
	.globl	l1_read_attr
	.p2align	3
l1_read_attr:
	.long	3                               # 0x3
	.long	64                              # 0x40
	.quad	65536                           # 0x10000
	.zero	8
	.quad	16                              # 0x10
	.quad	0                               # 0x0
	.byte	32                              # 0x20
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.zero	4
	.long	0                               # 0x0
	.zero	8
	.zero	8
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.size	l1_read_attr, 128

	.type	l1_write_attr,@object           # @l1_write_attr
	.globl	l1_write_attr
	.p2align	3
l1_write_attr:
	.long	3                               # 0x3
	.long	64                              # 0x40
	.quad	65792                           # 0x10100
	.zero	8
	.quad	16                              # 0x10
	.quad	0                               # 0x0
	.byte	32                              # 0x20
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.zero	4
	.long	0                               # 0x0
	.zero	8
	.zero	8
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.size	l1_write_attr, 128

	.type	icache_attr,@object             # @icache_attr
	.globl	icache_attr
	.p2align	3
icache_attr:
	.long	3                               # 0x3
	.long	64                              # 0x40
	.quad	65537                           # 0x10001
	.zero	8
	.quad	16                              # 0x10
	.quad	0                               # 0x0
	.byte	32                              # 0x20
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.zero	4
	.long	0                               # 0x0
	.zero	8
	.zero	8
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.size	icache_attr, 128

	.type	ctx_swtch_attr,@object          # @ctx_swtch_attr
	.globl	ctx_swtch_attr
	.p2align	3
ctx_swtch_attr:
	.long	1                               # 0x1
	.long	0                               # 0x0
	.quad	3                               # 0x3
	.zero	8
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.byte	0                               # 0x0
	.zero	4
	.long	0                               # 0x0
	.zero	8
	.zero	8
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.long	0                               # 0x0
	.short	0                               # 0x0
	.short	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
	.quad	0                               # 0x0
	.size	ctx_swtch_attr, 128

	.type	x,@object                       # @x
	.bss
	.globl	x
x:
	.byte	0                               # 0x0
	.size	x, 1

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"RESTARTING AT %p, fault addr = %p\n"
	.size	.L.str, 35

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"get regs"
	.size	.L.str.1, 9

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"set regs"
	.size	.L.str.2, 9

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"cont"
	.size	.L.str.3, 5

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"mmap aux mem"
	.size	.L.str.4, 13

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"bad inst is at %p, signal = %d\n"
	.size	.L.str.5, 32

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"VAL OF RSP = %p\n"
	.size	.L.str.6, 17

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"L1 READ IDX = %d\n"
	.size	.L.str.7, 18

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"L1 WRITE IDX = %d\n"
	.size	.L.str.8, 19

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"ICACHE IDX = %d\n"
	.size	.L.str.9, 17

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"unable to count context switches\n"
	.size	.L.str.10, 34

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"mprotect"
	.size	.L.str.11, 9

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1.1"
	.section	".note.GNU-stack","",@progbits
