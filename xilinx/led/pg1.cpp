/**
 * pg1.cpp
 *
 * (C)eSoft 2019, all rights reseved
 * 
 * -----------------------------------------------------
 * 2019/05/02		created
 */

#include "types.h"

static __int64 _floor(double x)
{
#pragma HLS pipeline II=1
	__int64 z = 0;
	unsigned __int64 y = *(unsigned __int64*)&x;
	unsigned int s = (y>>63)&0x1;
	int m = (y&0x7ff0000000000000)>>52;
	unsigned __int64 f = y&0xfffffffffffff;
	unsigned __int64 mask = 0;

	m = m-1023;
	if (m>52||m<0) {
		return 0;
	}
	if (m==0) {
		return (s==0)?1:-1;
	}

	for (int i=1; i<=52; i++) {
		unsigned __int64 bit = (unsigned __int64)1<<(52-i);
		unsigned __int64 v = i<=m?((unsigned __int64)1<<(m-i)):0;
		z += (f&bit)!=0?v:0;
		mask |= (i<=m)?bit:0;
	}
	mask = ~mask;
	if (f&mask) {
		if (s==0) {
			z += ((unsigned __int64)1<<m);
		} else {
			z += ((unsigned __int64)1<<m)+1;
			z = -z;;
		}
	} else {
		if (s==0) {
			z += ((unsigned __int64)1<<m);
		} else {;
			z += ((unsigned __int64)1<<m);
			z = -z;
		}
	}
	return z;
}

static __int64 _floor(double x);
static real_t _pulse(real_t t, real_t Tp, real_t Rr, real_t Rf, real_t Td, real_t duty, real_t amp, real_t offset)
{
#pragma HLS pipeline II=1
	real_t tt,t0,t1,t2,t3,Tw,Tr,Tf,n,out;
	const real_t eps = (real_t)1e-7;

	tt = t-Td;
	tt += eps;
	n = _floor(tt/Tp);

	if (Rr>=0) {
		Tr = Tp*Rr;
	} else {
		Tr = -Rr;
	}

	if (Rf>=0) {
		Tf = Tp*Rf;
	} else {
		Tf = -Rf;
	}

	if (duty>0) {
		Tw = Tp*duty*(real_t)(0.01);
	} else {
		Tw = -duty;
	}

	t0 = n*Tp;
	t1 = t0+Tr;
	t2 = t0+Tw;
	t3 = t2+Tf;

	if (tt<t0) {
		out = 0;
	} else
	if (Tr>0 && tt<t1) {
		out = amp*(tt-t0)/Tr;
	} else
	if (tt<t2) {
		out = amp;
	} else
	if (Tf>0 && tt<t3) {
		out = amp*(1-(tt-t2)/Tf);
	} else {
		out = 0;
	}
	return out+offset;
}

static real_t __t = 0;

static const real_t Rf = (real_t)0;
static const real_t Rr = (real_t)0;
static const real_t amp = (real_t)1;
static const real_t delay = (real_t)0;
static const real_t duty = (real_t)50;
static const real_t offset = (real_t)0;
static real_t out = (real_t)0.000000000000000e+000;
static const real_t period = (real_t)1;

void pg1(real_t *o_out)
{
#pragma HLS pipeline II=1
#pragma HLS interface ap_none register port="o_out"

	out = _pulse(__t,period,Rr,Rf,delay,duty,amp,offset);
	
	//update output
	*o_out = out;
	
	//integration
	
	//update discrete variables
	
	//update system variables
	__t += __STEPTIME;
}
