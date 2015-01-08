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
2. Create work directory where you want to keep build/synthesis files and from where you are going
   to run RTL simulation.
   ```
   mkdir -p hbblib/work
   ```
3. Create your custom configuration or pick existing one inside /config directory. If no configuration
   file provided to the configure.rb, then it will automatically collect information about installed tools.
4. Change directoty to the work directory and run:
   ```
   ruby ../hbblib/configure.rb -c ../hbblib/config/smi.yaml
   ```
   or
   ```
   ruby ../hbblib/configure.rb
   ```

References
----------
http://www.sunburst-design.com/papers/

