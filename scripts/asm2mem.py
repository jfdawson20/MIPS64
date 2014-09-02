import os
import argparse
import sys 

Version = 'V1.0'
#setup argument parsing
cmdParser = argparse.ArgumentParser(description='MIPS Assembly to Memory Loader')
cmdParser.add_argument('-m','--mips', help='MIPS Assembly Source File', required=True)
cmdParser.add_argument('-s','--memsize', help='Instruction Memory Size', required=True)
cmdParser.add_argument('-b','--baseaddr', help='Program Base Address',required=True)
cmdParser.add_argument('-o','--out',help='Output Filename', default='output.txt')

args = vars(cmdParser.parse_args())
filename = args['mips'];
mipsFile = open(filename,'r')
instArray = []

i = 0
for line in mipsFile:
  instArray.append(line.rstrip())
  instArray.append('00000000')
  instArray.append('00000000')
  instArray.append('00000000')
  i = i + 1
  
a = 0
for a in range(i,int(args['memsize'])):
  instArray.append('00000000')
  
outfile = open(args['out']+'.bin','w')
for items in instArray: 
  outfile.write('%s\n' % items)
    
outfile.close()
mipsFile.close()
