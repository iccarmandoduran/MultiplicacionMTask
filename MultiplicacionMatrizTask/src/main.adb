with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Main is
   fin:Integer:=350;
   MatrizA : array (1..fin,1..fin) of Integer;
   MatrizB : array (1..fin,1..fin) of Integer;
   MatrizC : array (1..fin,1..fin) of Integer;
   r,i,j,k: Integer:=0;


   task Llenado;

   task type Multiplicacion is
      entry iniciar (inicio:Integer);
   end Multiplicacion;

   task MatrizR is
      entry posicion (c,f,val:Integer);
   end MatrizR;


   task body Multiplicacion is
      sumaR:Integer:=0;
   begin
      accept iniciar (inicio: Integer) do
         k:=inicio;
          for i in 1..fin loop
            r:=0;
            for j in 1..fin loop
                r:= MatrizA(k,j)+MatrizB(j,i)+r;
               end loop;
               MatrizR.posicion(k,i,r);
         end loop;
      end iniciar;
   end Multiplicacion;




   task body MatrizR is
      resultado : Integer:=0;
   begin
      for i in 1..fin loop
         for j in 1..fin loop
          accept posicion (c,f, val:Integer) do
           MatrizC(c,f):=val;
          end posicion;
         end loop;
      end loop;

      for i in 1..fin loop
       for j in 1..fin loop
          Put(MatrizC(i,j));
       end loop;
       Put_Line("");
      end loop;
   end MatrizR;

   SubMatrices : array (1..fin) of Multiplicacion;

   task body Llenado is
    begin
     for i in 1..fin loop
      for j in 1..fin loop
         MatrizA (i,j):= 2;
         MatrizB (i,j):= 2;
         end loop;
      end loop;

      for i in 1..fin loop
         SubMatrices(i).iniciar(i);
      end loop;
   end Llenado;



begin
   Put_Line("Multiplicaciion Matrices");
end Main;
