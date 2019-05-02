/**
 * real2bool_0.cpp
 *
 * (C)eSoft 2019, all rights reseved
 * 
 * -----------------------------------------------------
 * 2019/05/02		created
 */

#include "types.h"


static bool_t pinout = 0;

void real2bool_0(real_t pinin, bool_t *o_pinout)
{
#pragma HLS pipeline II=1
#pragma HLS interface ap_none register port="pinin"
#pragma HLS interface ap_none register port="o_pinout"

	pinout = (pinin==0)?0:1;
	
	//update output
	*o_pinout = pinout;
	
	//integration
	
	//update discrete variables
	
	//update system variables
}
