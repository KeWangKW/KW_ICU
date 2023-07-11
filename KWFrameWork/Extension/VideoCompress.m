//
//  VideoCompress.m
//  GoChat
//
//  Created by Autumn on 2022/1/2.
//

#import "VideoCompress.h"



@implementation VideoCompress



//本地视频处理
static AVAssetExportSession *videoExportSession = nil;
+ (void)createVideoFileWithAVURLAssert:(AVURLAsset *)asset videoName:(NSString *)vname result:(void(^)(NSError *error, NSString *videoPath, CGSize size, int duration))block progress:(void(^)(NSString *pro))progressblock {
    __block NSError *error = nil;
    
    NSString *quality = nil;
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        quality = AVAssetExportPresetMediumQuality;
    }
    else if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality]) {
        quality = AVAssetExportPresetLowQuality;
    } else {
        if (block) {
            error = [NSError errorWithDomain:@"无质量" code:101 userInfo:nil];
            block(error, nil, CGSizeZero, 0);
        }
        return;
    }
    
    int videoDuration = asset.duration.value*1.0/asset.duration.timescale;
    NSString *videoPath = [NSString stringWithFormat:@"%@/Library/Caches/%@.mp4",NSHomeDirectory(),vname];
    
    videoExportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:quality];
    videoExportSession.outputURL = [NSURL fileURLWithPath:videoPath];
    videoExportSession.shouldOptimizeForNetworkUse = YES;
    videoExportSession.outputFileType = AVFileTypeMPEG4;
    
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        NSTimer * tim = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"=========  %.2f",videoExportSession.progress);
            float dd = videoExportSession.progress;
            progressblock([NSString stringWithFormat:@"%.2f",videoExportSession.progress]);
            
            if (videoExportSession.progress >= 0.99) {
                [timer invalidate];
            }
        }];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:tim forMode:NSRunLoopCommonModes];
    });
    
    
    [videoExportSession exportAsynchronouslyWithCompletionHandler:^{
        
        switch ([videoExportSession status]) {
            case AVAssetExportSessionStatusFailed: {
                if (block) {
                    block([videoExportSession error], nil, CGSizeZero, 0);
                }
                break;
            }
            case AVAssetExportSessionStatusCancelled: {
                if (block) {
                    error = [NSError errorWithDomain:@"取消" code:102 userInfo:nil];
                    block(error, nil, CGSizeZero, 0);
                }
                break;
            }
            case AVAssetExportSessionStatusCompleted: {
                if (block)  {
                    AVURLAsset *convertAvAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
                    AVAssetTrack *track = [[convertAvAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
                    CGSize videoSize = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
                    block(nil, videoPath, videoSize, videoDuration);
                    
                    
                }
                break;
            }
            default: {
                if (block) {
                    error = [NSError errorWithDomain:@"未知" code:103 userInfo:nil];
                    block(error, nil, CGSizeZero, 0);
                }
                break;
            }
        }
    }];
    
}






//删除文件
+ (void)removeFile:(NSString*)filePath{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"removeFile Field：%@",[error localizedDescription]);
    }else{
        NSLog(@"removeFile Success");
    }
}

//删除某些后缀的文件
+(void)removeFileSuffixList:(NSArray<NSString*>*)suffixList filePath:(NSString*)path deep:(BOOL)deep{
    NSArray *fileArray = nil;
    if (deep) {  // 是否深度遍历
        fileArray = [self getAllFileList:path];
    }else{
        fileArray = [self getFileList:path];
        NSMutableArray *fileArrayTmp = [NSMutableArray array];
        for (NSString *fileName in fileArray) {
            NSString* allPath = [path stringByAppendingPathComponent:fileName];
            [fileArrayTmp addObject:allPath];
        }
        fileArray = fileArrayTmp;
    }
    for (NSString *aPath in fileArray) {
        for (NSString* suffix in suffixList) {
            if ([aPath hasSuffix:suffix]) {
                [self removeFile:aPath];
            }
        }
    }
}
//获取文件夹下所有的文件列表
+(NSArray*)getFileList:(NSString*)path{
    if (path.length==0) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"getFileList Failed:%@",[error localizedDescription]);
    }
    return fileList;
}
//获取文件夹下所有文件(深度遍历)
+(NSArray*)getAllFileList:(NSString*)path{
    if (path.length==0) {
        return nil;
    }
    NSArray *fileArray = [self getFileList:path];
    NSMutableArray *fileArrayNew = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *aPath in fileArray) {
        NSString * fullPath = [path stringByAppendingPathComponent:aPath];
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&isDir]) {
            if (isDir) {
                [fileArrayNew addObjectsFromArray:[self getAllFileList:fullPath]];
            }else{
                [fileArrayNew addObject:fullPath];
            }
        }
    }
    return fileArrayNew;
}

//删除文件夹
//+(BOOL)removeDir:(NSString*)path{
//    return [self removeFile:path];
//}



@end
