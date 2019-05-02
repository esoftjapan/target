/**
 * types.h
 */

#ifndef __TYPES_H__
#define	__TYPES_H__

#include "ap_int.h"
//DON'T INCLUDE "hls_math.h", BECAUSE OF LONG COMPILE TIME AND HUGE MEMORY CONSUMPTION
//#include "hls_math.h"

//type definitions
typedef ap_uint<1> bool_t;
typedef int int_t;
typedef double real_t;
typedef double longreal_t;

static const real_t __STEPTIME	= 1.000000000000000e-003;

#define	TRUE		(1)
#define	FALSE		(0)
#define	max(x,y)	((x)>=(y)?(x):(y))
#define	min(x,y)	((x)<=(y)?(x):(y))

#define	MATHTABLESIZE	4096
#define	PI			(3.1415926535897932384626433832795)
#define	PI2			(6.283185307179586476925286766559)
#define	PIdiv2		(1.5707963267948966192313216916398)
#define	PIdiv4		(0.78539816339744830961566084581988)
#define	NdivPI2		(real_t)(MATHTABLESIZE/PI2)
#define	Ndiv4		(MATHTABLESIZE/4)
#define	MASK		(MATHTABLESIZE-1)
#define	nN			(MATHTABLESIZE<<18)
#define	log2		(0.69314718055994530941723212145818)
#define	invlog2		(1.4426950408889634073599246810019)
#define	MAXINT20	(1048576)

#endif
