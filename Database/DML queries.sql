-- clean db
delete from confidence;
delete from history;
delete from coverage;
delete from patient;
delete from doctor;
delete from illness;
delete from insurance;

-- illness
insert into illness values('cold', 0);
insert into illness values('flue', 0);
insert into illness values('HIV', 2);

-- insurance
insert into insurance values('iran'),('asia'),('mihan');

-- patient
call add_patient('123', '1256' , 'emran', now(), 'male', 'iran', 'mihan','bachelor','student','tehran',false);
call add_patient('321', '1256' , 'mehdi', now(), 'male', 'iran', 'asia','bachelor','student','tehran',true);
call add_patient('213', '1256' , 'fateme', now(), 'female', 'iran', 'iran','bachelor','student','ahvaz',false);

-- doctorconfidence
call add_doctor('456','1256','mammad','orology');
call add_doctor('654','1256','asghar','ortopedy');

-- drugstore keeper
call add_drugstore_keeper('789', '1256', 'iman');

-- coverage
insert into coverage values( 'cold' , 'iran' , 50 ) ;
insert into coverage values( 'HIV'  , 'asia' ,  100 ) ;
insert into coverage values( 'cold' , 'asia' , 20 ) ;