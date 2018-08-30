//+------------------------------------------------------------------+
//|                                                   Acorralado.mqh |
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
   string name;
   double deltaTips, lots, deltaStTp, deltaOrders;
   double priceBuys, priceSells;
   double balance;
   bool botIsOpen;
   int firstOrderOP;
   int magicNumber;
   
public:
                     Acorralado(string robotName, int robotMagicNumber);
                    ~Acorralado();
   int               getTicketLastOpenOrder();

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Acorralado::Acorralado(string robotName, int robotMagicNumber)
  {
   name = robotName+"-"+Symbol();
   magicNumber = robotMagicNumber;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Acorralado::~Acorralado()
  {
  }
//+------------------------------------------------------------------+

int Acorralado::getTicketLastOpenOrder(){
   int i, itotal, retval;
   string cad;

   retval = 0;
   itotal=OrdersTotal();
   cad = "Orders: "+IntegerToString(itotal);
   
   
   for(i=0;i<itotal;i++) // for loop
     {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
       // check for opened position, symbol & MagicNumber
       if (OrderSymbol()== Symbol()){
         cad += ", "+IntegerToString(OrderTicket())+", ";
         cad += "lots: "+DoubleToString(OrderLots())+", ";
         cad += ",Order Type: "+IntegerToString(OrderType())+", ";
         }
   }
   Comment(cad);
   return retval; 
   }