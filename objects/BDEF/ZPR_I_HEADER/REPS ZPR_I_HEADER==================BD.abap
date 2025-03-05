unmanaged implementation in class zcl_pr_i_header unique;
strict ( 1 );
with draft;
define behavior for ZPR_I_HEADER alias Header
draft table zpr_tb_wt_dr
etag master LastChangedAt
lock master total etag LastChangedAt
authorization master ( global )
early numbering
{
  field ( mandatory : create, readonly : update ) Werks;
  //  field (mandatory) Hauler, TrkLoadwg, TrkUnloadwg, MatDistance, MatWeight, DisTravelled,
  field ( mandatory ) Lifnr;
  field ( readonly ) wtktno, Status, LiveWg,
  PoPrice, InvoiceSpl1, InvoiceSpl2, InvoiceSpl3, HaulerPO;

  create;
  update;
  delete;

  association _Item { create; with draft; }

  action ( features : instance ) Haulerpo result [1] $self;

  draft action Activate;
  draft action Edit;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare;

  side effects
  {
    field MatDistance affects field Distravelleduom;
    field TRKLOADWG affects field LiveWg;
    field TRKUNLOADWG affects field LiveWg;
  }

  determination CalcNetWeight on modify { field TrkLoadwg, TrkUnloadwg; create; }
  determination GetUom on modify { field MatDistance; create; }
  determination DefaultData on modify { create; }

  mapping for zpr_tb_wt_hd
    {
      Werks   = werks;
      Wtktno  = wtktno;
    }

  factory action copy [1];

}

define behavior for ZPR_I_ITEM alias Item
draft table zpr_tb_it_dr
lock dependent by _Header
authorization dependent by _Header
early numbering
{
  create;
  update;
  delete;
  field ( mandatory ) Supplier, Matnr, Weight, Lgort;
  field ( readonly ) Werks, Wtktno, Wtktitm, Prueflos, Ebeln, Mblnr, Invoice, status, Charg,
  PoPrice, SplitInvoice1, SplitInvoice2, SplitInvoice3, Unit, Aedat, Aeeit, Aenam, Erdat, Ereit, Ernam;
  association _Header { with draft; }

  action ( features : instance ) Processidata result [1] $self;
//  action ( features : instance ) POUpdate result [1] $self;
  action ( features : instance ) Processiteminv result [1] $self;
  action ( features : instance ) Stock parameter ZPR_TR_STOCK result [1] $self {default function GetDefaultsForStock ; }

  determination GetUom on modify { field Matnr; create; }
  determination DefaultItemData on modify { create; }
  side effects
  {
    field Matnr affects field Unit;
    field PoPrice affects entity _Pocond;
//    action POUpdate affects entity _Pocond;
  }
}