//
// dailySchedule.h
//

#include "syslog.h"
#ifndef SYSLOG_H
#error "This module requires the syslog module."
#error "https://github.com/diegesisandmimesis/syslog"
#error "It should be in the same parent directory as this module.  So if"
#error "dailySchedule is in /home/user/tads/dailySchedule, then"
#error "syslog should be in /home/user/tads/syslog ."
#endif // SYSLOG_H

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
