/* Try CodeIQ
 * author: Leonardone @ NEETSDKASU
 */
#import <Foundation/Foundation.h>
#import <math.h>

double f(double n) {
    return 1.0 + floor(n * log10(n));
}

long long g(double m) {
    double x, y, b = 2.0, t = pow(10.0, 10.0);
    while (b <= t) {
        x = floor((b + t) / 2.0);
        y = f(x);
        if (y > m) {
            t = x - 1.0;
        } else if (y < m) {
            b = x + 1.0;
        } else {
            return (long long)x;
        }
    }
    return -1LL;
}


int main(void) {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    {
        
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSData   *data = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
        NSString  *str = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:enc];
        // NSArray *lines = [str componentsSeparatedByString:@"\n"];
        
        NSNumber *m = [NSNumber numberWithDouble:[str doubleValue]];
        if (m) {
            NSString *ans = [[NSNumber numberWithLongLong:g([m doubleValue])] stringValue];
            NSFileHandle *stdOut = [NSFileHandle fileHandleWithStandardOutput];
            [stdOut writeData:[ans dataUsingEncoding:enc]];
            [stdOut writeData:[@"\n" dataUsingEncoding:enc]];
        }        
    }
    [pool release];
    return 0;
}