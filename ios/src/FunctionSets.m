/**
 * The MIT License (MIT)
 * Copyright (c) 2013 DeNA Co., Ltd.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 **/

#import "FunctionSets.h"

#pragma mark - Function Sets
@interface FunctionSets()
// FuncSet count
@property (assign, nonatomic) NSInteger count;
// FuncSets
@property (strong, nonatomic) NSMutableArray *functionSets;

@end

@implementation FunctionSets

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.count = 0;
    self.functionSets = [NSMutableArray array];
    return self;
}

- (void)dealloc {
    self.functionSets = nil;
    [super dealloc];
}

- (void)addFuncSet:(NSString *)name pointer:(FREFunction)pointer {
    FunctionSet *funcSet = [[[FunctionSet alloc] init] autorelease];
    funcSet.name = name;
    funcSet.func = pointer;
    [_functionSets addObject:funcSet];
    
    _count = [_functionSets count];
}

@end

#pragma mark - Function Set
@implementation FunctionSet
- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.name = nil;
    self.func = NULL;
    return self;
}

- (void)dealloc {
    self.name = nil;
    self.func = NULL;
    [super dealloc];
}

@end
