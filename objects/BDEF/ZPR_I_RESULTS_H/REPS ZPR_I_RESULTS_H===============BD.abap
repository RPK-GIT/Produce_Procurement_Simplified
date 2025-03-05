unmanaged implementation in class zbp_pr_i_results_h unique;
strict ( 1 );

define behavior for ZPR_I_RESULTS_H //alias <alias_name>
lock master
authorization master ( instance )
{
  create;
  update;
  delete;
  association _Item { create; }
}

define behavior for ZPR_I_RESULTS_ITEM //alias <alias_name>
lock dependent by _Header
authorization dependent by _Header
{
  update;
  delete;
  field ( readonly ) Wtktno;
  association _Header;
}