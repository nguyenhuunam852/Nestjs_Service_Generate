-- alter table test1.table_property add column RequestDto varchar(100);
-- alter table test1.table_property add column NewDto varchar(100);
-- alter table test1.table_property add column ClassName varchar(100);
-- alter table test1.table_property add column ClassNamenots varchar(100);
-- alter table test1.table_property add column variable varchar(100);
SET SQL_SAFE_UPDATES = 0;
-- select * from test1.table_property 
-- use test;
-- show tables like '%exam%';
-- select * from pivot_exam_question;
-- delete from test1.table_property where table_name = 'promotions';
-- select * from test1.table_property;
-- delete from test1.table_property where table_name = 'pivot_user_promotion';
select * from test1.table_property;
set @table_name = 'pivot_course_unit';
set @Class_name_entity = 'Pivot_Course_Unit';
set @Class_name = 'Pivot_Course_Unit';
set @Variable= 'pivotcourseunit';
set @table_namenots = 'pivot_course_unit';

-- update test1.table_property set
-- table_name = @table_name,
-- repo_service = concat(@Class_name,'Service'),
-- payload_dto = concat(@Class_name,'PayLoadDto'),
-- entity_list_dto = concat(@Class_name,'ResponseListDto'),
-- RequestDto =  Concat(@Class_name,'RequestDto'),
-- NewDto = Concat(@Class_name,'NewDto'),
-- UpdateDto = Concat(@Class_name,'UpdateDto'),
-- Classname = @Class_name_entity,
-- ClassNamenots = @Class_name,
-- variable = @Variable
-- where table_name = @table_name ;
-- where id =5

insert into test1.table_property 
(
table_name,
table_namenots,
repo_service,
payload_dto,
entity_list_dto,
RequestDto,
NewDto,
UpdateDto,
Classname,
ClassNamenots,
variable
)
values
( 
  @table_name,
  @table_namenots,
  concat(@Class_name,'Service'),
  concat(@Class_name,'PayLoadDto'),
  concat(@Class_name,'ResponseListDto'),
  concat(@Class_name,'RequestDto'),
  concat(@Class_name,'NewDto'),
  concat(@Class_name,'UpdateDto'),
  @Class_name_entity,
  @Class_name,
  @Variable
);
-- create table test1.table_property (
--    table_name varchar(100),
-- repo_service varchar(100),
-- payload_dto varchar(100),
-- entity_list_dto varchar(100),
-- RequestDto varchar(100),
-- NewDto varchar(100),
-- UpdateDto varchar(100),
-- Classname varchar(100),
-- ClassNamenots varchar(100),
-- variable varchar(100)
-- );





