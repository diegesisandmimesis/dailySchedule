#charset "us-ascii"
//
// dailySchedule.t
//
//	An extension to the calendar and targetEngine modules for implementing
//	NPC daily schedules.
//
//
// USAGE
//
//	The basic unit of a schedule is the DailyActivity.  It defines
//	something the NPC does during one or more periods during the day.
//	The periods are the "slots" in a daily cycle as defined in the
//	calendar module (early -> morning -> afternoon -> evening -> night).
//
//	The template for an activity is:
//
//		DailyActivity 'activityID' [ periods ] @location;
//
//	...where...
//
//		activityID	a unique ID for the activity
//		periods		a list of the period IDs the activity occurs in
//		location	an optional room to move to for the activity
//
//	In addition to the basic template, the following methods can be
//	declared on an DailyActivity:
//
//		startActivity()		called when the activity starts
//		endActivity()		called when the activity ends
//		activityAction()	called every turn (except the first
//					and last) during the period when the
//					activity is happening
//
//
//	The basic use case is to define a NPC's daily schedule by
//	declaring DailyActivity instances directly on the Actor definition:
//
//		alice: Person 'Alice' 'Alice'
//			"She looks like the first person you'd turn to in
//			a problem. "
//
//			isHer = true
//			isProperName = true
//		;
//		+DailyActivity 'work' [ 'morning', 'afternoon', 'evening' ]
//			@aliceShop
//
//			startActivity() {
//				mainReport('Alice starts work for the day. ');
//			}
//			endActivity() {
//				mainReport('Alice finishes work for the day. ');
//			}
//			activityAction() {
//				mainReport('Alice does some work. ');
//			}
//		;
//		+DailyActivity 'home' [ 'night', 'early' ] @aliceHouse;
//
//	In this case Alice will move to the room aliceShop during the
//	day (during the morning, afternoon and evening) if she isn't already
//	there.  Once there, the message "Alice starts work for the day." will
//	be displayed (if the player is in Alice's location).  After that
//	"Alice does some work." will be displayed every turn.  When it
//	is no longer morning, afternoon, or evening, "Alice finishes work for
//	the day." will be displayed.  The following turn Alice will begin
//	moving toward the aliceHome room.
//
//
#include <adv3.h>
#include <en_us.h>

#include "dailySchedule.h"

// Module ID for the library
dailyScheduleModuleID: ModuleID {
        name = 'Daily Schedule Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

class DailyScheduleObject: Syslog syslogID = 'DailySchedule';

class DailySchedule: DailyScheduleObject, AgendaItem, EventListener
	agendaOrder = 700

	scheduleID = nil
	initiallyActive = nil

	dailyActivityClass = DailyActivity
	_dailyActivities = nil

	isDefaultSchedule = nil

	isReady = (getCurrentActivity() != nil)

	lastActivity = nil
	newActivityFlag = nil

	initDailyActivities() {
		_dailyActivities = new LookupTable();
	}

	addDailyActivity(obj) {
		if((obj == nil) || !obj.ofKind(dailyActivityClass))
			return(nil);

		if(_dailyActivities == nil)
			initDailyActivities();

		obj.getPeriod().forEach(function(o) {
			_dailyActivities[o] = obj;
		});

		return(true);
	}

	getCurrentActivity() {
		return(_dailyActivities
			? _dailyActivities[gCalendar.matchPeriod()]
			: nil);
	}

	invokeItem() {
		local a, o;

		if((a = getCurrentActivity()) == nil)
			return;

		o = lastActivity;

		if(a != o) {
			if(o != nil)
				endActivity(o);
			lastActivity = a;
			newActivityFlag = true;
		}

		if(checkActivityLocation(a) != true)
			return;

		if(newActivityFlag == true) {
			newActivityFlag = nil;
			a.startActivity();
		} else {
			a.activityAction();
		}
	}

	endActivity(act) {
		if(act == nil)
			return(nil);

		if(act.targetLocation != nil)
			getActor().clearMoveTo(act.targetLocation);

		return(true);
	}

	checkActivityLocation(act) {
		local actor;

		if(act.targetLocation == nil)
			return(true);

		if((actor = getActor()) == nil)
			return(nil);

		if(actor.location != act.targetLocation) {
			actor.moveTo(act.targetLocation);
			return(nil);
		}

		return(true);
	}
;
