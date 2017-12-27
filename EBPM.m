%Event-based PM task
%created by Francesco Pupillo
%16-Oct-2017

function [EBPMscore]= EBPM()
try
   
% cd 'C:/Users/Francesco/OneDrive - University of Aberdeen/prospective memory/LDT' 
rect=Screen('Rect', 0) ; % returns an array with the top left corner and the bottom right corner coordinates of the screen
%for testing
%[MyScreen, rect] = Screen('OpenWindow', 0, [0, 0, 0], rect/2 ); %select the screen and the color (black)
[MyScreen, rect] = Screen('OpenWindow', 0 , [0, 0, 0], rect); %select the screen and the color (black)

slack=Screen('GetFlipInterval', MyScreen) /2  ; %the flip interval
fps=Screen('NominalFrameRate', MyScreen); %screen per second 
%get the code for the space bar and for the other keys
space=KbName('space'); 
c=KbName('c');
m=KbName('m');
y=KbName('y');
n=KbName('n');
%set the stimulus duration as a function of frame per seconds
stimDuration=round(0.5*fps); %in fps 
%set the duration for the fixation cross
crossDuration=round(0.725*fps); %in fps
h=0; %counter
j=0; %counter
k=0; %counter
z=0;  %counter for PM time
v=0;%counter for the space bar
x=0; %counter for the y
w=0; % 
s=0; %counter to avoid to press the yes and no bar continuously
%retrieve the file with the words 
[Prwords,Prnonwords,verbs]=textread('EBPMlist4.csv', '%s%s%s', 'delimiter', ',');
wholepracticewords=[Prwords;Prnonwords]; %after the 42th there are only spaces
%randomise the words
practiceWorder=wholepracticewords(randperm(length(wholepracticewords)));
%present the verbs (PM cues) at fixed points: 31,80,127,154,186, 215,
LDTwords=[practiceWorder(1:30);verbs(1);practiceWorder(31:78);verbs(2); practiceWorder(79:124);verbs(3);practiceWorder(125:150);verbs(4);practiceWorder(151:181);verbs(5);practiceWorder(182:209);verbs(6);practiceWorder(210:226)];
%create dummy coding for the length of the presentation of the stimulus(1)
%and for the fixation cross
trials=length(LDTwords);%length(wholepracticewords)+verbs ,127+3,133 ;
rt=zeros(1,max(trials));
PMkey=zeros(1,6); %setting the PM time variable
PMrt=zeros(1, 6);
score=zeros(1, max(trials));
a=[repelem(1,stimDuration),repelem(2,crossDuration)];% 40=stimulut presentation; 20= cross presentation
b=repmat(a, 1,trials); % length task=trials
%defining the screen size and instructions
    DrawFormattedText(MyScreen,'In this task you will still be working on the lexical task as the previous one.\n\n\n\n\n Thus, you will see a series of letters appear on the screen\n\nyour task is to press the "YES" button if the letters you see \n\n make up a word and press the "NO" button if this is not the case.','center', rect(3)/6   , [255 255 255]);
    DrawFormattedText(MyScreen,'Please press any key to continue','center', rect(3)/2, [255 255 255]);
    Screen('Flip', MyScreen);
    HideCursor()
    KbWait;
    WaitSecs(1);
    DrawFormattedText(MyScreen,'Next time that you are working on this task,\n\n Please remember additionally  to press the "Y" button \n\nevery time the word you see is also a verb.','center', rect(3)/8 , [255 255 255]);
    DrawFormattedText(MyScreen,'If you missed to press the ‘Y’ button whilst a verb  was shown,\n\n you can still press it afterwards. ','center', rect(3)/4.5 , [255 255 255]);
    DrawFormattedText(MyScreen,'Please approach the experimenter and repeat task instructions\n\n in your own words.','center', rect(3)/3 , [255 255 255]);
    DrawFormattedText(MyScreen,'Please press any key to continue','center', rect(3)/2, [255 255 255]);
    Screen('Flip', MyScreen); 
    KbWait;
    WaitSecs(1);
    Screen('FillRect',MyScreen, [0,0,0], rect);
    Screen('Flip', MyScreen); 
    KbWait;
    WaitSecs(0.5);
    DrawFormattedText(MyScreen,'Please place your right index finger on the "YES" button\n\n and your left index finger on the "NO" button.\n\n ','center', rect(3)/6 , [255 255 255]);
    DrawFormattedText(MyScreen,'Please always try to work as accurately and as quickly as possible','center', rect(3)/3 , [255 255 255]);
    DrawFormattedText(MyScreen,'Press any key to start the task','center', rect(3)/2 , [255 255 255]);
    Screen('Flip', MyScreen);
    KbWait;
    WaitSecs(1);
     DrawFormattedText(MyScreen,'Ready...','center', 'center', [255 255 255]);
     Screen('Flip', MyScreen);
     WaitSecs(2);
     DrawFormattedText(MyScreen,'Go! ','center', 'center', [255 255 255]);
     Screen('Flip', MyScreen);
     WaitSecs(1);
     HideCursor() %hide the cursor
    
%while t1<10 %this could also be eliminated
[KeyIsDown, secs, keyCode]=KbCheck; %start checking for the any key pressed

%set the time when the task start
t0=GetSecs;
%set a counter as a difference from the moment the task starts
t1=GetSecs-t0;
t1=round(t1); 
%set a counter for the first word
trial=1;
i=1.1; %starting counter for the words
space=KbName('space');

 for e=1:length( b) %for the lenght of the variable we have set, which is equal to the length of the words
     %while NO==0 
     
     if b(e)==1 %for the stimulus 
            b;
             trial= fix(i);%the trial equals the counter wihout the dot
   
[KeyIsDown, secs, keyCode]=KbCheck;

t1=GetSecs-t0;
t1=round(t1);
 
%select the word
 wordselected=char(LDTwords (trial));
 textsize=48;  
 Screen('TextSize', MyScreen, textsize) ; %set the text size
 Screen('TextFont', MyScreen, 'Arial'); %set the font
 DrawFormattedText(MyScreen,wordselected,'center', rect(4)/2+textsize/2 , [255 255 255]); %draw text
 k=k+1;
 else if b(e)==2 %for the cross
            b;
            [KeyIsDown, secs, keyCode]=KbCheck;

t1=GetSecs-t0;
t1=round(t1);

 a=11; %length of the cross
  Screen('DrawLine', MyScreen, [255,255,255],rect(3)/2, rect(4)/2-a,rect(3)/2,rect(4)/2+a);
  Screen('DrawLine', MyScreen, [255,255,255],rect(3)/2-a,rect(4)/2, rect(3)/2+a,rect(4)/2);  
 i=1/crossDuration+i; %counter for let matlab know which word to select
 k=k+1;
 if k==stimDuration+crossDuration
     k=0;
 end
      end
        end
     if (~isempty(strmatch(LDTwords(trial), verbs))) && w>stimDuration*4
                z=z+1; %counter of the trial of tbhe ver
                w=0;
            end
if KeyIsDown %if the key 
    if (keyCode(c) && ~isempty(strmatch(LDTwords(trial), Prnonwords))) && s>stimDuration
            score(trial)=1;  %if participant press the no button for non words
            rt(trial)=k/fps;
            s=0;
    elseif (keyCode(c) && isempty(strmatch(LDTwords(trial), Prnonwords))) && s>stimDuration
                 score(trial)=0 ;%%if participant press the no button for words
                             rt(trial)=k/fps;
                             s=0;
         end 
            if (keyCode(m) && ~isempty(strmatch(LDTwords(trial), Prwords))) && s>stimDuration
            score(trial)=1;  %%if participant press the yes button for words
            rt(trial)=k/fps;
            s=0;
            elseif (keyCode(m) && isempty(strmatch(LDTwords(trial), Prwords))) && s>stimDuration
                 score(trial)=0; %%if participant press the yes button for nonwords
                 rt(trial)=k/fps;
                 s=0;
            end 
            %if keyCode(y) && (~isempty(strmatch(LDTwords(trial), verbs))) && x>1
            targetTrials=[31,80,127,154,186, 215]; %defining the target trials
            targetTrials2=targetTrials+1 ; %the target immediatly following the target trials
            if keyCode(y) && (any(targetTrials==trial)) && x>stimDuration *3
                t8=GetSecs-t0;
                PMkey(z)=1;
                PMrt(z)=k/fps;
                x=0;
            end
            
            if keyCode(y) && (any(targetTrials2==trial)) && x>stimDuration*3             %if they press the key button in the trial after the target trial (verbs)
                t8=GetSecs-t0;
                PMkey(z)=1;
                PMrt(z)=(k/fps)+ (stimDuration+crossDuration)/fps;
                x=0;

            end
           % if( trial == 21 || trial == 31 || trial==48 || trial ==62 || trial == 90 || trial== 110) && s>stimDuration
               %% z=z+1
                %if (keyCode(y))
                 %   t8=GetSecs-t0;
                  %  PMkey(z)=1
                %else if ~(keyCode(y))
                       % PMkey(z)=0
                %end
                %end
end
             x=x+1;
             w=w+1;
             s=s+1;
%end
 
     
                 %now it is time to flip everything is on the screen                   
 Screen('Flip', MyScreen); 
 end
   WaitSecs(1);
   scorePR=['Your score is ',num2str((sum(score)/trial)*100),' %'];
   Screen('TextSize', MyScreen, 25  )
   DrawFormattedText(MyScreen,'Thank you for completing the task!','center', rect(3)/4   , [255 255 255]);
   DrawFormattedText(MyScreen,'Please approach the experimenter before continuing','center', rect(3)/2 , [255 255 255]);
   DrawFormattedText(MyScreen,'Press the SPACE BAR when you are ready to continue','center', rect(3)/1.5 , [255 255 255]);
   Screen('Flip', MyScreen);
   WaitSecs(1);
   KbWait();
   %wait for response to continue
 
  EBPMscore.scoreLDT=score;
  EBPMscore.LDTrt=rt;
  EBPMscore.PM=PMkey;
  EBPMscore.PMrt=PMrt;
    
 Screen('CloseAll')

 
 catch
 Screen('CloseAll')
 rethrow(lasterror)
end
end
 




