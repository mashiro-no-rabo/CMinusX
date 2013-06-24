
#line 1 "objclexer.rl"
//
//  CMScanner.m
//  CMinusX
//
//  Created by AquarHEAD L. on 6/16/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "CMScanner.h"

@implementation CMScanner


#line 17 "CMScanner.m"
static const char _CMinusScanner_actions[] = {
	0, 1, 0, 1, 1, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 14, 1, 
	15, 1, 16, 1, 17, 1, 18, 1, 
	19, 1, 20, 1, 21, 1, 22, 1, 
	23, 1, 24, 1, 25, 1, 26, 1, 
	27, 1, 28, 1, 29, 1, 30, 1, 
	31, 1, 32, 1, 33, 2, 2, 3, 
	2, 2, 4, 2, 2, 5, 2, 2, 
	6, 2, 2, 7, 2, 2, 8, 2, 
	2, 9
};

static const char _CMinusScanner_key_offsets[] = {
	0, 0, 1, 32, 34, 35, 36, 37, 
	41, 46, 51, 56, 62, 67, 72, 77, 
	82, 87, 92, 97, 102, 107, 112, 117, 
	122
};

static const char _CMinusScanner_trans_keys[] = {
	61, 10, 32, 33, 40, 41, 42, 43, 
	44, 45, 47, 59, 60, 61, 62, 91, 
	93, 101, 105, 114, 118, 119, 123, 125, 
	9, 13, 48, 57, 65, 90, 97, 122, 
	48, 57, 61, 61, 61, 65, 90, 97, 
	122, 108, 65, 90, 97, 122, 115, 65, 
	90, 97, 122, 101, 65, 90, 97, 122, 
	102, 110, 65, 90, 97, 122, 116, 65, 
	90, 97, 122, 101, 65, 90, 97, 122, 
	116, 65, 90, 97, 122, 117, 65, 90, 
	97, 122, 114, 65, 90, 97, 122, 110, 
	65, 90, 97, 122, 111, 65, 90, 97, 
	122, 105, 65, 90, 97, 122, 100, 65, 
	90, 97, 122, 104, 65, 90, 97, 122, 
	105, 65, 90, 97, 122, 108, 65, 90, 
	97, 122, 101, 65, 90, 97, 122, 0
};

static const char _CMinusScanner_single_lengths[] = {
	0, 1, 23, 0, 1, 1, 1, 0, 
	1, 1, 1, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1
};

static const char _CMinusScanner_range_lengths[] = {
	0, 0, 4, 1, 0, 0, 0, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2
};

static const unsigned char _CMinusScanner_index_offsets[] = {
	0, 0, 2, 30, 32, 34, 36, 38, 
	41, 45, 49, 53, 58, 62, 66, 70, 
	74, 78, 82, 86, 90, 94, 98, 102, 
	106
};

static const char _CMinusScanner_indicies[] = {
	0, 1, 3, 2, 4, 5, 6, 7, 
	8, 9, 10, 11, 13, 14, 15, 16, 
	18, 19, 20, 21, 22, 23, 24, 25, 
	26, 2, 12, 17, 17, 1, 12, 27, 
	29, 28, 31, 30, 33, 32, 17, 17, 
	34, 36, 17, 17, 35, 37, 17, 17, 
	35, 38, 17, 17, 35, 39, 40, 17, 
	17, 35, 41, 17, 17, 35, 42, 17, 
	17, 35, 43, 17, 17, 35, 44, 17, 
	17, 35, 45, 17, 17, 35, 46, 17, 
	17, 35, 47, 17, 17, 35, 48, 17, 
	17, 35, 49, 17, 17, 35, 50, 17, 
	17, 35, 51, 17, 17, 35, 52, 17, 
	17, 35, 53, 17, 17, 35, 0
};

static const char _CMinusScanner_trans_targs[] = {
	2, 0, 2, 2, 1, 2, 2, 2, 
	2, 2, 2, 2, 3, 2, 4, 5, 
	6, 7, 2, 2, 8, 11, 13, 18, 
	21, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 9, 10, 7, 7, 
	12, 7, 14, 15, 16, 17, 7, 19, 
	20, 7, 22, 23, 24, 7
};

static const char _CMinusScanner_trans_actions[] = {
	21, 0, 39, 5, 0, 27, 29, 11, 
	7, 25, 9, 13, 0, 23, 0, 0, 
	0, 71, 31, 33, 0, 0, 0, 0, 
	0, 35, 37, 49, 41, 15, 45, 19, 
	43, 17, 51, 47, 0, 0, 56, 53, 
	0, 59, 0, 0, 0, 0, 62, 0, 
	0, 65, 0, 0, 0, 68
};

static const char _CMinusScanner_to_state_actions[] = {
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0
};

static const char _CMinusScanner_from_state_actions[] = {
	0, 0, 3, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0
};

static const unsigned char _CMinusScanner_eof_trans[] = {
	0, 0, 0, 28, 29, 31, 33, 35, 
	36, 36, 36, 36, 36, 36, 36, 36, 
	36, 36, 36, 36, 36, 36, 36, 36, 
	36
};

static const int CMinusScanner_start = 2;
static const int CMinusScanner_first_final = 2;
static const int CMinusScanner_error = 0;

static const int CMinusScanner_en_main = 2;


#line 139 "objclexer.rl"


+ (NSArray *)scan:(NSString *)input {
    NSMutableArray *result = [NSMutableArray new];
    NSUInteger lineno = 1;
    int cs, act;
    const char *ts, *te;
    const char *p = [input cStringUsingEncoding: NSASCIIStringEncoding];
    const char *pe = p + [input length];
    const char *eof = pe;
    
#line 155 "CMScanner.m"
	{
	cs = CMinusScanner_start;
	ts = 0;
	te = 0;
	act = 0;
	}

#line 150 "objclexer.rl"
    
#line 165 "CMScanner.m"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_acts = _CMinusScanner_actions + _CMinusScanner_from_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 1:
#line 1 "NONE"
	{ts = p;}
	break;
#line 186 "CMScanner.m"
		}
	}

	_keys = _CMinusScanner_trans_keys + _CMinusScanner_key_offsets[cs];
	_trans = _CMinusScanner_index_offsets[cs];

	_klen = _CMinusScanner_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (unsigned int)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _CMinusScanner_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += (unsigned int)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	_trans = _CMinusScanner_indicies[_trans];
_eof_trans:
	cs = _CMinusScanner_trans_targs[_trans];

	if ( _CMinusScanner_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _CMinusScanner_actions + _CMinusScanner_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 2:
#line 1 "NONE"
	{te = p+1;}
	break;
	case 3:
#line 27 "objclexer.rl"
	{act = 2;}
	break;
	case 4:
#line 31 "objclexer.rl"
	{act = 3;}
	break;
	case 5:
#line 35 "objclexer.rl"
	{act = 4;}
	break;
	case 6:
#line 39 "objclexer.rl"
	{act = 5;}
	break;
	case 7:
#line 43 "objclexer.rl"
	{act = 6;}
	break;
	case 8:
#line 47 "objclexer.rl"
	{act = 7;}
	break;
	case 9:
#line 127 "objclexer.rl"
	{act = 27;}
	break;
	case 10:
#line 23 "objclexer.rl"
	{te = p+1;{
        lineno += 1;
    }}
	break;
	case 11:
#line 51 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpCalcAdd lineno:lineno andInfo:nil]];
    }}
	break;
	case 12:
#line 55 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpCalcSub lineno:lineno andInfo:nil]];
    }}
	break;
	case 13:
#line 59 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpCalcMul lineno:lineno andInfo:nil]];
    }}
	break;
	case 14:
#line 63 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpCalcDiv lineno:lineno andInfo:nil]];
    }}
	break;
	case 15:
#line 71 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpRelLE lineno:lineno andInfo:nil]];
    }}
	break;
	case 16:
#line 79 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpRelGE lineno:lineno andInfo:nil]];
    }}
	break;
	case 17:
#line 83 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpRelEQ lineno:lineno andInfo:nil]];
    }}
	break;
	case 18:
#line 87 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenOpRelNE lineno:lineno andInfo:nil]];
    }}
	break;
	case 19:
#line 95 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenStmtEnd lineno:lineno andInfo:nil]];
    }}
	break;
	case 20:
#line 99 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenComma lineno:lineno andInfo:nil]];
    }}
	break;
	case 21:
#line 103 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenArgsLeft lineno:lineno andInfo:nil]];
    }}
	break;
	case 22:
#line 107 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenArgsRight lineno:lineno andInfo:nil]];
    }}
	break;
	case 23:
#line 111 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenArrayLeft lineno:lineno andInfo:nil]];
    }}
	break;
	case 24:
#line 115 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenArrayRight lineno:lineno andInfo:nil]];
    }}
	break;
	case 25:
#line 119 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenFuncLeft lineno:lineno andInfo:nil]];
    }}
	break;
	case 26:
#line 123 "objclexer.rl"
	{te = p+1;{
        [result addObject: [CMToken tokenWithType:TokenFuncRight lineno:lineno andInfo:nil]];
    }}
	break;
	case 27:
#line 135 "objclexer.rl"
	{te = p+1;}
	break;
	case 28:
#line 67 "objclexer.rl"
	{te = p;p--;{
        [result addObject: [CMToken tokenWithType:TokenOpRelLT lineno:lineno andInfo:nil]];
    }}
	break;
	case 29:
#line 75 "objclexer.rl"
	{te = p;p--;{
        [result addObject: [CMToken tokenWithType:TokenOpRelGT lineno:lineno andInfo:nil]];
    }}
	break;
	case 30:
#line 91 "objclexer.rl"
	{te = p;p--;{
        [result addObject: [CMToken tokenWithType:TokenAssign lineno:lineno andInfo:nil]];
    }}
	break;
	case 31:
#line 127 "objclexer.rl"
	{te = p;p--;{
        [result addObject: [CMToken tokenWithType:TokenID lineno:lineno andInfo:@{@"id": [[NSString stringWithCString:ts encoding:NSASCIIStringEncoding] substringToIndex:te-ts]}]];
    }}
	break;
	case 32:
#line 131 "objclexer.rl"
	{te = p;p--;{
        [result addObject: [CMToken tokenWithType:TokenNUM lineno:lineno andInfo:@{@"value": [NSNumber numberWithInt:[[[NSString stringWithCString:ts encoding:NSASCIIStringEncoding] substringToIndex:te-ts] intValue]]}]];
    }}
	break;
	case 33:
#line 1 "NONE"
	{	switch( act ) {
	case 2:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenIf lineno:lineno andInfo:nil]];
    }
	break;
	case 3:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenElse lineno:lineno andInfo:nil]];
    }
	break;
	case 4:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenInt lineno:lineno andInfo:nil]];
    }
	break;
	case 5:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenReturn lineno:lineno andInfo:nil]];
    }
	break;
	case 6:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenVoid lineno:lineno andInfo:nil]];
    }
	break;
	case 7:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenWhile lineno:lineno andInfo:nil]];
    }
	break;
	case 27:
	{{p = ((te))-1;}
        [result addObject: [CMToken tokenWithType:TokenID lineno:lineno andInfo:@{@"id": [[NSString stringWithCString:ts encoding:NSASCIIStringEncoding] substringToIndex:te-ts]}]];
    }
	break;
	}
	}
	break;
#line 461 "CMScanner.m"
		}
	}

_again:
	_acts = _CMinusScanner_actions + _CMinusScanner_to_state_actions[cs];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 ) {
		switch ( *_acts++ ) {
	case 0:
#line 1 "NONE"
	{ts = 0;}
	break;
#line 474 "CMScanner.m"
		}
	}

	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	if ( _CMinusScanner_eof_trans[cs] > 0 ) {
		_trans = _CMinusScanner_eof_trans[cs] - 1;
		goto _eof_trans;
	}
	}

	_out: {}
	}

#line 151 "objclexer.rl"
    return [result copy];
}

@end