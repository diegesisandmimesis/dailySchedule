#charset "us-ascii"
//
// dailySchedule.t
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

class DailySchedule: DailyScheduleObject, AgendaItem
	agendaOrder = 700

	initiallyActive = true

	dailyActivityClass = DailyActivity
	_dailyActivities = nil

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

	targetLocationCallback(rm, status) {
	}
;
