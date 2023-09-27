; ModuleID = 'harness.c'
source_filename = "harness.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.anon = type { i64 }
%union.anon.0 = type { i32 }
%union.anon.1 = type { i64 }
%union.anon.2 = type { i64 }
%struct.perf_event_attr = type { i32, i32, i64, %union.anon, i64, i64, i64, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }
%struct.user_regs_struct = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }
%struct.rdpmc_ctx = type { i32, %struct.perf_event_mmap_page* }
%struct.perf_event_mmap_page = type { i32, i32, i32, i32, i64, i64, i64, %union.anon.3, i16, i16, i32, i64, i64, i32, i32, i64, i64, [928 x i8], i64, i64, i64, i64, i64, i64, i64, i64 }
%union.anon.3 = type { i64 }
%struct.pmc_counters = type { i64, i64, i64, i64, i64 }
%struct.siginfo_t = type { i32, i32, i32, i32, %union.anon.4 }
%union.anon.4 = type { %struct.anon.8, [80 x i8] }
%struct.anon.8 = type { i32, i32, i32, i64, i64 }
%struct.cpu_set_t = type { [16 x i64] }
%struct.anon.9 = type { i8*, i16, %union.anon.10 }
%union.anon.10 = type { %struct.anon.11 }
%struct.anon.11 = type { i8*, i8* }

@l1_read_attr = dso_local global { i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 } { i32 3, i32 64, i64 65536, %union.anon zeroinitializer, i64 16, i64 0, i8 32, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, %union.anon.0 zeroinitializer, i32 0, %union.anon.1 zeroinitializer, %union.anon.2 zeroinitializer, i64 0, i64 0, i32 0, i32 0, i64 0, i32 0, i16 0, i16 0, i32 0, i32 0, i64 0 }, align 8
@l1_write_attr = dso_local global { i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 } { i32 3, i32 64, i64 65792, %union.anon zeroinitializer, i64 16, i64 0, i8 32, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, %union.anon.0 zeroinitializer, i32 0, %union.anon.1 zeroinitializer, %union.anon.2 zeroinitializer, i64 0, i64 0, i32 0, i32 0, i64 0, i32 0, i16 0, i16 0, i32 0, i32 0, i64 0 }, align 8
@icache_attr = dso_local global { i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 } { i32 3, i32 64, i64 65537, %union.anon zeroinitializer, i64 16, i64 0, i8 32, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, %union.anon.0 zeroinitializer, i32 0, %union.anon.1 zeroinitializer, %union.anon.2 zeroinitializer, i64 0, i64 0, i32 0, i32 0, i64 0, i32 0, i16 0, i16 0, i32 0, i32 0, i64 0 }, align 8
@ctx_swtch_attr = dso_local global { i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 } { i32 1, i32 0, i64 3, %union.anon zeroinitializer, i64 0, i64 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, %union.anon.0 zeroinitializer, i32 0, %union.anon.1 zeroinitializer, %union.anon.2 zeroinitializer, i64 0, i64 0, i32 0, i32 0, i64 0, i32 0, i16 0, i16 0, i32 0, i32 0, i64 0 }, align 8
@x = dso_local global i8 0, align 1
@.str = private unnamed_addr constant [35 x i8] c"RESTARTING AT %p, fault addr = %p\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"get regs\00", align 1
@.str.2 = private unnamed_addr constant [9 x i8] c"set regs\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"cont\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"mmap aux mem\00", align 1
@.str.5 = private unnamed_addr constant [32 x i8] c"bad inst is at %p, signal = %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"VAL OF RSP = %p\0A\00", align 1
@first_legal_aux_mem_access = external global [0 x i8], align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"L1 READ IDX = %d\0A\00", align 1
@.str.8 = private unnamed_addr constant [19 x i8] c"L1 WRITE IDX = %d\0A\00", align 1
@.str.9 = private unnamed_addr constant [17 x i8] c"ICACHE IDX = %d\0A\00", align 1
@.str.10 = private unnamed_addr constant [34 x i8] c"unable to count context switches\0A\00", align 1
@end_tmpl_end = external global [0 x i8], align 1
@end_tmpl_begin = external global [0 x i8], align 1
@code_begin = external global [0 x i8], align 1
@code_end = external global [0 x i8], align 1
@.str.11 = private unnamed_addr constant [9 x i8] c"mprotect\00", align 1
@l1_read_misses_a = external global [0 x i8], align 1
@l1_read_misses_b = external global [0 x i8], align 1
@l1_write_misses_a = external global [0 x i8], align 1
@l1_write_misses_b = external global [0 x i8], align 1
@icache_misses_a = external global [0 x i8], align 1
@icache_misses_b = external global [0 x i8], align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @round_to_page_start(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = ptrtoint i8* %3 to i64
  %5 = lshr i64 %4, 12
  %6 = shl i64 %5, 12
  %7 = inttoptr i64 %6 to i8*
  ret i8* %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @round_to_next_page(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = ptrtoint i8* %3 to i64
  %5 = add i64 %4, 4096
  %6 = lshr i64 %5, 12
  %7 = shl i64 %6, 12
  %8 = inttoptr i64 %7 to i8*
  ret i8* %8
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @attach_to_child(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = call i64 (i32, ...) @ptrace(i32 noundef 16902, i32 noundef %5, i8* noundef null, i8* noundef null) #7
  %7 = load i32, i32* %4, align 4
  %8 = call i64 @write(i32 noundef %7, i8* noundef @x, i64 noundef 1)
  %9 = load i32, i32* %4, align 4
  %10 = call i32 @close(i32 noundef %9)
  ret void
}

; Function Attrs: nounwind
declare i64 @ptrace(i32 noundef, ...) #1

declare i64 @write(i32 noundef, i8* noundef, i64 noundef) #2

declare i32 @close(i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @create_shm_fd(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  %4 = load i8*, i8** %2, align 8
  %5 = call i32 @shm_open(i8* noundef %4, i32 noundef 66, i32 noundef 511)
  store i32 %5, i32* %3, align 4
  %6 = load i8*, i8** %2, align 8
  %7 = call i32 @shm_unlink(i8* noundef %6)
  %8 = load i32, i32* %3, align 4
  %9 = call i32 @ftruncate(i32 noundef %8, i64 noundef 12288) #7
  %10 = load i32, i32* %3, align 4
  ret i32 %10
}

declare i32 @shm_open(i8* noundef, i32 noundef, i32 noundef) #2

declare i32 @shm_unlink(i8* noundef) #2

; Function Attrs: nounwind
declare i32 @ftruncate(i32 noundef, i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @perf_event_open(%struct.perf_event_attr* noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i64 noundef %4) #0 {
  %6 = alloca %struct.perf_event_attr*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  store %struct.perf_event_attr* %0, %struct.perf_event_attr** %6, align 8
  store i32 %1, i32* %7, align 4
  store i32 %2, i32* %8, align 4
  store i32 %3, i32* %9, align 4
  store i64 %4, i64* %10, align 8
  %11 = load %struct.perf_event_attr*, %struct.perf_event_attr** %6, align 8
  %12 = load i32, i32* %7, align 4
  %13 = load i32, i32* %8, align 4
  %14 = load i32, i32* %9, align 4
  %15 = load i64, i64* %10, align 8
  %16 = call i64 (i64, ...) @syscall(i64 noundef 298, %struct.perf_event_attr* noundef %11, i32 noundef %12, i32 noundef %13, i32 noundef %14, i64 noundef %15) #7
  %17 = trunc i64 %16 to i32
  ret i32 %17
}

; Function Attrs: nounwind
declare i64 @syscall(i64 noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @restart_child(i32 noundef %0, i8* noundef %1, i8* noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.user_regs_struct, align 8
  store i32 %0, i32* %5, align 4
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  store i32 %3, i32* %8, align 4
  %10 = load i8*, i8** %6, align 8
  %11 = load i8*, i8** %7, align 8
  %12 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([35 x i8], [35 x i8]* @.str, i64 0, i64 0), i8* noundef %10, i8* noundef %11)
  %13 = load i32, i32* %5, align 4
  %14 = call i64 (i32, ...) @ptrace(i32 noundef 12, i32 noundef %13, i8* noundef null, %struct.user_regs_struct* noundef %9) #7
  call void @perror(i8* noundef getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0))
  %15 = load i8*, i8** %6, align 8
  %16 = ptrtoint i8* %15 to i64
  %17 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %9, i32 0, i32 16
  store i64 %16, i64* %17, align 8
  %18 = load i8*, i8** %7, align 8
  %19 = ptrtoint i8* %18 to i64
  %20 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %9, i32 0, i32 10
  store i64 %19, i64* %20, align 8
  %21 = load i32, i32* %8, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %9, i32 0, i32 6
  store i64 %22, i64* %23, align 8
  %24 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %9, i32 0, i32 3
  store i64 1, i64* %24, align 8
  %25 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %9, i32 0, i32 2
  store i64 3, i64* %25, align 8
  %26 = load i32, i32* %5, align 4
  %27 = call i64 (i32, ...) @ptrace(i32 noundef 13, i32 noundef %26, i8* noundef null, %struct.user_regs_struct* noundef %9) #7
  call void @perror(i8* noundef getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0))
  %28 = load i32, i32* %5, align 4
  %29 = call i64 (i32, ...) @ptrace(i32 noundef 7, i32 noundef %28, i8* noundef null, i8* noundef null) #7
  call void @perror(i8* noundef getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i64 0, i64 0))
  ret void
}

declare i32 @printf(i8* noundef, ...) #2

declare void @perror(i8* noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @emit_mov_rcx(i8* noundef %0, i32 noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = icmp slt i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %21

8:                                                ; preds = %2
  %9 = load i8*, i8** %3, align 8
  %10 = getelementptr inbounds i8, i8* %9, i64 0
  store i8 -71, i8* %10, align 1
  %11 = load i32, i32* %4, align 4
  %12 = trunc i32 %11 to i8
  %13 = load i8*, i8** %3, align 8
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  store i8 %12, i8* %14, align 1
  %15 = load i8*, i8** %3, align 8
  %16 = getelementptr inbounds i8, i8* %15, i64 2
  store i8 0, i8* %16, align 1
  %17 = load i8*, i8** %3, align 8
  %18 = getelementptr inbounds i8, i8* %17, i64 3
  store i8 0, i8* %18, align 1
  %19 = load i8*, i8** %3, align 8
  %20 = getelementptr inbounds i8, i8* %19, i64 4
  store i8 0, i8* %20, align 1
  br label %21

21:                                               ; preds = %8, %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @is_event_supported(%struct.perf_event_attr* noundef %0) #0 {
  %2 = alloca %struct.perf_event_attr*, align 8
  %3 = alloca %struct.rdpmc_ctx, align 8
  %4 = alloca i32, align 4
  store %struct.perf_event_attr* %0, %struct.perf_event_attr** %2, align 8
  %5 = load %struct.perf_event_attr*, %struct.perf_event_attr** %2, align 8
  %6 = call i32 @rdpmc_open_attr(%struct.perf_event_attr* noundef %5, %struct.rdpmc_ctx* noundef %3, %struct.rdpmc_ctx* noundef null)
  %7 = icmp ne i32 %6, 0
  %8 = xor i1 %7, true
  %9 = zext i1 %8 to i32
  store i32 %9, i32* %4, align 4
  call void @rdpmc_close(%struct.rdpmc_ctx* noundef %3)
  %10 = load i32, i32* %4, align 4
  ret i32 %10
}

declare i32 @rdpmc_open_attr(%struct.perf_event_attr* noundef, %struct.rdpmc_ctx* noundef, %struct.rdpmc_ctx* noundef) #2

declare void @rdpmc_close(%struct.rdpmc_ctx* noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.pmc_counters* @measure(i8* noundef %0, i64 noundef %1, i32 noundef %2, i32* noundef %3, i32* noundef %4, i32* noundef %5, i32 noundef %6) #0 {
  %8 = alloca %struct.pmc_counters*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32*, align 8
  %13 = alloca i32*, align 8
  %14 = alloca i32*, align 8
  %15 = alloca i32, align 4
  %16 = alloca [2 x i32], align 4
  %17 = alloca i8*, align 8
  %18 = alloca i32, align 4
  %19 = alloca i8*, align 8
  %20 = alloca %struct.pmc_counters*, align 8
  %21 = alloca i8*, align 8
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca %struct.siginfo_t, align 8
  %27 = alloca %struct.user_regs_struct, align 8
  %28 = alloca i8*, align 8
  %29 = alloca i8*, align 8
  %30 = alloca %struct.rdpmc_ctx, align 8
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i64, align 8
  %36 = alloca i64, align 8
  %37 = alloca i8*, align 8
  %38 = alloca i8*, align 8
  %39 = alloca i8*, align 8
  %40 = alloca i32, align 4
  %41 = alloca %struct.cpu_set_t, align 8
  %42 = alloca i64, align 8
  %43 = alloca i64, align 8
  store i8* %0, i8** %9, align 8
  store i64 %1, i64* %10, align 8
  store i32 %2, i32* %11, align 4
  store i32* %3, i32** %12, align 8
  store i32* %4, i32** %13, align 8
  store i32* %5, i32** %14, align 8
  store i32 %6, i32* %15, align 4
  %44 = getelementptr inbounds [2 x i32], [2 x i32]* %16, i64 0, i64 0
  %45 = call i32 @pipe(i32* noundef %44) #7
  %46 = load i32, i32* %15, align 4
  %47 = call i8* @mmap(i8* noundef null, i64 noundef 8192, i32 noundef 3, i32 noundef 1, i32 noundef %46, i64 noundef 4096) #7
  store i8* %47, i8** %17, align 8
  call void @perror(i8* noundef getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0))
  %48 = load i8*, i8** %17, align 8
  call void @llvm.memset.p0i8.i64(i8* align 1 %48, i8 0, i64 8192, i1 false)
  %49 = call i32 @fork() #7
  store i32 %49, i32* %18, align 4
  %50 = load i32, i32* %18, align 4
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %158

52:                                               ; preds = %7
  %53 = getelementptr inbounds [2 x i32], [2 x i32]* %16, i64 0, i64 0
  %54 = load i32, i32* %53, align 4
  %55 = call i32 @close(i32 noundef %54)
  %56 = load i32, i32* %15, align 4
  %57 = call i8* @mmap(i8* noundef null, i64 noundef 4096, i32 noundef 3, i32 noundef 1, i32 noundef %56, i64 noundef 0) #7
  store i8* %57, i8** %19, align 8
  %58 = load i8*, i8** %17, align 8
  %59 = getelementptr inbounds i8, i8* %58, i64 32
  %60 = bitcast i8* %59 to %struct.pmc_counters*
  store %struct.pmc_counters* %60, %struct.pmc_counters** %20, align 8
  %61 = load i32, i32* %18, align 4
  %62 = getelementptr inbounds [2 x i32], [2 x i32]* %16, i64 0, i64 1
  %63 = load i32, i32* %62, align 4
  call void @attach_to_child(i32 noundef %61, i32 noundef %63)
  %64 = call i32 @is_event_supported(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @l1_read_attr to %struct.perf_event_attr*))
  %65 = load i32*, i32** %12, align 8
  store i32 %64, i32* %65, align 4
  %66 = call i32 @is_event_supported(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @l1_write_attr to %struct.perf_event_attr*))
  %67 = load i32*, i32** %13, align 8
  store i32 %66, i32* %67, align 4
  %68 = call i32 @is_event_supported(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @icache_attr to %struct.perf_event_attr*))
  %69 = load i32*, i32** %14, align 8
  store i32 %68, i32* %69, align 4
  store i8* null, i8** %21, align 8
  store i32 0, i32* %22, align 4
  store i32 0, i32* %23, align 4
  br label %70

70:                                               ; preds = %152, %52
  %71 = load i32, i32* %23, align 4
  %72 = icmp slt i32 %71, 1024
  br i1 %72, label %73, label %155

73:                                               ; preds = %70
  %74 = call i32 @wait(i32* noundef %24)
  store i32 %74, i32* %18, align 4
  %75 = load i32, i32* %24, align 4
  %76 = and i32 %75, 127
  %77 = icmp eq i32 %76, 0
  br i1 %77, label %81, label %78

78:                                               ; preds = %73
  %79 = load i32, i32* %18, align 4
  %80 = icmp eq i32 %79, -1
  br i1 %80, label %81, label %90

81:                                               ; preds = %78, %73
  %82 = load i32, i32* %24, align 4
  %83 = and i32 %82, 65280
  %84 = ashr i32 %83, 8
  store i32 %84, i32* %25, align 4
  %85 = load i32, i32* %25, align 4
  %86 = icmp eq i32 %85, 0
  br i1 %86, label %87, label %89

87:                                               ; preds = %81
  %88 = load %struct.pmc_counters*, %struct.pmc_counters** %20, align 8
  store %struct.pmc_counters* %88, %struct.pmc_counters** %8, align 8
  br label %295

89:                                               ; preds = %81
  store %struct.pmc_counters* null, %struct.pmc_counters** %8, align 8
  br label %295

90:                                               ; preds = %78
  %91 = load i32, i32* %22, align 4
  %92 = icmp ne i32 %91, 0
  br i1 %92, label %93, label %94

93:                                               ; preds = %90
  br label %155

94:                                               ; preds = %90
  %95 = load i32, i32* %18, align 4
  %96 = call i64 (i32, ...) @ptrace(i32 noundef 16898, i32 noundef %95, i8* noundef null, %struct.siginfo_t* noundef %26) #7
  %97 = load i32, i32* %18, align 4
  %98 = call i64 (i32, ...) @ptrace(i32 noundef 12, i32 noundef %97, i8* noundef null, %struct.user_regs_struct* noundef %27) #7
  %99 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %27, i32 0, i32 16
  %100 = load i64, i64* %99, align 8
  %101 = inttoptr i64 %100 to i8*
  %102 = getelementptr inbounds %struct.siginfo_t, %struct.siginfo_t* %26, i32 0, i32 0
  %103 = load i32, i32* %102, align 8
  %104 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([32 x i8], [32 x i8]* @.str.5, i64 0, i64 0), i8* noundef %101, i32 noundef %103)
  %105 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %27, i32 0, i32 19
  %106 = load i64, i64* %105, align 8
  %107 = inttoptr i64 %106 to i8*
  %108 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.6, i64 0, i64 0), i8* noundef %107)
  %109 = getelementptr inbounds %struct.siginfo_t, %struct.siginfo_t* %26, i32 0, i32 0
  %110 = load i32, i32* %109, align 8
  %111 = icmp ne i32 %110, 11
  br i1 %111, label %112, label %117

112:                                              ; preds = %94
  %113 = getelementptr inbounds %struct.siginfo_t, %struct.siginfo_t* %26, i32 0, i32 0
  %114 = load i32, i32* %113, align 8
  %115 = icmp ne i32 %114, 5
  br i1 %115, label %116, label %117

116:                                              ; preds = %112
  br label %155

117:                                              ; preds = %112, %94
  %118 = getelementptr inbounds %struct.siginfo_t, %struct.siginfo_t* %26, i32 0, i32 4
  %119 = bitcast %union.anon.4* %118 to %struct.anon.9*
  %120 = getelementptr inbounds %struct.anon.9, %struct.anon.9* %119, i32 0, i32 0
  %121 = load i8*, i8** %120, align 8
  store i8* %121, i8** %28, align 8
  store i8* bitcast (void (...)* @map_and_restart to i8*), i8** %29, align 8
  %122 = getelementptr inbounds %struct.siginfo_t, %struct.siginfo_t* %26, i32 0, i32 0
  %123 = load i32, i32* %122, align 8
  %124 = icmp eq i32 %123, 5
  br i1 %124, label %125, label %126

125:                                              ; preds = %117
  store i8* inttoptr (i64 36847616 to i8*), i8** %28, align 8
  br label %126

126:                                              ; preds = %125, %117
  %127 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %27, i32 0, i32 16
  %128 = load i64, i64* %127, align 8
  %129 = inttoptr i64 %128 to i8*
  %130 = load i8*, i8** %21, align 8
  %131 = icmp eq i8* %129, %130
  br i1 %131, label %132, label %133

132:                                              ; preds = %126
  br label %155

133:                                              ; preds = %126
  %134 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %27, i32 0, i32 16
  %135 = load i64, i64* %134, align 8
  %136 = inttoptr i64 %135 to i8*
  store i8* %136, i8** %21, align 8
  %137 = getelementptr inbounds %struct.user_regs_struct, %struct.user_regs_struct* %27, i32 0, i32 16
  %138 = load i64, i64* %137, align 8
  %139 = inttoptr i64 %138 to i8*
  %140 = icmp eq i8* %139, getelementptr inbounds ([0 x i8], [0 x i8]* @first_legal_aux_mem_access, i64 0, i64 0)
  br i1 %140, label %141, label %142

141:                                              ; preds = %133
  store i32 1, i32* %22, align 4
  store i8* bitcast (void (...)* @map_aux_and_restart to i8*), i8** %29, align 8
  br label %147

142:                                              ; preds = %133
  %143 = load i8*, i8** %28, align 8
  %144 = icmp eq i8* %143, inttoptr (i64 123145302310912 to i8*)
  br i1 %144, label %145, label %146

145:                                              ; preds = %142
  br label %155

146:                                              ; preds = %142
  br label %147

147:                                              ; preds = %146, %141
  %148 = load i32, i32* %18, align 4
  %149 = load i8*, i8** %29, align 8
  %150 = load i8*, i8** %28, align 8
  %151 = load i32, i32* %15, align 4
  call void @restart_child(i32 noundef %148, i8* noundef %149, i8* noundef %150, i32 noundef %151)
  br label %152

152:                                              ; preds = %147
  %153 = load i32, i32* %23, align 4
  %154 = add nsw i32 %153, 1
  store i32 %154, i32* %23, align 4
  br label %70, !llvm.loop !6

155:                                              ; preds = %145, %132, %116, %93, %70
  %156 = load i32, i32* %18, align 4
  %157 = call i32 @kill(i32 noundef %156, i32 noundef 9) #7
  store %struct.pmc_counters* null, %struct.pmc_counters** %8, align 8
  br label %295

158:                                              ; preds = %7
  %159 = call i32 @rdpmc_open_attr(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @l1_read_attr to %struct.perf_event_attr*), %struct.rdpmc_ctx* noundef %30, %struct.rdpmc_ctx* noundef null)
  %160 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 1
  %161 = load %struct.perf_event_mmap_page*, %struct.perf_event_mmap_page** %160, align 8
  %162 = getelementptr inbounds %struct.perf_event_mmap_page, %struct.perf_event_mmap_page* %161, i32 0, i32 3
  %163 = load i32, i32* %162, align 4
  %164 = sub i32 %163, 1
  store i32 %164, i32* %31, align 4
  %165 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 1
  %166 = load %struct.perf_event_mmap_page*, %struct.perf_event_mmap_page** %165, align 8
  %167 = getelementptr inbounds %struct.perf_event_mmap_page, %struct.perf_event_mmap_page* %166, i32 0, i32 3
  %168 = load i32, i32* %167, align 4
  %169 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([18 x i8], [18 x i8]* @.str.7, i64 0, i64 0), i32 noundef %168)
  %170 = call i32 @rdpmc_open_attr(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @l1_write_attr to %struct.perf_event_attr*), %struct.rdpmc_ctx* noundef %30, %struct.rdpmc_ctx* noundef null)
  %171 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 1
  %172 = load %struct.perf_event_mmap_page*, %struct.perf_event_mmap_page** %171, align 8
  %173 = getelementptr inbounds %struct.perf_event_mmap_page, %struct.perf_event_mmap_page* %172, i32 0, i32 3
  %174 = load i32, i32* %173, align 4
  %175 = sub i32 %174, 1
  store i32 %175, i32* %32, align 4
  %176 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 1
  %177 = load %struct.perf_event_mmap_page*, %struct.perf_event_mmap_page** %176, align 8
  %178 = getelementptr inbounds %struct.perf_event_mmap_page, %struct.perf_event_mmap_page* %177, i32 0, i32 3
  %179 = load i32, i32* %178, align 4
  %180 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([19 x i8], [19 x i8]* @.str.8, i64 0, i64 0), i32 noundef %179)
  %181 = call i32 @rdpmc_open_attr(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @icache_attr to %struct.perf_event_attr*), %struct.rdpmc_ctx* noundef %30, %struct.rdpmc_ctx* noundef null)
  %182 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 1
  %183 = load %struct.perf_event_mmap_page*, %struct.perf_event_mmap_page** %182, align 8
  %184 = getelementptr inbounds %struct.perf_event_mmap_page, %struct.perf_event_mmap_page* %183, i32 0, i32 3
  %185 = load i32, i32* %184, align 4
  %186 = sub i32 %185, 1
  store i32 %186, i32* %33, align 4
  %187 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 1
  %188 = load %struct.perf_event_mmap_page*, %struct.perf_event_mmap_page** %187, align 8
  %189 = getelementptr inbounds %struct.perf_event_mmap_page, %struct.perf_event_mmap_page* %188, i32 0, i32 3
  %190 = load i32, i32* %189, align 4
  %191 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.9, i64 0, i64 0), i32 noundef %190)
  %192 = call i32 @rdpmc_open_attr(%struct.perf_event_attr* noundef bitcast ({ i32, i32, i64, %union.anon, i64, i64, i8, i8, i8, i8, i8, i8, i8, i8, %union.anon.0, i32, %union.anon.1, %union.anon.2, i64, i64, i32, i32, i64, i32, i16, i16, i32, i32, i64 }* @ctx_swtch_attr to %struct.perf_event_attr*), %struct.rdpmc_ctx* noundef %30, %struct.rdpmc_ctx* noundef null)
  store i32 %192, i32* %34, align 4
  %193 = load i32, i32* %34, align 4
  %194 = icmp ne i32 %193, 0
  br i1 %194, label %195, label %197

195:                                              ; preds = %158
  %196 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([34 x i8], [34 x i8]* @.str.10, i64 0, i64 0))
  call void @abort() #8
  unreachable

197:                                              ; preds = %158
  %198 = getelementptr inbounds %struct.rdpmc_ctx, %struct.rdpmc_ctx* %30, i32 0, i32 0
  %199 = load i32, i32* %198, align 8
  %200 = call i32 @dup2(i32 noundef %199, i32 noundef 100) #7
  store i64 sub (i64 ptrtoint ([0 x i8]* @end_tmpl_end to i64), i64 ptrtoint ([0 x i8]* @end_tmpl_begin to i64)), i64* %35, align 8
  %201 = load i64, i64* %10, align 8
  %202 = load i32, i32* %11, align 4
  %203 = zext i32 %202 to i64
  %204 = mul i64 %201, %203
  %205 = load i64, i64* %35, align 8
  %206 = add i64 %204, %205
  %207 = add i64 %206, 5
  store i64 %207, i64* %36, align 8
  %208 = call i8* @round_to_page_start(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @code_begin, i64 0, i64 0))
  store i8* %208, i8** %37, align 8
  %209 = load i64, i64* %36, align 8
  %210 = getelementptr inbounds i8, i8* getelementptr inbounds ([0 x i8], [0 x i8]* @code_end, i64 0, i64 0), i64 %209
  %211 = call i8* @round_to_next_page(i8* noundef %210)
  store i8* %211, i8** %38, align 8
  %212 = call i32* @__errno_location() #9
  store i32 0, i32* %212, align 4
  %213 = load i8*, i8** %37, align 8
  %214 = load i8*, i8** %38, align 8
  %215 = load i8*, i8** %37, align 8
  %216 = ptrtoint i8* %214 to i64
  %217 = ptrtoint i8* %215 to i64
  %218 = sub i64 %216, %217
  %219 = call i32 @mprotect(i8* noundef %213, i64 noundef %218, i32 noundef 3) #7
  call void @perror(i8* noundef getelementptr inbounds ([9 x i8], [9 x i8]* @.str.11, i64 0, i64 0))
  %220 = load i32, i32* %31, align 4
  call void @emit_mov_rcx(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @l1_read_misses_a, i64 0, i64 0), i32 noundef %220)
  %221 = load i32, i32* %31, align 4
  call void @emit_mov_rcx(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @l1_read_misses_b, i64 0, i64 0), i32 noundef %221)
  %222 = load i32, i32* %32, align 4
  call void @emit_mov_rcx(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @l1_write_misses_a, i64 0, i64 0), i32 noundef %222)
  %223 = load i32, i32* %32, align 4
  call void @emit_mov_rcx(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @l1_write_misses_b, i64 0, i64 0), i32 noundef %223)
  %224 = load i32, i32* %33, align 4
  call void @emit_mov_rcx(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @icache_misses_a, i64 0, i64 0), i32 noundef %224)
  %225 = load i32, i32* %33, align 4
  call void @emit_mov_rcx(i8* noundef getelementptr inbounds ([0 x i8], [0 x i8]* @icache_misses_b, i64 0, i64 0), i32 noundef %225)
  store i8* getelementptr inbounds ([0 x i8], [0 x i8]* @code_end, i64 0, i64 0), i8** %39, align 8
  store i32 0, i32* %40, align 4
  br label %226

226:                                              ; preds = %237, %197
  %227 = load i32, i32* %40, align 4
  %228 = load i32, i32* %11, align 4
  %229 = icmp ult i32 %227, %228
  br i1 %229, label %230, label %240

230:                                              ; preds = %226
  %231 = load i8*, i8** %39, align 8
  %232 = load i8*, i8** %9, align 8
  %233 = load i64, i64* %10, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %231, i8* align 1 %232, i64 %233, i1 false)
  %234 = load i64, i64* %10, align 8
  %235 = load i8*, i8** %39, align 8
  %236 = getelementptr inbounds i8, i8* %235, i64 %234
  store i8* %236, i8** %39, align 8
  br label %237

237:                                              ; preds = %230
  %238 = load i32, i32* %40, align 4
  %239 = add nsw i32 %238, 1
  store i32 %239, i32* %40, align 4
  br label %226, !llvm.loop !8

240:                                              ; preds = %226
  %241 = load i8*, i8** %39, align 8
  %242 = load i64, i64* %35, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %241, i8* align 1 getelementptr inbounds ([0 x i8], [0 x i8]* @end_tmpl_begin, i64 0, i64 0), i64 %242, i1 false)
  %243 = load i64, i64* %35, align 8
  %244 = load i8*, i8** %39, align 8
  %245 = getelementptr inbounds i8, i8* %244, i64 %243
  store i8* %245, i8** %39, align 8
  %246 = load i8*, i8** %39, align 8
  store i8 -23, i8* %246, align 1
  %247 = load i64, i64* %36, align 8
  %248 = add i64 %247, 5
  %249 = sub i64 0, %248
  %250 = trunc i64 %249 to i32
  %251 = load i8*, i8** %39, align 8
  %252 = getelementptr inbounds i8, i8* %251, i64 1
  %253 = bitcast i8* %252 to i32*
  store i32 %250, i32* %253, align 4
  %254 = call i32* @__errno_location() #9
  store i32 0, i32* %254, align 4
  %255 = load i8*, i8** %37, align 8
  %256 = load i8*, i8** %38, align 8
  %257 = load i8*, i8** %37, align 8
  %258 = ptrtoint i8* %256 to i64
  %259 = ptrtoint i8* %257 to i64
  %260 = sub i64 %258, %259
  %261 = call i32 @mprotect(i8* noundef %255, i64 noundef %260, i32 noundef 4) #7
  call void @perror(i8* noundef getelementptr inbounds ([9 x i8], [9 x i8]* @.str.11, i64 0, i64 0))
  %262 = getelementptr inbounds [2 x i32], [2 x i32]* %16, i64 0, i64 1
  %263 = load i32, i32* %262, align 4
  %264 = call i32 @close(i32 noundef %263)
  %265 = getelementptr inbounds [2 x i32], [2 x i32]* %16, i64 0, i64 0
  %266 = load i32, i32* %265, align 4
  %267 = call i64 @read(i32 noundef %266, i8* noundef @x, i64 noundef 1)
  %268 = load i32, i32* %15, align 4
  %269 = call i32 @dup2(i32 noundef %268, i32 noundef 42) #7
  br label %270

270:                                              ; preds = %240
  %271 = bitcast %struct.cpu_set_t* %41 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %271, i8 0, i64 128, i1 false)
  br label %272

272:                                              ; preds = %270
  store i64 1, i64* %42, align 8
  %273 = load i64, i64* %42, align 8
  %274 = udiv i64 %273, 8
  %275 = icmp ult i64 %274, 128
  br i1 %275, label %276, label %287

276:                                              ; preds = %272
  %277 = load i64, i64* %42, align 8
  %278 = urem i64 %277, 64
  %279 = shl i64 1, %278
  %280 = getelementptr inbounds %struct.cpu_set_t, %struct.cpu_set_t* %41, i32 0, i32 0
  %281 = getelementptr inbounds [16 x i64], [16 x i64]* %280, i64 0, i64 0
  %282 = load i64, i64* %42, align 8
  %283 = udiv i64 %282, 64
  %284 = getelementptr inbounds i64, i64* %281, i64 %283
  %285 = load i64, i64* %284, align 8
  %286 = or i64 %285, %279
  store i64 %286, i64* %284, align 8
  br label %288

287:                                              ; preds = %272
  br label %288

288:                                              ; preds = %287, %276
  %289 = phi i64 [ %286, %276 ], [ 0, %287 ]
  store i64 %289, i64* %43, align 8
  %290 = load i64, i64* %43, align 8
  %291 = call i32 @sched_setaffinity(i32 noundef 0, i64 noundef 128, %struct.cpu_set_t* noundef %41) #7
  %292 = call i32 @setpriority(i32 noundef 0, i32 noundef 0, i32 noundef 0) #7
  %293 = load i64, i64* %36, align 8
  call void (i64, ...) bitcast (void (...)* @run_test to void (i64, ...)*)(i64 noundef %293)
  br label %294

294:                                              ; preds = %288
  store %struct.pmc_counters* null, %struct.pmc_counters** %8, align 8
  br label %295

295:                                              ; preds = %294, %155, %89, %87
  %296 = load %struct.pmc_counters*, %struct.pmc_counters** %8, align 8
  ret %struct.pmc_counters* %296
}

; Function Attrs: nounwind
declare i32 @pipe(i32* noundef) #1

; Function Attrs: nounwind
declare i8* @mmap(i8* noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) #1

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: nounwind
declare i32 @fork() #1

declare i32 @wait(i32* noundef) #2

declare void @map_and_restart(...) #2

declare void @map_aux_and_restart(...) #2

; Function Attrs: nounwind
declare i32 @kill(i32 noundef, i32 noundef) #1

; Function Attrs: noreturn nounwind
declare void @abort() #4

; Function Attrs: nounwind
declare i32 @dup2(i32 noundef, i32 noundef) #1

; Function Attrs: nounwind readnone willreturn
declare i32* @__errno_location() #5

; Function Attrs: nounwind
declare i32 @mprotect(i8* noundef, i64 noundef, i32 noundef) #1

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

declare i64 @read(i32 noundef, i8* noundef, i64 noundef) #2

; Function Attrs: nounwind
declare i32 @sched_setaffinity(i32 noundef, i64 noundef, %struct.cpu_set_t* noundef) #1

; Function Attrs: nounwind
declare i32 @setpriority(i32 noundef, i32 noundef, i32 noundef) #1

declare void @run_test(...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nofree nounwind willreturn writeonly }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind readnone willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { argmemonly nofree nounwind willreturn }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
