
generate competingeventdate = deathdate
generate eventdate = min(eventofinterestdate,competingeventdate, exitdate)

generate event = 0 if eventdate == exitdate
replace event = 2 if eventdate == competingeventdate
replace event = 1 if eventdate == eventofinterestdate
generate timetoevent = (eventdate - entrydate)/365.24

