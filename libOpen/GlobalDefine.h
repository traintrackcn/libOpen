
//#import "LoggerClient.h"

#define CURRENT_FUNCTION __PRETTY_FUNCTION__

#ifdef DEBUG
#define TLOG(__format,__args...) NSLog(@"%s:%d %@",CURRENT_FUNCTION, __LINE__,[NSString stringWithFormat:__format, ##__args]);
#else
#define TLOG(__format, __args...)
#endif

//#define LOG_TEST(__format,__args...) LogMessageF(__FILE__, __LINE__, __FUNCTION__, @"test", 0, @"%@",[NSString stringWithFormat:__format, ##__args])

#define CCP(__X__,__Y__) CGPointMake(__X__,__Y__)
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define PTM_RATIO 32.0
#define RANDOM_INT arc4random()%999999999

