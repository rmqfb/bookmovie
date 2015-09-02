begin
    -- 프로시저 삭제
    for i in (
        select object_name from user_procedures
    ) loop
        execute immediate 'drop procedure ' || i.object_name;
    end loop;


   -- R constraint 삭제
   for i in (
         select
            col.table_name,
                 col.constraint_name
         from
                 user_cons_columns col
                 join user_constraints con on col.constraint_name = con.constraint_name
         where
                 con.constraint_type = 'R'
      ) loop
      
      execute immediate 'alter table ' || i.table_name || ' drop constraint ' || i.constraint_name;
   end loop;

   -- 테이블 제거
   for i in (select tname from tab) loop
      execute immediate 'drop table ' || i.tname || ' purge';
   end loop;

   -- 시퀀스 제거
   for i in (select sequence_name from user_sequences) loop
      execute immediate 'drop sequence ' || i.sequence_name;
   end loop;
end;
/