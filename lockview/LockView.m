//
//  LockView.m
//  lockview
//
//  Created by lbq on 15/11/19.
//  Copyright © 2015年 linbq. All rights reserved.
//

#import "LockView.h"

CGFloat const btnCount = 9;
CGFloat const btnW = 74;
CGFloat const btnH = 74;
CGFloat const viewY = 300;
int const columnCount = 3;
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// 匿名扩展(类目的特例) 可以声明属性
@interface LockView()

@property(strong,nonatomic) NSMutableArray *selectBtns;

@end


@implementation LockView

-(NSMutableArray *) selectBtns{
    
    if(!_selectBtns){
        _selectBtns = [NSMutableArray array];
    }
    return _selectBtns;
    
}

// 如果文件是通过代码调用的,则使用这个创建时候调用
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self AddButton];
    }
    return self;
}

// 如果是通过stroyboard活xib文件创建的时候调用
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self AddButton];
    }
    return self;
}

// 布局按钮
-(void)AddButton{
    CGFloat height = 0;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置默认的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        //设置选中的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        //按钮用户交互关闭
        btn.userInteractionEnabled = NO;
        //设置btn的tag值
        btn.tag = i+1;
        //九宫格 行
        int row = i/columnCount;
        //九宫格 列
        int column = i%columnCount;
        //边距=(总视图的宽度-按钮的宽度*按钮个数)/(按钮个数+1)
        CGFloat margin =(self.frame.size.width - btnW*columnCount)/(columnCount+1);
        //X轴
        CGFloat btnX = (btnW + margin)*column + margin;
        //y轴
        CGFloat btnY = (btnW + margin)*row;
        height = btnY + btnH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        //btn.backgroundColor = [UIColor blackColor];
        [self addSubview:btn];
    }
    self.frame = CGRectMake(0, viewY, kScreenWidth, height);
}

#pragma mark -触摸方法
-(CGPoint)pointWithTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    return point;
}

-(UIButton *)buttonWithPoint:(CGPoint)point{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //拿到触摸的点
    CGPoint point = [self pointWithTouches:touches];
    //根据触摸的点拿到响应的按钮
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtns addObject:btn];
    }
    
    
    
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //拿到触摸的点
    CGPoint point = [self pointWithTouches:touches];
    //根据触摸的点拿到响应的按钮
    UIButton *btn = [self buttonWithPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtns addObject:btn];
    }
    [self setNeedsDisplay];
    
}
//触摸结束时触发
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //如果代理响应了方法
    if ([self.delegate respondsToSelector:@selector(lockView:didFinishPath:)]) {
        NSMutableString *path = [NSMutableString string];
        for (UIButton *btn in self.selectBtns) {
            [path appendFormat:@"%ld",(long)btn.tag];
        }
        [self.delegate lockView:self didFinishPath:path];
    }

    //清空
    for (UIButton *btn in self.selectBtns) {
        btn.selected = NO;
    }
    [self.selectBtns removeAllObjects];
    [self setNeedsDisplay];
}
//当触摸被打断的时候
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesCancelled:touches withEvent:event];
}


#pragma mark -绘图
-(void)drawRect:(CGRect)rect{
    // 按钮数组长度为0,不进行绘图
    if (self.selectBtns.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5]set];
    
    //遍历按钮
    for (int i = 0; i< self.selectBtns.count; i++) {
        UIButton *btn = self.selectBtns[i];
        if (i==0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
        
    }
    [path stroke];
    
    
    
    
    
}







@end
