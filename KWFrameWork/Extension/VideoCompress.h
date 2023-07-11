//
//  VideoCompress.h
//  GoChat
//
//  Created by Autumn on 2022/1/2.
//
/// 本地视频压缩处理。源自：ChatViewController

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoCompress : NSObject


+ (void)createVideoFileWithAVURLAssert:(AVURLAsset *)asset videoName:(NSString *)vname result:(void(^)(NSError *error, NSString *videoPath, CGSize size, int duration))block progress:(void(^)(NSString *pro))progressblock;

+ (void)removeFile:(NSString*)filePath;
@end

NS_ASSUME_NONNULL_END
