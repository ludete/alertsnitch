DROP PROCEDURE IF EXISTS del_data;
DROP EVENT IF EXISTS del_event;

-- 1. 创建mysql存储过程

delimiter $$
CREATE PROCEDURE `del_data`(IN `date_inter` int)
BEGIN
delete from alertsnitch.AlertGroup where time < date_sub(curdate(), interval date_inter day);
END $$
delimiter ;


-- 2. 创建定时任务事件

create event del_event
on schedule EVERY 1 day  STARTS '2023-05-22 16:15:00'
ON COMPLETION  PRESERVE ENABLE
do  call del_data(7);

-- 3. 启动事件调度器

SET GLOBAL event_scheduler=on;