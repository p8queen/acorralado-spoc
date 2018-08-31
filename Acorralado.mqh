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
   int lsNumOrder[20];
   
   
public:
                     Acorralado(string robotName, int robotMagicNumber);
                    ~Acorralado();
   int               getTicketLastOpenOrder();
   void              loadTicketArray(void);
   void              setPendingOrder(int ticket);
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
   deltaTips = 500*Point;
   deltaStTp = 1*Point;
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
       if (OrderSymbol()== Symbol() && OrderMagicNumber()==magicNumber){
         lsNumOrder[p] = OrderTicket();
         Comment(lsNumOrder[p]);
         Sleep(500);
         p++;
         }
      }
      
   Comment("Array loaded");
   Sleep(500);
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

int Acorralado::getTicketLastOpenOrder(){
   //get Last Ticket if not exist Pending Orders
   // otherwise return -1
   int ticket;
   double maxLots;
   maxLots = 0;
   ticket = -1; 
   cad = "";
   p=0;
   while(lsNumOrder[p]>-1){
   
      OrderSelect(lsNumOrder[p], SELECT_BY_TICKET);
       // check for opened position, symbol & MagicNumber
       
         cad += ", "+IntegerToString(OrderTicket())+", ";
         cad += "lots: "+DoubleToString(OrderLots())+", ";
         cad += TimeToStr(OrderOpenTime())+", ";
         cad += ",Order Type: "+IntegerToString(OrderType())+"\n ";
         if(OrderLots()>maxLots){
            ticket = lsNumOrder[p];
            maxLots = OrderLots();
            cad += "last ticket: "+IntegerToString(lsNumOrder[p])+"\n";
            }
         if(OrderType()>1){
            ticket = -1;
            cad += "last ticket: "+IntegerToString(lsNumOrder[p])+"\n";
            return ticket;
            
            } 
       
   p++;
   }
  // Comment(cad);
  // Sleep(1000);
   return ticket; 
   }
 
 void Acorralado::setPendingOrder(int ticket){
   double price, st, tp;
      
   
   OrderSelect(ticket,SELECT_BY_TICKET);
   if(OrderLots()==0.01)
      lots = 0.03;
   else
      lots = OrderLots()*2;
   
   if(OrderType()==OP_BUY){
      //set sellStop
      price = OrderOpenPrice()-deltaTips;
      st = price+2*deltaTips;
      tp = price-deltaTips + deltaStTp;
      OrderSend(Symbol(),OP_SELLSTOP,lots,price,10,st,tp,name,magicNumber);
      }
      
      if(OrderType()==OP_SELL){
      //set buyStop
      price = OrderOpenPrice()+deltaTips;
      st = price-2*deltaTips;
      tp = price+deltaTips - deltaStTp;
      OrderSend(Symbol(),OP_BUYSTOP,lots,price,10,st,tp,name,magicNumber);
      }
   
   }