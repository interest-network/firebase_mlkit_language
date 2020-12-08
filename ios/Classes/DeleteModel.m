#import "FirebaseMlkitLanguagePlugin.h"

@import FirebaseMLCommon;

@implementation DeleteModel

+ (void)handleEvent:(NSString *)text result:(FlutterResult)result {
  FIRTranslateLanguage modelName = FIRTranslateLanguageForLanguageCode(text);

  NSSet<FIRTranslateRemoteModel *> *localModels =
    [FIRModelManager modelManager].downloadedTranslateModels;

  Boolean isModelPresent = [localModels
      containsObject:[FIRTranslateRemoteModel translateRemoteModelWithLanguage:modelName]];

  if (isModelPresent) {
    FIRTranslateRemoteModel *deModel =
    [FIRTranslateRemoteModel translateRemoteModelWithLanguage:modelName];
    [[FIRModelManager modelManager] deleteDownloadedModel:deModel
                                           completion:^(NSError * _Nullable error) {
                                               if (error != nil) {
                                                   [FirebaseMlkitLanguagePlugin handleError:error result:result];
                                                   return;
                                               }
                                               result(@"Deleted");
                                           }];
  } else {
    result(@"Model not downloaded");
  }
}

@end
