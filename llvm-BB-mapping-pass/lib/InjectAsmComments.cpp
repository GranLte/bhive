
#include "InjectAsmComments.h"

#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/ADT/DenseSet.h"

using namespace llvm;

#define DEBUG_TYPE "inject-asm-comments"

//-----------------------------------------------------------------------------
// InjectAsmComments implementation
//-----------------------------------------------------------------------------
bool InjectAsmComments::runOnModule(Module &M) {
  // ----------------------------------------------------------------
  DenseSet<BasicBlock *> Visited;
  for (auto &F : M) {
    if (F.isDeclaration())
      continue;

    for (BasicBlock &BB : F) {
        if (Visited.count(&BB)) continue;
        Visited.insert(&BB);
        BB.setName("BB_" + Twine(BBNum++));  // e.g., BB_0, BB_1, BB_2, ...
        }
  }
  return false;
}

PreservedAnalyses InjectAsmComments::run(llvm::Module &M,
                                       llvm::ModuleAnalysisManager &) {
  bool Changed =  runOnModule(M);

  return (Changed ? llvm::PreservedAnalyses::none()
                  : llvm::PreservedAnalyses::all());
}


//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getInjectFuncCallPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "inject-asm-comments", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "inject-asm-comments") {
                    MPM.addPass(InjectAsmComments());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getInjectFuncCallPluginInfo();
}

