set @table_name = 'units';
SET @database_name_entity = 'cyberjustsu_dtb';
SET @key_id = 'unit_id';

select "import { Get, Injectable, Query } from '@nestjs/common';"
UNION ALL
select "import { Items } from 'src/entities/course/items';"
UNION ALL
select "import { InjectRepository } from '@nestjs/typeorm';"
UNION ALL
select "import { Repository } from 'typeorm';"
UNION ALL
select Concat("@Injectable()\nexport class ",(select repo_service from test1.table_property where table_name = @table_name)," {") as command
UNION ALL
select Concat("constructor(")
UNION ALL
select Concat("@InjectRepository(",(select ClassName from test1.table_property where table_name = @table_name),")\n","private readonly ",(select repo_service from test1.table_property where table_name = @table_name),": Repository<",(select ClassName from test1.table_property where table_name = @table_name),">,")
UNION ALL
(
   select
   concat("@InjectRepository(",(select ClassName from test1.table_property where table_name = referenced_table_name),")\n"
   "private readonly ",(select repo_service from test1.table_property where table_name = referenced_table_name),": Repository<",(select ClassName from test1.table_property where table_name = referenced_table_name),">,")
FROM information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA= @database_name_entity
AND k.CONSTRAINT_SCHEMA = @database_name_entity
AND i.TABLE_NAME = @table_name
)
UNION ALL
select
case when parent_table.table_name not in (
          select table_name 
          from information_schema.columns c
          where c.table_name In (
              select table_name 
              FROM information_schema.KEY_COLUMN_USAGE
              WHERE table_schema = @database_name_entity
              AND referenced_table_name = @table_name
          ) 
          and c.table_schema = @database_name_entity
          and c.column_name not in (
              SELECT k.REFERENCED_COLUMN_NAME
              FROM information_schema.TABLE_CONSTRAINTS i 
              LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
              WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
              AND i.CONSTRAINT_SCHEMA = @database_name_entity
              AND k.CONSTRAINT_SCHEMA = @database_name_entity
              AND i.TABLE_NAME = c.table_name
         )
         and c.column_name not in(
           'create_at',
           'update_at',
           'delete_at'
         )
         group by c.table_name
)
then (
  SELECT 
   concat("@InjectRepository(",(select ClassName from test1.table_property where table_name = referenced_table_name),")\n"
   "private readonly ",(select repo_service from test1.table_property where table_name = referenced_table_name),": Repository<",(select ClassName from test1.table_property where table_name = referenced_table_name),">,")
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
)
else(
   SELECT case 
   when(
     'pivot_id' not in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
   )
   then(
   select 
	concat("@InjectRepository(",(select ClassName from test1.table_property where table_name = parent_table.table_name ),")\n"
   "private readonly ",(select repo_service from test1.table_property where table_name =parent_table.table_name),": Repository<",(select ClassName from test1.table_property where table_name = parent_table.table_name ),">,")
   )
   else(
   concat(
   (
   select 
   Concat("@InjectRepository(",(select ClassName from test1.table_property where table_name = referenced_table_name ),")\n"
   "private readonly ",(select repo_service from test1.table_property where table_name = referenced_table_name ),": Repository<",(select ClassName from test1.table_property where table_name = referenced_table_name ),">,\n")
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
   ),
   "@InjectRepository(",(select ClassName from test1.table_property where table_name = parent_table.table_name ),")\n"
   "private readonly ",(select repo_service from test1.table_property where table_name = parent_table.table_name ),": Repository<",(select ClassName from test1.table_property where table_name = parent_table.table_name ),">,")
  )
  end 
)
end as command
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL
(
select
   concat("@InjectRepository(",(select ClassName from test1.table_property where table_name = referenced_table_name ),")\n"
   "private readonly ",(select repo_service from test1.table_property where table_name = referenced_table_name ),": Repository<",(select ClassName from test1.table_property where table_name = referenced_table_name ),">,")
FROM information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA= @database_name_entity
AND k.CONSTRAINT_SCHEMA = @database_name_entity
AND i.TABLE_NAME = @table_name
)
UNION ALL
select ") { }"
UNION ALL
-- create Method
select Concat("async createNew",(select ClassNamenots from test1.table_property where table_name = @table_name),"(",(select variable from test1.table_property where table_name = @table_name),": crud",(select ClassNamenots from test1.table_property where table_name = @table_name),"Dto, user_id: string = undefined) {")
UNION ALL
select "try {"
UNION ALL
(
select
Concat(
"if(",(select variable from test1.table_property where table_name = @table_name),".",
 (
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
)
,"){\n"
"var get_",(select variable from test1.table_property where table_name = referenced_table_name)," = await this.",(select repo_service from test1.table_property where table_name = referenced_table_name),".findOne({ ",
 (
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
)
,": ",(select variable from test1.table_property where table_name = @table_name),".",(
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
)," })\n",
" if (!get_",(select variable from test1.table_property where table_name = referenced_table_name),") throw '",(select variable from test1.table_property where table_name = referenced_table_name),"_NOT_FOUND';\n}"
)
FROM information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA= @database_name_entity
AND k.CONSTRAINT_SCHEMA = @database_name_entity
AND i.TABLE_NAME = @table_name
)
UNION ALL
select concat(
"var new_",(select variable from test1.table_property where table_name =@table_name)," = await this.",(select repo_service from test1.table_property where table_name =@table_name),".create({")
UNION ALL
select a.command from (
  select case 
  when c.Column_key = 'PRI'
  then(
    select ''
  )
  when c.column_name = 'creator_id' 
  then(
     select concat(c.column_name,":user_id,")
  )
  when c.Column_key != 'PRI' or c.column_name!= 'creator_id'
  then (
   select concat(c.column_name,":",(select variable from test1.table_property where table_name = @table_name),'.',c.column_name,",")
  )
  end as command
  from information_schema.columns c
  where 
  c.table_name = @table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME not in ('created_at','updated_at','deleted_at')  
) a
UNION ALL
select concat("});\nawait this.",(select repo_service from test1.table_property where table_name = @table_name) ,".save(new_",(select variable from test1.table_property where table_name = @table_name),");")
UNION ALL


-- Many to Many Check 
select
case when parent_table.table_name not in (
          select table_name 
          from information_schema.columns c
          where c.table_name In (
              select table_name 
              FROM information_schema.KEY_COLUMN_USAGE
              WHERE table_schema = @database_name_entity
              AND referenced_table_name = @table_name
          ) 
          and c.table_schema = @database_name_entity
          and c.column_name not in (
              SELECT k.REFERENCED_COLUMN_NAME
              FROM information_schema.TABLE_CONSTRAINTS i 
              LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
              WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
              AND i.CONSTRAINT_SCHEMA = @database_name_entity
              AND k.CONSTRAINT_SCHEMA = @database_name_entity
              AND i.TABLE_NAME = c.table_name
         )
         and c.column_name not in(
           'create_at',
           'update_at',
           'delete_at'
         )
         group by c.table_name
)
then (
  SELECT 
  Concat(
  "if(",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),") {",
  "var list_",(select variable from test1.table_property where table_name = referenced_table_name)," = []\n"
  "for(var ",(select variable from test1.table_property where table_name = referenced_table_name)," of ",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),")\n{",
  "var get_",(select variable from test1.table_property where table_name = referenced_table_name)," = await this.",(select repo_service from test1.table_property where table_name = referenced_table_name),".findOne({ ",
  (
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
  ),
  ": ",(select variable from test1.table_property where table_name = referenced_table_name)," });\n",
  "if (!get_",(select variable from test1.table_property where table_name = referenced_table_name),") throw '",(select variable from test1.table_property where table_name = referenced_table_name),"_NOT_FOUND';\n",
  "list_",(select variable from test1.table_property where table_name = referenced_table_name),".push(get_",(select variable from test1.table_property where table_name = referenced_table_name),");}",
  "\n new_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),"= list_",(select variable from test1.table_property where table_name = referenced_table_name),"\n"
  , "await this.",(select repo_service from test1.table_property where table_name = @table_name),".save(new_",(select variable from test1.table_property where table_name = @table_name),");\n}"

  )
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
)
else(
  select case 
  when (
  'pivot_id' not in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
  )
  then(
	select  concat(
      "if(",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,") {\n",
	  "var list_",(select variable from test1.table_property where table_name = parent_table.table_name)," = []\n"
	  "for(var ",(select variable from test1.table_property where table_name = parent_table.table_name)," of ",(select variable from test1.table_property where table_name = @table_name),".",
      parent_table.table_name,
	  ")\n",
     "{\nvar check_",(select variable from test1.table_property where table_name = parent_table.table_name),
     " = await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),
     ".findOne({",
     (
	  SELECT Concat(COLUMN_NAME,":",(select variable from test1.table_property where table_name = parent_table.table_name))
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = parent_table.table_name
      AND COLUMN_KEY = 'PRI'
     ),"});\n"
     , "if(!check_",(select variable from test1.table_property where table_name = parent_table.table_name),") throw '",(select variable from test1.table_property where table_name = parent_table.table_name),"_NOT_FOUND'\n"
	 , "list_",(select variable from test1.table_property where table_name = parent_table.table_name),".push(check_",(select variable from test1.table_property where table_name = parent_table.table_name),");\n}"
     , "\nnew_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = parent_table.table_name)," = list_",(select variable from test1.table_property where table_name = parent_table.table_name),";\n"
	 , "await this.",(select repo_service from test1.table_property where table_name = @table_name),".save(new_",(select variable from test1.table_property where table_name = @table_name),");\n}"
    )
  )
  else(
    ''
  )
  end
)
end as command
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL

select case 
  when (
  'pivot_id' not in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
  )
  then(
    ''
  )
  else(
           select 
  concat(
  "if(",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,") {\n",
  "for(var ",(select variable from test1.table_property where table_name = parent_table.table_name)," of ",(select variable from test1.table_property where table_name = @table_name),".",
  parent_table.table_name,'s',
  ")\n",
    "{\nvar check_",
  (
    select Concat(referenced_table_name, "= await this.",(select repo_service from test1.table_property where table_name = referenced_table_name),".findOne({",
    (
      SELECT Concat(COLUMN_NAME,":",(select variable from test1.table_property where table_name = parent_table.table_name),".",COLUMN_NAME,"})\n")
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = referenced_table_name
      AND COLUMN_KEY = 'PRI'
    ),
    "if(!check_",referenced_table_name,") throw '",(select variable from test1.table_property where table_name = referenced_table_name),"_NOT_FOUND'"
    )
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
  )
  ,
  "\nvar new_",(select variable from test1.table_property where table_name = parent_table.table_name),"= await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),
  ".create({",
  (
  select a.command from (
  select group_concat(concat(
      c.column_name,":",case when c.column_name!= @key_id then (select concat(variable,".",c.column_name) from test1.table_property where table_name = parent_table.table_name) else (select concat(" new_",(select variable from test1.table_property where table_name = @table_name),".",@key_id)) end) separator ',\n') as command
  from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  group by c.table_name
  ) a
  )
  ,"})\n",
   "await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),".save(new_",(select variable from test1.table_property where table_name = parent_table.table_name),")\n}\n}"
    )
  )
  
end
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL
select concat(
"return new_",(select variable from test1.table_property where table_name = @table_name),";")
UNION ALL
select "}\n
catch (e) {
      console.log(e)
      throw e;
}\n}"
UNION ALL






















-- update Method
select Concat("async update",(select ClassNamenots from test1.table_property where table_name = @table_name),"(",(select variable from test1.table_property where table_name = @table_name),": crud",(select ClassNamenots from test1.table_property where table_name = @table_name),"Dto, user_id: string = undefined) {\n try {")
UNION ALL
(
select
Concat(
"var errors = [];\n",
"var get_",(select variable from test1.table_property where table_name = @table_name)," = ",
"await this.getInfor",(select ClassNamenots from test1.table_property where table_name = @table_name),"(",(select variable from test1.table_property where table_name = @table_name),".",@key_id,");\n"
" if (!get_",(select variable from test1.table_property where table_name = @table_name),") throw '",(select variable from test1.table_property where table_name = @table_name),"_NOT_FOUND';\n"
)
)
UNION ALL
(
select
Concat(
"if(",(select variable from test1.table_property where table_name = @table_name),".",
(
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
),"){"
"var get_",(select variable from test1.table_property where table_name = referenced_table_name)," = await this.",(select repo_service from test1.table_property where table_name = referenced_table_name),".findOne({ ",
 (
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
)
,": ",(select variable from test1.table_property where table_name = @table_name),".",(
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
)," })\n",
" if (!get_",(select variable from test1.table_property where table_name = referenced_table_name),") throw '",(select variable from test1.table_property where table_name = referenced_table_name),"_NOT_FOUND';\n"
,"get_",(select variable from test1.table_property where table_name = @table_name),".",(select table_namenots from test1.table_property where table_name = referenced_table_name),"= get_",(select variable from test1.table_property where table_name = referenced_table_name),"\n}")
FROM information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA= @database_name_entity
AND k.CONSTRAINT_SCHEMA = @database_name_entity
AND i.TABLE_NAME = @table_name
)
UNION ALL
 -- update variables
 
 
  select a.command from (
  select group_concat(concat(
      case when c.column_name!= @key_id then (select concat("get_",variable,".",c.column_name,"= (",variable,".",c.column_name,") ? ",variable,".",c.column_name,": get_",variable,".",c.column_name,";") from test1.table_property where table_name = @table_name) else (select '') end) separator '\n') as command
  from information_schema.columns c
  where 
  c.table_name = @table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  and c.COLUMN_NAME not in (
select column_name
  FROM information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA= @database_name_entity
AND k.CONSTRAINT_SCHEMA = @database_name_entity
AND i.TABLE_NAME = @table_name
  )
  group by c.column_name
  ) a
  
UNION ALL
select concat("await this.",(select repo_service from test1.table_property where table_name = @table_name) ,".save(get_",(select variable from test1.table_property where table_name = @table_name),");\n")
UNION ALL
-- Foreign Relation 
select
case when parent_table.table_name not in (
          select table_name 
          from information_schema.columns c
          where c.table_name In (
              select table_name 
              FROM information_schema.KEY_COLUMN_USAGE
              WHERE table_schema = @database_name_entity
              AND referenced_table_name = @table_name
          ) 
          and c.table_schema = @database_name_entity
          and c.column_name not in (
              SELECT k.REFERENCED_COLUMN_NAME
              FROM information_schema.TABLE_CONSTRAINTS i 
              LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
              WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
              AND i.CONSTRAINT_SCHEMA = @database_name_entity
              AND k.CONSTRAINT_SCHEMA = @database_name_entity
              AND i.TABLE_NAME = c.table_name
         )
         and c.column_name not in(
           'create_at',
           'update_at',
           'delete_at'
         )
         group by c.table_name
)
then (
  SELECT 
  Concat("if(",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),") {",
  "if(",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),".length > 0){"
  "var list_",(select variable from test1.table_property where table_name = referenced_table_name)," = []\n"
  "for(var ",(select variable from test1.table_property where table_name = referenced_table_name)," of ",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),")\n{",
  "var get_",(select variable from test1.table_property where table_name = referenced_table_name)," = await this.",(select repo_service from test1.table_property where table_name = referenced_table_name),".findOne({ ",
  (
  SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = referenced_table_name
  AND COLUMN_KEY = 'PRI'
  ),
  ": ",(select variable from test1.table_property where table_name = referenced_table_name)," });\n",
  "if (!get_",(select variable from test1.table_property where table_name = referenced_table_name),") {\nerrors.push('",(select ClassNamenots from test1.table_property where table_name = referenced_table_name),"_NOT_FOUND');\ncontinue;}\n",
  "list_",(select variable from test1.table_property where table_name = referenced_table_name),".push(get_",(select variable from test1.table_property where table_name = referenced_table_name),");\n}",
  "\nget_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),"= list_",(select variable from test1.table_property where table_name = referenced_table_name),"\n}"
  "else {",
  "\nget_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),"= []\n}",
  "\nawait this.",(select repo_service from test1.table_property where table_name = @table_name),".save(get_",(select variable from test1.table_property where table_name = @table_name),");\n}"
  )
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
)
else(
  select case 
  when (
  'pivot_id' not in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
  )
  then(
    select  
      Concat(
      "if(",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,") {",
	  "if(",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = parent_table.table_name),".length > 0){",
	  "var list_",(select variable from test1.table_property where table_name = parent_table.table_name)," = []\n",
	  "for(var ",(select variable from test1.table_property where table_name = parent_table.table_name)," of ",(select variable from test1.table_property where table_name = @table_name),".",
      parent_table.table_name,
	  ")\n",
     "{\nvar check_",(select variable from test1.table_property where table_name = parent_table.table_name),
     " = await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),
     ".findOne({",
     (
	  SELECT Concat(COLUMN_NAME,":",(select variable from test1.table_property where table_name = parent_table.table_name),".",COLUMN_NAME)
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = parent_table.table_name
      AND COLUMN_KEY = 'PRI'
     ),"});\n"
     , "if(!check_",(select variable from test1.table_property where table_name = parent_table.table_name),") {\nerrors.push('",(select variable from test1.table_property where table_name = parent_table.table_name),"_NOT_FOUND');\ncontinue;}\n"
	 , "list_",(select variable from test1.table_property where table_name = parent_table.table_name),".push(check_",(select variable from test1.table_property where table_name = parent_table.table_name),");\n}"
     , "\nget_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = parent_table.table_name)," = list_",(select variable from test1.table_property where table_name = parent_table.table_name),";\n}"
	 , "else {"
     , "\nget_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = referenced_table_name),"= []\n}\n"
	 , "await this.",(select repo_service from test1.table_property where table_name = @table_name),".save(get_",(select variable from test1.table_property where table_name = @table_name),");\n}"

    )
  )
  else(
  ''
  )
  end
)
end as command
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL
  select case 
  when (
  'pivot_id' not in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
  )
  then(
    ''
  )
  else(
         select 
  concat(
  "if(",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,") {",
  "if(",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,".length>0) {",
  "for(var old_",(select variable from test1.table_property where table_name = parent_table.table_name)," of get_",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,'s){',
  "var list_id = ",(select variable from test1.table_property where table_name = @table_name),".",parent_table.table_name,"s.map(item=>{\n return item.",
  (
       select column_name
        from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME like '%_id%'
  and c.COLUMN_NAME != @key_id
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  ),"});\n",
  "if (!list_id.includes(old_",(select variable from test1.table_property where table_name = parent_table.table_name),".",
   (
       select column_name
        from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME like '%_id%'
  and c.COLUMN_NAME != @key_id
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  )
  ,")) {\n",
  "var check_old_",(select variable from test1.table_property where table_name = parent_table.table_name)," = await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),".findOne({ ",
  (
       select column_name
        from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME like '%_id%'
  and c.COLUMN_NAME != @key_id
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  ),": old_",(select variable from test1.table_property where table_name = parent_table.table_name),".",
  (
       select column_name
        from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME like '%_id%'
  and c.COLUMN_NAME != @key_id
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  ),", ",@key_id,": ",(select variable from test1.table_property where table_name = @table_name),".",@key_id," })"
  ,"\nawait this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),".remove(check_old_",(select variable from test1.table_property where table_name = parent_table.table_name),")\n}\n}\n",
  "for(var ",(select variable from test1.table_property where table_name = parent_table.table_name)," of ",(select variable from test1.table_property where table_name = @table_name),".",
  parent_table.table_name,'s',
  ")\n",
    "{\nvar check_",
  (
    select Concat(referenced_table_name, "= await this.",(select repo_service from test1.table_property where table_name = referenced_table_name),".findOne({",
    (
      SELECT Concat(COLUMN_NAME,":",(select variable from test1.table_property where table_name = parent_table.table_name),".",COLUMN_NAME,"})\n")
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = referenced_table_name
      AND COLUMN_KEY = 'PRI'
    ),
    "if(!check_",referenced_table_name,") {\nerrors.push('",(select variable from test1.table_property where table_name = referenced_table_name),"_NOT_FOUND');\ncontinue;}\n",
    "var check_",(select variable from test1.table_property where table_name = parent_table.table_name),"= await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),".findOne({ ",
	(
      SELECT COLUMN_NAME
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = referenced_table_name
      AND COLUMN_KEY = 'PRI'
    )
    ,": check_",referenced_table_name,".",
	(
      SELECT COLUMN_NAME
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = referenced_table_name
      AND COLUMN_KEY = 'PRI'
    )
    ,", ",@key_id,": ",(select variable from test1.table_property where table_name = @table_name),".",@key_id," })\n",
    "if(check_",(select variable from test1.table_property where table_name = parent_table.table_name),"){",(
         select a.command from (
          select group_concat(concat(
      case when c.column_name!= @key_id and c.column_name not in (
      SELECT COLUMN_NAME
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_SCHEMA =  @database_name_entity 
      AND TABLE_NAME = referenced_table_name
      AND COLUMN_KEY = 'PRI'
      ) then (select concat("check_",(select variable from test1.table_property where table_name = parent_table.table_name),".",c.column_name,"=",variable,".",c.column_name) from test1.table_property where table_name = parent_table.table_name) else (select '') end) separator '\n') as command
      
  from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  group by c.table_name
  ) a
    )
    )
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
  ),
  "\nawait this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),".save(check_",(select variable from test1.table_property where table_name = parent_table.table_name),");\ncontinue;\n}",
  "\nvar new_",(select variable from test1.table_property where table_name = parent_table.table_name),"= await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),
  ".create({",
  (
  select a.command from (
  select group_concat(concat(
      c.column_name,":",case when c.column_name!= @key_id then (select concat(variable,".",c.column_name) from test1.table_property where table_name = parent_table.table_name) else (select concat(" get_",(select variable from test1.table_property where table_name = @table_name),".",@key_id)) end) separator ',\n') as command
  from information_schema.columns c
  where 
  c.table_name = parent_table.table_name
  and c.table_schema = @database_name_entity
  and c.COLUMN_NAME not in ('pivot_id','created_at','updated_at','deleted_at')  
  group by c.table_name
  ) a
  )
  ,"})\n",
  "await this.",(select repo_service from test1.table_property where table_name = parent_table.table_name),".save(new_",(select variable from test1.table_property where table_name = parent_table.table_name),")\n}\n}\n"
  "else{\n",
  "get_",(select variable from test1.table_property where table_name = @table_name),".",(select table_name from test1.table_property where table_name = parent_table.table_name),"s= [];\n",
  "\nawait this.",(select repo_service from test1.table_property where table_name = @table_name),".save(get_",(select variable from test1.table_property where table_name = @table_name),");",
  "}\n}"
  )
  )
  end
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL
select concat("return get_",(select variable from test1.table_property where table_name = @table_name))
UNION ALL
select concat("}
catch (e) {
      console.log(e)
      throw e;
}\n}")


















UNION ALL
-- select Method
select concat("async get",(select ClassNamenots from test1.table_property where table_name = @table_name),"List(crd: ",(select RequestDto from test1.table_property where table_name = @table_name ),") {",
"console.log(crd)\n",
"var list_",(select table_name from test1.table_property where table_name = @table_name)," = await this.",(select repo_service from test1.table_property where table_name = @table_name),'.createQueryBuilder("',
(
select table_name from test1.table_property where table_name = @table_name),'")')
UNION ALL
(
  SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_namenots from test1.table_property where table_name = referenced_table_name),'", "',referenced_table_name,'")')
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = @table_name
)
UNION ALL
select
  case when parent_table.table_name not in (
          select table_name 
          from information_schema.columns c
          where c.table_name In (
              select table_name 
              FROM information_schema.KEY_COLUMN_USAGE
              WHERE table_schema = @database_name_entity
              AND referenced_table_name = @table_name
          ) 
          and c.table_schema = @database_name_entity
          and c.column_name not in (
              SELECT k.REFERENCED_COLUMN_NAME
              FROM information_schema.TABLE_CONSTRAINTS i 
              LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
              WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
              AND i.CONSTRAINT_SCHEMA = @database_name_entity
              AND k.CONSTRAINT_SCHEMA = @database_name_entity
              AND i.TABLE_NAME = c.table_name
         )
         and c.column_name not in(
           'create_at',
           'update_at',
           'delete_at'
         )
         group by c.table_name
)
then (
  SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_name from test1.table_property where table_name = referenced_table_name),'","',(select table_name from test1.table_property where table_name = referenced_table_name),'")')
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
)
else(
  select case 
  when (
  'pivot_id' in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
  )
  then(
    SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_name from test1.table_property where table_name = parent_table.table_name),'s","',(select table_name from test1.table_property where table_name = parent_table.table_name),'")'
    ,'.leftJoinAndSelect("',(select table_namenots from test1.table_property where table_name = parent_table.table_name),'.',(select table_namenots from test1.table_property where table_name = referenced_table_name),'","',referenced_table_name,'")')
    as command
        
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
  )
  else(
   SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_name from test1.table_property where table_name = parent_table.table_name),'","',(select table_name from test1.table_property where table_name = parent_table.table_name),'")')
  )
  end
)
end as command
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL
select concat(".orderBy('",(@table_name),".created_at', 'DESC')")
UNION ALL
select concat(".where('",(@table_name),".deleted_at is null');")
UNION ALL
select concat("
    var condition_count = await list_",@table_name,".getCount();
    var skip_take_list = await list_",@table_name,".skip((crd.page - 1) * crd.perPage).take(crd.perPage).getMany();
	return {
      list_",@table_name,": skip_take_list,
      condition_count: condition_count
    }\n}
")
UNION ALL
-- delete method
select concat("async remove",(select ClassNamenots from test1.table_property where table_name = @table_name),"(id",(
      SELECT case when data_type = 'varchar' then ':string' else ':number' end
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = @table_name
  AND COLUMN_KEY = 'PRI'
),") {")
UNION ALL
select concat("try {
      return await this.",(select repo_service from test1.table_property where table_name = @table_name),".softRemove({ ",(
  SELECT column_name
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = @table_name
  AND COLUMN_KEY = 'PRI'
      ),": id })
    }
    catch (e) {
      console.log(e)
      throw e;
    }\n}
")
UNION ALL





-- get infor Method
select concat("async getInfor",(select ClassNamenots from test1.table_property where table_name = @table_name),"(id ",
(
      SELECT case when data_type = 'varchar' then ':string' else ':number' end
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = @table_name
  AND COLUMN_KEY = 'PRI'
),") {",
"return await this.",(select repo_service from test1.table_property where table_name = @table_name),'.createQueryBuilder("',
(select table_name from test1.table_property where table_name = @table_name),'")\n')
UNION ALL
(
  SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_namenots from test1.table_property where table_name = referenced_table_name),'", "',referenced_table_name,'")')
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = @table_name
)
UNION ALL
select
  case when parent_table.table_name not in (
          select table_name 
          from information_schema.columns c
          where c.table_name In (
              select table_name 
              FROM information_schema.KEY_COLUMN_USAGE
              WHERE table_schema = @database_name_entity
              AND referenced_table_name = @table_name
          ) 
          and c.table_schema = @database_name_entity
          and c.column_name not in (
              SELECT k.REFERENCED_COLUMN_NAME
              FROM information_schema.TABLE_CONSTRAINTS i 
              LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
              WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
              AND i.CONSTRAINT_SCHEMA = @database_name_entity
              AND k.CONSTRAINT_SCHEMA = @database_name_entity
              AND i.TABLE_NAME = c.table_name
         )
         and c.column_name not in(
           'create_at',
           'update_at',
           'delete_at'
         )
         group by c.table_name
)
then (
  SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_name from test1.table_property where table_name = referenced_table_name),'","',(select table_name from test1.table_property where table_name = referenced_table_name),'")')
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
)
else(
  select case 
  when (
  'pivot_id' in (SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA =  @database_name_entity 
  AND TABLE_NAME = parent_table.table_name
  AND COLUMN_KEY = 'PRI')
  )
  then(
    SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_name from test1.table_property where table_name = parent_table.table_name),'s","',(select table_name from test1.table_property where table_name = parent_table.table_name),'")'
    ,'.leftJoinAndSelect("',(select table_namenots from test1.table_property where table_name = parent_table.table_name),'.',(select table_namenots from test1.table_property where table_name = referenced_table_name),'","',referenced_table_name,'")')
    as command
        
  FROM information_schema.TABLE_CONSTRAINTS i 
  LEFT JOIN information_schema.KEY_COLUMN_USAGE k ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
  WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
  AND i.CONSTRAINT_SCHEMA = @database_name_entity
  AND k.CONSTRAINT_SCHEMA = @database_name_entity
  AND i.TABLE_NAME = parent_table.table_name
  And k.REFERENCED_TABLE_NAME != @table_name
  )
  else(
   SELECT concat('.leftJoinAndSelect("',@table_name,'.',(select table_namenots from test1.table_property where table_name = parent_table.table_name),'","',(select table_name from test1.table_property where table_name = parent_table.table_name),'")')
  )
  end
)
end as command
FROM information_schema.KEY_COLUMN_USAGE parent_table
WHERE table_schema = @database_name_entity
AND referenced_table_name = @table_name
UNION ALL
select concat(
 '.where("',@table_name,'.',(
 @key_id
 ),' = :id",{id:id}).getOne();'
)
UNION ALL
select "}\n}"





