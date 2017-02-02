//
//  SiriView.m
//  HaNoiTravel
//
//  Created by Dreamup on 2/2/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "SpeechView.h"
#import <Speech/Speech.h>

@interface SpeechView()<SFSpeechRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLb;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImv;

@property (strong,nonatomic) void (^completion)(NSString *result);
@property (strong,nonatomic) SFSpeechRecognizer *speechRecognizer;

@property (strong,nonatomic) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@property (strong,nonatomic) SFSpeechRecognitionTask *recognitionTask;
@property (strong,nonatomic) AVAudioEngine *audioEngine;

- (IBAction)closeAction:(id)sender;


@end

@implementation SpeechView{
    
}

- (id) initWithBlock:(void(^)(NSString *result))completion{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SpeechView" owner:self options:nil] objectAtIndex:0];
    self.frame = [[UIScreen mainScreen] bounds];
    self.completion = completion;
    
    self.voiceImv.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startRecording)];
    [self.voiceImv addGestureRecognizer:tapGesture];
    
    return self;
}


- (void) start{
    NSLog(@"start SiriView");
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus authStatus){
        
        NSLog(@"status : %ld",(long)authStatus);
        
        switch (authStatus) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"vi"]];
                _speechRecognizer.delegate = self;
                NSLog(@"Authorized");
                break;
                
            case SFSpeechRecognizerAuthorizationStatusDenied:
                //User denied access to speech recognition
                NSLog(@"SFSpeechRecognizerAuthorizationStatusDenied");
                break;
                
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                //Speech recognition restricted on this device
                NSLog(@"SFSpeechRecognizerAuthorizationStatusRestricted");
                break;
                
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                //Speech recognition not yet authorized
                NSLog(@"SFSpeechRecognizerAuthorizationStatusNotDetermined");
                break;
                
            default:
                NSLog(@"Default");
                break;
        }
    }];
}

- (void) startRecording{
    
    if(_speechRecognizer == nil){
        return;
    }
    
    if (_recognitionTask != nil) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    [self drawCircle];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    _audioEngine = [[AVAudioEngine alloc] init];
    
    AVAudioInputNode *inputNode = _audioEngine.inputNode;
    if(!inputNode){
        NSLog(@"Audio engine has no input node");
    }
    
    if(!_recognitionRequest){
        NSLog(@"Unable to create an SFSpeechAudioBufferRecognitionRequest object");
    }
    
    _recognitionRequest.shouldReportPartialResults = true;
    _recognitionTask = [_speechRecognizer
                        recognitionTaskWithRequest:_recognitionRequest
                        resultHandler:^(SFSpeechRecognitionResult *result,NSError *error){
                            
                            BOOL isFinal = NO;
                            
                            if(result != nil){
                                self.resultLb.text = result.bestTranscription.formattedString;
                                isFinal = result.isFinal;
                            }
                            
                            //                            if(error == nil || isFinal){
                            //                                [_audioEngine stop];
                            //                                [inputNode removeTapOnBus:0];
                            //                                _recognitionRequest = nil;
                            //                                _recognitionTask = nil;
                            //                                [self startRecording];
                            //                            }
                        }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer *buffer,AVAudioTime *time){
        [_recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    
    [_audioEngine prepare];
    [_audioEngine startAndReturnError:nil];
}

- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    
}

-(void)drawCircle{
    
    _circleView.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.7].CGColor;
    _circleView.layer.borderWidth = 2.0f;
    
    _circleView.layer.cornerRadius = 35;
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    color.fromValue = (__bridge id _Nullable)([[UIColor redColor] colorWithAlphaComponent:0.7].CGColor);
    color.toValue   = (__bridge id _Nullable)([[UIColor redColor] colorWithAlphaComponent:0.0].CGColor);
    
    CABasicAnimation* shrink = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrink.toValue = [NSNumber numberWithDouble:2.5];
    
    CABasicAnimation *width = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    width.fromValue = @2;
    width.toValue   = @0;
    
    CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    theGroup.animations = @[color,shrink,width];
    theGroup.duration   = 2;
    theGroup.repeatCount = HUGE_VALF;
    theGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    [_circleView.layer addAnimation:theGroup forKey:@"theGroup"];
    
}


- (IBAction)closeAction:(id)sender {
    [self removeFromSuperview];
}
@end
