//
//  cplusfunctions.cpp
//  testCommandLine
//
//  Created by John Bethancourt on 1/11/17.
//  Copyright © 2017 John Bethancourt. All rights reserved.
//

#include "cplusfunctions.hpp"
#include <iostream>


void CPP::DaClearScreen2(){
    system("clear");
    
    //change the size...
    
    
}
void CPP::DaClearScreen(){
    
    
    //std::cout << "Working... in C++" << std::endl;
    std::cout << std::endl;
    
    if (!cur_term)
    {
       int result;
        
        setupterm( NULL, STDOUT_FILENO, &result );
        
        if (result <= 0){
            
            return;
            
        }else{
            
        
        }
    }
    
    putp(tigetstr((char*)"clear"));
    
    
    std::cout << "\033[1;31m\033[0m\n";
}
