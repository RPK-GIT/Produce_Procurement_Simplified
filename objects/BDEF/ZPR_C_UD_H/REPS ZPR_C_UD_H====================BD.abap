projection;
strict ( 1 );

define behavior for ZPR_C_UD_H //alias <alias_name>
{
  use create;
  use update;
  use delete;

  use association _Item { create; }
}

define behavior for ZPR_C_UD_ITEM //alias <alias_name>
{
  use update;
  use delete;

  use association _Header;
}