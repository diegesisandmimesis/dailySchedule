//
// dailySchedule.h
//

#ifndef CALENDAR_EVENTS
#error "This module must be compiled with the -D CALENDAR_EVENTS flag"
#endif // CALENDAR_EVENTS

#include "syslog.h"
#ifndef SYSLOG_H
#error "This module requires the syslog module."
#error "https://github.com/diegesisandmimesis/syslog"
#error "It should be in the same parent directory as this module.  So if"
#error "dailySchedule is in /home/user/tads/dailySchedule, then"
#error "syslog should be in /home/user/tads/syslog ."
#endif // SYSLOG_H

#include "eventHandler.h"
#ifndef EVENT_HANDLER_H
#error "This module requires the eventHandler module."
#error "https://github.com/diegesisandmimesis/eventHandler"
#error "It should be in the same parent directory as this module.  So if"
#error "dailySchedule is in /home/user/tads/dailySchedule, then"
#error "eventHandler should be in /home/user/tads/eventHandler ."
#endif // EVENT_HANDLER_H

#include "calendar.h"
#ifndef CALENDAR_H
#error "This module requires the calendar module."
#error "https://github.com/diegesisandmimesis/calendar"
#error "It should be in the same parent directory as this module.  So if"
#error "dailySchedule is in /home/user/tads/dailySchedule, then"
#error "calendar should be in /home/user/tads/calendar ."
#endif // CALENDAR_H

#include "targetEngine.h"
#ifndef TARGET_ENGINE_H
#error "This module requires the targetEngine module."
#error "https://github.com/diegesisandmimesis/targetEngine"
#error "It should be in the same parent directory as this module.  So if"
#error "dailySchedule is in /home/user/tads/dailySchedule, then"
#error "targetEngine should be in /home/user/tads/targetEngine ."
#endif // TARGET_ENGINE_H

DailyActivity template 'activityID' 'period' @targetLocation?;
DailyActivity template 'activityID' [ period ] @targetLocation?;

#define DAILY_SCHEDULE_H
