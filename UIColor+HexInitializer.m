/*
 Copyright (c) 2011 Jacek Migacz (jacekmigacz@icloud.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "UIColor+HexInitializer.h"

static inline __attribute__((always_inline)) void extract_rgb(uint8_t *r,
                                                              uint8_t *g,
                                                              uint8_t *b,
                                                              uint32_t *rgb)
{
    *r = (*rgb & 0xFF0000) >> 16;
    *g = (*rgb & 0xFF00) >> 8;
    *b = (*rgb & 0xFF);
}

static inline __attribute__((always_inline)) void extract_rgba(uint8_t *r,
                                                               uint8_t *g,
                                                               uint8_t *b,
                                                               uint8_t *a,
                                                               uint32_t *rgb)
{
    *r = (*rgb & 0xFF000000) >> 24;
    *g = (*rgb & 0xFF0000) >> 16;
    *b = (*rgb & 0xFF00) >> 8;
    *a = (*rgb & 0xFF);
}

@implementation UIColor (HexInitializer)

- (id)initRGBWithHexValue:(uint32_t)rgb
{
    uint8_t r, g, b;
    extract_rgb(&r, &g, &b, &rgb);
    return [self initWithRed:r/255. green:g/255. blue:b/255. alpha:1.];
}

+ (UIColor *)colorRGBWithHexValue:(uint32_t)rgb
{
    uint8_t r, g, b;
    extract_rgb(&r, &g, &b, &rgb);
 	return [self colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.];
}

- (id)initRGBAWithHexValue:(uint32_t)rgba
{
    uint8_t r, g, b, a;
    extract_rgba(&r, &g, &b, &a, &rgba);
	return [self initWithRed:r/255. green:g/255. blue:b/255. alpha:a/255.];
}

+ (UIColor *)colorRGBAWithHexValue:(uint32_t)rgba
{
    uint8_t r, g, b, a;
    extract_rgba(&r, &g, &b, &a, &rgba);
	return [self colorWithRed:r/255. green:g/255. blue:b/255. alpha:a/255.];
}

- (uint32_t)hexFromString:(NSString *)string
{
    return [[self class] hexFromString:string];
}

+ (uint32_t)hexFromString:(NSString *)string
{
    uint32_t hex;
    NSScanner *scanner = [[NSScanner alloc] initWithString:string];
	if([scanner scanHexInt:&hex])
        hex = 0x0;
    return hex;
}

- (id)initRGBWithHexString:(NSString *)rgb
{
	uint32_t hex = [self hexFromString:rgb];
	return [self initRGBWithHexValue:hex];
}

+ (UIColor *)colorRGBWithHexString:(NSString *)rgb
{
    uint32_t hex = [self hexFromString:rgb];
	return [self colorRGBWithHexValue:hex];
}

- (id)initRGBAWithHexString:(NSString *)rgba
{
    uint32_t hex = [self hexFromString:rgba];
    return [self initRGBAWithHexValue:hex];
}

+ (UIColor *)colorRGBAWithHexString:(NSString *)rgba
{
    uint32_t hex = [self hexFromString:rgba];
    return [self colorRGBAWithHexValue:hex];
}

@end
