with Ada.Text_IO ,Ada.Integer_Text_IO;
use Ada.Text_IO , Ada.Integer_Text_IO;
procedure Main is

   MatrizA : array (1..5,1..5) of Integer;
   MatrizB : array (1..5,1..5) of Integer;
   MatrizC : array (1..5,1..5) of Integer;
   r,i,j,k: Integer  := 0;
   task Llenado;

   task type Multiplicacion is
      entry iniciar (inicio,fin:Integer);
   end Multiplicacion;

   task MatrizR is
      entry posicion (c,f,val:Integer);
   end MatrizR;


   task body Multiplicacion is
   begin
      accept iniciar (inicio: Integer; fin: Integer) do
         for k in inicio..fin loop
          for i in 1..fin loop
            r:=0;
            for j in 1..fin loop
                r:= MatrizA(k,j)+MatrizB(j,i)+r;
               end loop;
               MatrizR.posicion(k,i,r);
          end loop;
         end loop;
      end iniciar;
   end Multiplicacion;

   SubMatrices : array (0..4) of Multiplicacion;

   task body MatrizR is
   begin
      for i in 0..4 loop
       accept posicion (c,f, val:Integer) do
         MatrizC(c,f):=val;
       end posicion;
      end loop;

      Put_Line("Multiplicación:");
      for i in 1..4 loop
       for j in 1..4 loop
         Put(MatrizC(i,j));
       end loop;
       Put_Line("");
      end loop;
   end MatrizR;



   task body Llenado is
    begin
     for i in 1..4 loop
      for j in 1..4 loop
         MatrizA (i,j):= 2;
         MatrizB (i,j):= 2;
         end loop;
      end loop;
   end Llenado;



begin
   Put_Line("Multiplicaciòn:");
   for i in 0..4 loop
         SubMatrices(i).iniciar(i,4);
   end loop;
   null;
end Main;
