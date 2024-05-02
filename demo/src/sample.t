#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the dailySchedule library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

#include "dailySchedule.h"

versionInfo: GameID;
gameMain: GameMainDef
	initialPlayerChar = me

	inlineCommand(cmd) { "<b>&gt;<<toString(cmd).toUpper()>></b>"; }
	printCommand(cmd) { "<.p>\n\t<<inlineCommand(cmd)>><.p> "; }

	newGame() {
		gCalendar.setDailyCycle(simpleDay);
		inherited();
	}
	showIntro() {
		"In this demo, Alice has a simple daily schedule in which
		she goes to her shop in town during the day and returns
		home at night. ";
		"<.p> ";
		"Use <<inlineCommand('advance time')>> to skip to the next
		slot in the daily cycle (afternoon becomes evening,
		evening becomes night, and so on).  You can also
		use <<inlineCommand('check time')>> to view the current time
		period. ";
		"<.p> ";
		"The demo uses the system time as the starting time for
		the game. ";
		"<.p> ";
	}
;

modify bedroom;
+me: Person;

modify alice location = aliceHouse;
+DailyActivity 'work' [ 'morning', 'afternoon', 'evening' ] @aliceShop
	startActivity() { mainReport('Alice starts work for the day. '); }
	endActivity() { mainReport('Alice finishes work for the day. '); }
	activityAction() { mainReport('Alice does some work. '); }
;
+DailyActivity 'home' [ 'night', 'early' ] @aliceHouse;
