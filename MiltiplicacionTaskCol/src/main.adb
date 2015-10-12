with Ada.Text_IO,Ada.Integer_Text_IO;
use Ada.Text_IO,Ada.Integer_Text_IO;
procedure Main is

   tam: Integer :=50;
   valoresA:Integer:=1;
   ValoresB:Integer:=1;
   matA:array(1..tam,1..tam)of Integer;
   matB:array(1..tam,1..tam)of Integer;
   matC:array(1..tam,1..tam)of Integer;

   task llenarA;
   task llenarB;


   task imprimir is
      entry continuar;
   end imprimir;


   task type filas is
      entry rango(inicio, fin:Integer);
   end filas;

   task body llenarA is
   begin
      for i in 1..tam loop
         for j in 1..tam loop
            matA(i,j):=valoresA;
         end loop;
      end loop;
   end llenarA;

   task body llenarB is
   begin
      for i in 1..tam loop
         for j in 1..tam loop
            matB(i,j):=ValoresB;
         end loop;
      end loop;
   end llenarB;



   task body filas is

   begin
      accept rango (inicio : in Integer; fin : in Integer) do
          for i in inicio..fin loop
            for j in 1..tam loop
               matC(j,i):=0;
               for k in 1 ..tam loop
                  matC(j,i):=matC(j,i)+(matA(j,k)*matB(k,i));
               end loop;
            end loop;
         end loop;

      end rango;
   end filas;

   task body imprimir is
   begin
      accept continuar  do
         for i in 1..tam loop
         for j in 1..tam loop
            Put(matC(i,j));
            end loop;
            Put_Line("");
      end loop;
      end continuar;
   end imprimir;

   tareas : array(1..10) of filas;

   delt:Integer;
   inicioRango: Integer:=1;
begin
   delt:=tam/10;
   for iMain in 1..10 loop
      tareas(iMain).rango(inicioRango,inicioRango+delt-1);
      inicioRango := inicioRango + delt;
   end loop;
  -- delay 30.0;
   imprimir.continuar;
end Main;
