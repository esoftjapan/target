/**
 * stepper.cpp
 *
 * (C)eSoft 2019, all rights reseved
 * 
 * -----------------------------------------------------
 * 2019/05/02		created
 */
#include "types.h"

static unsigned int _step_counter = 0;
void stepper(bool_t* step)
{
#pragma HLS pipeline II=1
#pragma HLS interface ap_none register port="step"

	if (_step_counter==50000) {
		*step = 1;
		_step_counter = 0;
	} else {
		*step = 0;
	}
	_step_counter++;
}
