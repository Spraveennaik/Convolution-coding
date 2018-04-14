    
README File

MATLAB code for convolution code (2, 1, 5) decoding with g1 = 1101 and g2 = 1110 and the analysis of % of error detection and error correction 
using sequential decoding with Threshold upto 5.

The MATLAB code for the sequential decoding is divided into different modules. Each module is represented by functions.

There are in total 6 modules each representing a function and they are named as follows.
1. mainfunction()
2. convoencode()
3. errgenerator()
4. decode_seq()
5. corrector()
6. graph()

 The maincode convolution.m comprises of all these combinations and the sequence in which the code runs is as shown above.

 In this MATLAB code, datawords of certain length are generated and they are encoded using the generating polyniomials g1 = 1101 and g2 = 1110.
 The encoded datawords are called codewords. To these codewords errors are introduced to the bits and are transmitted. Once the codewords are recieved 
 at the reciever end they are decoded using sequential decoding technique which gives the output datawords. An analysis of error correction and error detection
 is done for the set of error introduced codewords. The graph will be plotted for the corresponding number of errors introduced to the codewords.

 Mainfunction() generates the set of datawords of all combinations of certain length. Datawords can be of any length but in this code, datawords of length 5
 are generated which are in total 32 combinations of datawords starting from 00000 to 11111. These datawords are passed as arguements to convoencode()
 function.
 
 Convoencode() function recieves datawords and encodes them using generators g1 = 1101 and g2 = 1110. Each codewords in this example are of length 
 18 bits.
          The codewords length  =  2*(dataword length) + 8

 errgenerator() function recieves codewords from convoencode() and introduces errors to teh codewords. In this case 1 bit,2 bit and 3 bit errors are 
 introduced to the generated codewords. Any number of errors can be introduced. But because of time constraint upto 3 errors are introduced.
 
 decode_seq() function is the one which is used for error detection and error correction. The error introduced codewords are sent to decode_seq() function 
 which is a recursive function with backtracking mechanism to correct the codewords and produce the output datawords. For every codeword this function 
 is applied and it returns a flag bit to detect error and a array containing backtracked states. These values in whole are used for analysis of error detection and  error correction.
  
 corrector() function is used to verify whether the sent dataword and backtracked dataword are same and these values are used to analyse error correction.

 graph() function is used to plot the graph between Number of errors and percentage of error detection and error correction.

 The codewords are of length 18. so there are in total 2^18 combinations of codewords. 
 There are 18C1 combinations of 1 bit errors for each codeword and there are 32 codewords.  There are 576 combinations of codewords.
 2 bit error codewords = 18C2 * 32 = 4896 combinations.
 3 bit error codewords = 18C3 * 32 = 23112 combinations.

 The code can generate datawords of  any given length and analysis of error detection and error correction can be conducted. But because of time 
 constraint, dataword of length 5 and error upto 3 bits are taken.

 Also all these functions are merged into one and a complete MATLAB code is given in the code named convolution.m

 There are in total 7 codes given in the matlab repository, 6 representing 6 modules and 1 code which has the combination of all. The output for convolution.m
 function will be a graph represeting error detection and error correction upto 3 bit errors for all combinations of datawords of length 5.   

