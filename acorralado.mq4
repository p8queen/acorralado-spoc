//+------------------------------------------------------------------+
//|                                              acorralado-spoc.mq4 |
//|                                 SPOC Set Pending Order and Close |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+



//+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict
#include "acorralado.mqh"

//          (name, magicNumber)
Acorralado bot("bot",1500);

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  Comment(Point);
 
  bot.loadTicketArray();
     

  return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
   bot.getTicketLastOpenOrder();
      
}      
      
    