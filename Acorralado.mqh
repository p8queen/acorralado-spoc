//+------------------------------------------------------------------+
//|                                              Acorralado-spoc.mqh |
//|                                 SPOC Set Pending Order and Close |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict

input double panicProfit = -1;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Acorralado
  {
private:
   string name, cad;
   double deltaTips, lots, deltaStTp, deltaOrders;
   double priceBuys, priceSells;
   double balance;
   bool botIsOpen;
   int firstOrderOP;
   int p, magicNumber;
   int lsNumOrder[10];
   
   
public:
                     Acorralado(string robotName, int robotMagicNumber);
                    ~Acorralado();
   int               getTicketLastOpenOrder();
   void              loadTicketArray(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Acorralado::Acorralado(string robotName, int robotMagicNumber)
  {
   name = robotName+"-"+Symbol();
   magicNumber = robotMagicNumber;
   ArrayInitialize(lsNumOrder, -1);
   cad = "";
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Acorralado::~Acorralado()
  {
  }
//+------------------------------------------------------------------+

void Acorralado::loadTicketArray(void){
   int itotal, i;
   p=0;
   itotal=OrdersTotal();
   cad = "Orders: "+IntegerToString(itotal)+"\n";
   
   
   for(i=0;i<itotal;i++){
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
       // check for opened position, symbol & MagicNumber
       if (OrderSymbol()== Symbol()){
         lsNumOrder[p] = OrderTicket();
         Comment(lsNumOrder[p]);
         Sleep(500);
         p++;
         }
      }
      
      Comment("lega");
   Sleep(1000);
   //check array
   p=0;
   cad += "TicketArray: ";
   
   while(lsNumOrder[p]>-1){
      cad += IntegerToString(lsNumOrder[p])+", ";   
      p++;
      }
   cad += "\n";
   Comment(cad);


   }

//int Acorralado::getTicketLastOpenOrder(){
//   
//   int i, itotal, retval;
//   
//
//   retval = 0;
//   itotal=OrdersTotal();
//   cad = "Orders: "+IntegerToString(itotal);
//   
//   
//   for(i=0;i<itotal;i++) // for loop
//     {
//      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
//       // check for opened position, symbol & MagicNumber
//       if (OrderSymbol()== Symbol()){
//         cad += ", "+IntegerToString(OrderTicket())+", ";
//         cad += "lots: "+DoubleToString(OrderLots())+", ";
//         cad += ",Order Type: "+IntegerToString(OrderType())+", ";
//         }
//   }
//   Comment(cad);
//   return retval; 
//   }