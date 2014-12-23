Verilog HDL Basic Blocks Library
================================

HBBLib is:
- collection of basic hardware blocks (mux, flop-flop and etc.);
- framework that can compile and test HBB with custom test bench;
- tool that helps to get HBB synthesis results

Pull source code from Github
----------------------------

Create dir, initialize git, create remote "origin" and pull:
```
mkdir -p hbblib/hbblib
cd hbblib/hbblib
git init
git remote add origin https://github.com/curoles/hbblib.git 
git pull origin master
```

Configure and run
-----------------
1. Pull HBBLib sources from GitHub (see above [pull source](#pull-source-code-from-github-))
2. Create build-and-run directory
   ```
   mkdir -p hbblib/build
   ```
3. Create your custom configuration
