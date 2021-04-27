This documentation is useful for those who wants to configure Date,Time,Number to speech in Asterisk.

### Introduction

 In order to configure number to speech in asterisk.We need to edit /etc/asterisk/say.conf file.By default there are number to speech configurations for English,German and itly..etc languages.If you want to make asterisk to speak your language, we have to do some configurations on this.For example we can say, in say.conf file by default we are able to see the configuration settings for englise as [en] and itly as [it]. Here I attached sample text of say.conf for english.


[digit-base](!)         ; base rule for digit strings
                        ; XXX incomplete yet
    _digit:[0-9] => digits/${SAY}
    _digit:[-] => letters/dash
    _digit:[*] => letters/star
    _digit:[@] => letters/at
    _digit:[0-9]. => digit:${SAY:0:1}, digit:${SAY:1}

[date-base](!)          ; base rules for dates and times
    ; the 'SAY' variable contains YYYYMMDDHHmm.ss-dow-doy
    ; these rule map the strftime attributes.
    _date:Y:. => num:${SAY:0:4} ; year, 19xx
    _date:[Bbh]:. => digits/mon-$[${SAY:4:2}-1]                 ; month name, 0..11
    _date:[Aa]:. => digits/day-${SAY:16:1}      ; day of week
    _date:[de]:. => num:${SAY:6:2}              ; day of month
    _date:[H]:. => digits/oh, num:${SAY:8:2}
     ; hour (oh one, oh two, ..., oh nine, ten, eleven, ..., twenty-three)
    _date:[I]:. => num:$[${SAY:8:2} % 12]       ; hour 0-12
    _date:[M]:. => num:${SAY:10:2}              ; minute
    ; XXX too bad the '?' function does not remove the quotes
    ; _date:[pP]:. => digits/$[ ${SAY:10:2} > 12 ? "p-m" :: "a-m"]      ; am pm
    _date:[pP]:. => digits/p-m  ; am pm
    _date:[S]:. => num:${SAY:13:2}              ; seconds
    _date:[Ii]:. => num:$[${SAY:8:2} % 12]                      ; hour 0-12
    _date:[k]:. => num:${SAY:8:2}                               ; hour (one, two. three, ...,twenty three
    _date:[m]:. => num:${SAY:4:2}                               ; month number
    _date:[Q]:. => date:dby ;incompleat                         ; "today", "yesterday" or ABdY
    _date:[q]:. => date:dby ;incompleat                         ; "" (for today), "yesterday", weekday, or ABdY
    _date:[R]:. => date:HM${SAY}                                ; 24 hour time, including minute
    _date:[T]:. => date:HMS${SAY}                               ; 24 hour, minure, seconds


[en-base](!)  ; this is macro you have to find out exact [en] where this macro has been included.
    _[n]um:0. => num:${SAY:1}
    _[n]um:X => digits/${SAY}
    _[n]um:1X => digits/${SAY}
    _[n]um:[2-9]0 =>  digits/${SAY}
    _[n]um:[2-9][1-9] =>  digits/${SAY:0:1}0, num:${SAY:1}
    _[n]um:X00 => num:${SAY:0:1}, digits/hundred
    _[n]um:XXX => num:${SAY:0:1}, digits/hundred, num:${SAY:1}

    _[n]um:X000 => num:${SAY:0:1}, digits/thousand
    _[n]um:XXXX => num:${SAY:0:1}, digits/thousand, num:${SAY:1}
    _[n]um:XX000 => num:${SAY:0:2}, digits/thousand
    _[n]um:XXXXX => num:${SAY:0:2}, digits/thousand, num:${SAY:2}
    _[n]um:XXX000 => num:${SAY:0:3}, digits/thousand
    _[n]um:XXXXXX => num:${SAY:0:3}, digits/thousand, num:${SAY:3}

    _[n]um:X000000 => num:${SAY:0:1}, digits/million
    _[n]um:XXXXXXX => num:${SAY:0:1}, digits/million, num:${SAY:1}
    _[n]um:XX000000 => num:${SAY:0:2}, digits/million
    _[n]um:XXXXXXXX => num:${SAY:0:2}, digits/million, num:${SAY:2}
    _[n]um:XXX000000 => num:${SAY:0:3}, digits/million
    _[n]um:XXXXXXXXX => num:${SAY:0:3}, digits/million, num:${SAY:3}

    _[n]um:X000000000 => num:${SAY:0:1}, digits/billion
    _[n]um:XXXXXXXXXX => num:${SAY:0:1}, digits/billion, num:${SAY:1}
    _[n]um:XX000000000 => num:${SAY:0:2}, digits/billion
    _[n]um:XXXXXXXXXXX => num:${SAY:0:2}, digits/billion, num:${SAY:2}
    _[n]um:XXX000000000 => num:${SAY:0:3}, digits/billion
    _[n]um:XXXXXXXXXXXX => num:${SAY:0:3}, digits/billion, num:${SAY:3}

[en](en-base,date-base,digit-base) ;here we have included macros we are going to use.
    _datetime::. => date:AdBY 'digits/at' IMp:${SAY}
    _date::. => date:AdBY:${SAY}
    _time::. => date:IMp:${SAY}


Above all are implemented using asterisk pattern matching techniques . If you don't know about asterisk pattern matching please have look on

http://www.automated.it/asterisk/lah-3-6-05_3.html
http://www.the-asterisk-book.com/unstable/einleitung-regex.html .

let us play the number 25,376 using following example .

## On Dialplan

	[sample]
	exten = s,1,NoOp(PlayNumber)
	exten = s,n,Set(CHANNEL(language)=en) ; by default it would be english only .
	exten = s,n,Playback(num:25376|say);
	exten = s,n,hangup
	
	Note:
      	----- 	
	If you are using asterisk-1.6 and above version; then replace ',' with '|' as playback(num:25376,say)




## Explanation

	When the asterisk executes the playback(num:25376|say); it matches with say.conf for english(en) . As per the above configuration; 
	so the hit should be in 

	_[n]um:XXXXX => num:${SAY:0:2}, digits/thousand, num:${SAY:2} line.

	Note: 
	X means [0-9] so, [0-9][0-9][0-9][0-9] (four digit count)
        Meaning of ${SAY:0:2} is 0 => Index postion, 2 => Count character to pickup.

	
	We just match this with recursive functionality in programming.
	
	When the flow is on the above line, say variable has 25376. Then it start to execute num:${SAY:0:2} and it goes for pattern 
	matching with _[n]um:[2-9][1-9] => digits/${SAY:0:1}0, num:${SAY:1} using the number 25( ${SAY:0:2} ).
	Now the say variable has 25.
	
	Now we hear twenty(20) using digits/${SAY:0:1}0.Then again it goes for the line
	=> _[n]um:X => digits/${SAY} using num:${SAY:1}.Now the say variable has 5. Now we hear five(5).
	
	Right now, we are completed the first part of this line _[n]um:XXXXX => num:${SAY:0:2}, digits/thousand, num:${SAY:2} . Then asterisk
	play thousand( 1000 ).
	
	Now num:${SAY:2} has 376 it skips 25 thousands because it was played.Follow the above steps again for 376 to get three hundred 
	seventy six.
	
	which are the patterns have _[n]um; you just take it as recursive function.
	
	That's it.We are now familiar with asterisk say.conf.
	

## Number,Date,Time to voice or speech configuration settings for Indian English

	In indian english,there is a change in reading numbers.we used to read this number as 254560 "two lack fifty four thousand five 
	hundred sixty".To achive this; here is the configuration for reading indian english numbers.Replace this in say.conf en-base 
	context.


	[en_IN](date-base,digit-base)
	    _[n]um:0. => num:${SAY:1} ;just to skip the preceeding '0';
	    _[n]um:X => digits/${SAY}
	    _[n]um:1X => digits/${SAY}
	    _[n]um:[2-9]0 =>  digits/${SAY}
	    _[n]um:[2-9][1-9] =>  digits/${SAY:0:1}0,num:${SAY:1}
	    _[n]um:X00 => num:${SAY:0:1}, digits/hundred
	    _[n]um:XXX => num:${SAY:0:1}, digits/hundred,num:${SAY:1}
	
	    _[n]um:X000 => num:${SAY:0:1}, digits/thousand
	    _[n]um:XXXX => num:${SAY:0:1}, digits/thousand,num:${SAY:1}
	    _[n]um:XX000 => num:${SAY:0:2}, digits/thousand
	    _[n]um:XXXXX => num:${SAY:0:2}, digits/thousand,num:${SAY:2}
	
	    _[n]um:X00000 => num:${SAY:0:1},digits/lack
	    _[n]um:XXXXXX => num:${SAY:0:1},digits/lack,num:${SAY:1}
	    _[n]um:XX00000 => num:${SAY:0:2},digits/lack
	    _[n]um:XXXXXXX => num:${SAY:0:2},digits/lack,num:${SAY:2}
	
	    _[n]um:X0000000 => num:${SAY:0:1},digits/crore
	    _[n]um:XXXXXXXX => num:${SAY:0:1},digits/crore,num:${SAY:1}
	    _[n]um:XX0000000 => num:${SAY:0:2},digits/crore
	    _[n]um:XXXXXXXXX => num:${SAY:0:2},digits/crore,num:${SAY:2}
	    _[n]um:XXX0000000 => num:${SAY:0:3},digits/crore
	    _[n]um:XXXXXXXXXX => num:${SAY:0:3},digits/crore,num:${SAY:3}
	    _[n]um:XXXX0000000 => num:${SAY:0:4},digits/crore
	    _[n]um:XXXXXXXXXXX => num:${SAY:0:4},digits/crore,num:${SAY:4}
	    _[n]um:XXXXX0000000 => num:${SAY:0:5},digits/crore
	    _[n]um:XXXXXXXXXXXX => num:${SAY:0:5},digits/crore,num:${SAY:5}
	    _[n]um:XXXXXX0000000 => num:${SAY:0:6},digits/crore
	    _[n]um:XXXXXXXXXXXXX => num:${SAY:0:6},digits/crore,num:${SAY:6}
	    _[n]um:XXXXXXX0000000 => num:${SAY:0:7},digits/crore
	    _[n]um:XXXXXXXXXXXXXX => num:${SAY:0:7},digits/crore,num:${SAY:7}
	
	    _datetime::. => date:AdBY 'digits/at' IMp:${SAY}
	    _date::. => date:AdBY:${SAY}
	    _time::. => date:IMp:${SAY}
	
### Notes

 	1) Record "lack,crore" or download from https://github.com/ashikali/Regional-Asterisk-Number-Date-Time-to-speech-settings and place 
	   it in  /var/lib/asterisk/sounds/en/digits directory before going to apply above settings for india english number system.

## Number,Date,Time to voice or speech configuration settings for Arabic

	In Arabic number system quite different from english number system.There is a small changes in reading two digit numbers 
	such as 11,23,67..99. Remaining methodologies are same as english.

        For example,
		34 => "orbaha va thalathun" just reverse interpretation in english. Instead of "thirty four", "four thirty" that is it.

[ar](date-base,digit-base)
    [ar](date-base,digit-base)
    _[n]um:0. => num:${SAY:1} ;just skip the preceeding '0'  000 results 0 this 0 will hit again
			      ;coz . means it should have some digits on that.
    _[n]um:X => digits/${SAY}
    _[n]um:1[1-9] =>  digits/${SAY} ;z 1-9 so 10,20,30 ..90
    _[n]um:Z0 =>  digits/${SAY} ;z 1-9 so 10,20,30 ..90
    _[n]um:[2-9][1-9] => digits/${SAY:1},digits/and,digits/${SAY:0:1}0
    _[n]um:[1-2]00 =>  digits/${SAY} ;100,200 voice should be
    _[n]um:[3-9]00 => digits/${SAY:0:1},digits/100
    _[n]um:[1-2]XX =>  digits/${SAY:0:1}00,digits/and,num:${SAY:1}
    _[n]um:[3-9]XX => digits/${SAY:0:1},digits/100,digits/and,num:${SAY:1}

    _[n]um:[1-2]000 => digits/${SAY} ;1000,2000 voice should be
    _[n]um:[3-9]000 => digits/${SAY:0:1}, digits/1000
    _[n]um:[1-2]XXX => digits/${SAY:0:1}000,digits/and,num:${SAY:1}
    _[n]um:[3-9]XXX => digits/${SAY:0:1},digits/1000,digits/and,num:${SAY:1}
    _[n]um:XX000 => num:${SAY:0:2},digits/1000
    _[n]um:XXXXX => num:${SAY:0:2},digits/1000,digits/and,num:${SAY:2} ;${say:index:count}
    _[n]um:XXX000 => num:${SAY:0:3},digits/1000
    _[n]um:XXXXXX => num:${SAY:0:3},digits/1000,digits/and,num:${SAY:3}

    _[n]um:1000000 => digits/million
    _[n]um:X000000 => digits/${SAY:0:1}, digits/million
    _[n]um:1XXXXXX => digits/million,digits/and,num:${SAY:1}
    _[n]um:XXXXXXX => digits/${SAY:0:1}, digits/million,digits/and,num:${SAY:1}
    _[n]um:XX000000 => num:${SAY:0:2},digits/million
    _[n]um:XXXXXXXX => num:${SAY:0:2}, digits/million,digits/and,num:${SAY:2}
    _[n]um:XXX000000 => num:${SAY:0:3}, digits/million
    _[n]um:XXXXXXXXX => num:${SAY:0:3}, digits/million,digits/and,num:${SAY:3}

    _[n]um:1000000000 => digits/billion
    _[n]um:X000000000 => digits/${SAY:0:1}, digits/billion
    _[n]um:1XXXXXXXXX => digits/billion,digits/and,num:${SAY:1}
    _[n]um:XXXXXXXXXX => digits/${SAY:0:1}, digits/billion,digits/and,num:${SAY:1}
    _[n]um:XX000000000 => num:${SAY:0:2}, digits/billion
    _[n]um:XXXXXXXXXXX => num:${SAY:0:2}, digits/billion,digits/and, num:${SAY:2}
    _[n]um:XXX000000000 => num:${SAY:0:3}, digits/billion
    _[n]um:XXXXXXXXXXXX => num:${SAY:0:3}, digits/billion,digits/and, num:${SAY:3}

    _datetime::. => date:AdBY 'digits/at' IMp:${SAY}
    _date::. => date:AdBY:${SAY}
    _time::. => date:IMp:${SAY}


### Note

    - above settings will be useful for those who have limited voices rather than 0..99.

    - You can download arabic voice files from https://github.com/ashikali/Asterisk-Number-Date-Time-to-speech-settings.
      it does not contain 0..99,date and time voice files. Just it has to cover number part for above settings.

## How to Workout:

To make it effect in asterisk just run the following command in asterisk console. 

*CLI> module reload app_playback.so

  or 

*CLI> reload 

### On Dialplan:

        [sample]
        exten => s,1,NoOp(PlayNumber)
        exten => s,n,Set(CHANNEL(language)=en) ; by default it would be english only .
        exten => s,n,Playback(num:25376|say);  ; for number
	exten => s,n,playback(datetime::201104172030.00-4-102,say) ; for date
        exten => s,n,hangup

### Note:

  If you are using asterisk-1.6 and above version; then replace ',' with '|' as playback(num:25376,say)


### On AGI

        I don't know whether it is bug or not.For both 1.4 and 1.6;  we have to use '|' although it is 1.6.

	** On 1.8 and above **

		#!/usr/bin/perl -w
		
		use Asterisk::AGI;
		
		my $AGI = new Asterisk::AGI,$result;
		$AGI->exec("PLAYBACK num:2415312511,say \"\"\n");
		$AGI->exec("PLAYBACK datetime::201104172030.00-4-102,say \"\"\n"); # for date
		exit;

	** On 1.4 and 1.6 **

                #!/usr/bin/perl -w

                use Asterisk::AGI;

                my $AGI = new Asterisk::AGI,$result;
                $AGI->exec("PLAYBACK num:2415312511|say \"\"\n");
		$AGI->exec("PLAYBACK datetime::201104172030.00-4-102|say \"\"\n"); # for date
                exit;

       ** In the php-agi, call as follows **

		$agi->exec("PlayBack","num:{$info[0]},say");

----------------------------------------------------------------------------------------------------

## number_to_arabic.rb

This is a small recursive ruby program which convert number to Playable format or Text format.

## For example

If you call the function ar_number_to_voice with 4434 mentioned in the sample function call inside the number_to_arabic.rb file.

The output will be.

digits/4 digits/1000 digits/and digits/4 digits/100 digits/and digits/4 digits/and digits/30

in the WEB applications you can play corresponding sound files respectively.

## How to change the output format

if you want to change the format in case you want print as arabic text then inside the function
         you can replace the digits/4 with 'ﺃﺮﺒﻋﺓ'
         you can replace the digits/1000 with 'ﺄﻠﻓ'
         you can replace the digits/and with 'ﻭ'
         you can replace the digits/100 with 'ﻡﺎﺋﺓ' respectively.



Cheers,
Ashik
