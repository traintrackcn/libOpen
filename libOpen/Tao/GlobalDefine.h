
#import "LoggerClient.h"


#ifdef DEBUG
    #define LOG_DEBUG(__format,__args...) LogMessageF(__FILE__, __LINE__, __FUNCTION__, @"debug", 0, @"%@",[NSString stringWithFormat:__format, ##__args])
#else
    #define LOG_DEBUG(__format, __args...)  
#endif

#ifdef DEBUG
    #define LOG_INFO(__format,__args...) LogMessageF(__FILE__, __LINE__, __FUNCTION__, @"info", 0, @"%@",[NSString stringWithFormat:__format, ##__args])
#else
    #define LOG_INFO(__format, __args...)
#endif


#ifdef DEBUG
    #define LOG_ERROR(__format,__args...) LogMessageF(__FILE__, __LINE__, __FUNCTION__, @"error", 0, @"%@",[NSString stringWithFormat:__format, ##__args])
#else
    #define LOG_ERROR(__format, __args...)
#endif

//#define LOG_TEST(__format,__args...) LogMessageF(__FILE__, __LINE__, __FUNCTION__, @"test", 0, @"%@",[NSString stringWithFormat:__format, ##__args])

#define ccp(__X__,__Y__) CGPointMake(__X__,__Y__)
#define PTM_RATIO 32.0
#define RANDOM_INT arc4random()%999999999

