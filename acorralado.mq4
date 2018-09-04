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
Acorralado tob("tob",1600);
int botLastTicket, tobLastTicket;
string out;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  Comment(Point);
  Sleep(750);
  
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
   bot.loadTicketArray();
   tob.loadTicketArray();
   
   out = "--------\n";
   botLastTicket = bot.getTicketLastOpenOrder();
   out = "bot Last Ticket: "+IntegerToString(botLastTicket)+"\n";
   
   tobLastTicket = tob.getTicketLastOpenOrder();
   out += "tob Last Ticket: "+IntegerToString(tobLastTicket)+"\n";
   Comment(out);
   Sleep(1000);
   
   if(botLastTicket>-1)
      bot.setPendingOrder(botLastTicket);
      
   if(tobLastTicket>-1)
      tob.setPendingOrder(tobLastTicket);
   
   Sleep(5000);
}      
      
    