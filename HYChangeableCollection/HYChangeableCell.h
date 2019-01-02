//
//  HYChangeableCell.h
//  HYChangeableCollection
//
//  Created by Hank on 2019/1/2.
//  Copyright © 2019 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYChangeableCell : UICollectionViewCell
@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, assign) BOOL isList;

@property (nonatomic, copy) NSString *imageName; 
@end

NS_ASSUME_NONNULL_END
