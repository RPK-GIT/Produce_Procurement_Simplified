projection;
strict ( 1 );
use draft;
use side effects;
define behavior for ZPR_C_HEADER //alias <alias_name>
{
  use create;
  use update;
  use delete;

  use action Haulerpo;
  use action copy;

  use action Activate;
  use action Edit;
  use action Discard;
  use action Resume;
  use action Prepare;

  use association _Item { create; with draft; }
}

define behavior for ZPR_C_ITEM //alias <alias_name>
{
  use update;
  use delete;

  use association _Header { with draft; }
  use action Processidata;
//  use action POUpdate;
  use action Processiteminv;
  use action Stock;
  use function GetDefaultsForStock;
}