#Primero declaro 3 funciones para poder ver mejor el codigo y especialmente poder colapsarlos y que no me ocupen toda la pantalla.

#Esta función es la que utilizo cuando alguien quiere crear una contraseña alfabetica y alfanumerica.
function set-alfa{

#Esto va a modo de titulo.
Write-host "`nUsted a seleccionado la opción 'Alfabetica / Alfanumerica'`n" -BackgroundColor Yellow -ForegroundColor black

#Un pequeño menú para elegir si queres alfabetica ó alfanumerica.
Write-host "`n¿Quieres que sea alfabetica ó alfanumerica?`n"

Write-host "[A] Alfabetica`n"
    
Write-host "[N] Alfanumerica`n"

$sinoAlfa = Read-Host

#Hago una comprobación para saber si lo que puso el usuario es una opción válida. 
While("A","N" -notcontains $sinoalfa){
    Write-host "No ha ingresado un valor valido" -ForegroundColor Yellow
    $sinoalfa = Read-Host "Vuelva a intentarlo" 
}

<#Aca puse un Try and Catch para probar un poco de lo que ví en el curso de PowerShell y donde se que puedo romperlo.
Como se muestra el error proviene si alguien tira un string para esta variable que he indicado como "integer"#>
try{
    [int]$long = Read-Host ("¿Qué longitud quiere que tenga su clave?")
}
catch{
    Write-Host "`n*En este campo solo se permite el uso de enteros.*`n*Por favor vuelva a ejecutar el programa*`n" -ForegroundColor Red
    Write-Host "¡Hasta luego!" -ForegroundColor Yellow
    exit
}

#En este while hago un loop hasta que se ingrese un número mayor a cero y te pregunta hasta que le pongas un valor valido.
while($long -le 0){
    try{
        [int]$long = Read-Host ("¿Qué longitud quiere que tenga su clave?")
    }
    catch{
        Write-Host "`n*En este campo solo se permite el uso de enteros.*`n*Por favor vuelva a ejecutar el programa*`n" -ForegroundColor Red
        Write-Host "¡Hasta luego!" -ForegroundColor Yellow
        exit
    }    
}

#Este es un menú simple para varios parametros que se van a tomar en cuenta en la generación de la contraseña.
Write-host "`n¿Quiere que contenga mayúsculas, minuscúlas o ambas?"

Write-host "[A] Mayúsculas"

Write-host "[B] Minúsculas"

Write-host "[C] Ambas"

$bloqmayus = Read-Host

#Como en el anterior realiza una comprobación de lo que el usuario escriba. 
While("A","B","C" -notcontains $bloqmayus){
    Write-host "No ha ingresado un valor valido" -ForegroundColor Yellow
    $bloqmayus = Read-Host "Vuelva a intentarlo" 
}

#Otro parametro más, este es por los caracteres.
Write-host "`n¿Quieres que contenga caracteres especiales? [Ej. $, !, %, &, etc.]`n"

Write-host "[S] Si`n"
    
Write-host "[N] No`n"

$siNoEsp = Read-Host

#Como en el anterior realiza una comprobación de lo que el usuario escriba. 
While("S","N" -notcontains $sinoesp){
    Write-host "No ha ingresado un valor valido" -ForegroundColor Yellow
    $sinoesp = Read-Host "Vuelva a intentarlo" 
}

#Aca te pregunta si deseas guardar la contraseña a generar en un log. Algo que estuve investigando ya que Yerickson me pidio una tarea en PowerShell con Logs.
Write-Host "`n¿Desea guardar esta información en un archivo de texto?`n[En caso de guardar se le pedirá una descripción para que recuede para que es la contraseña]`n"

Write-host "[S] Si`n"
    
Write-host "[N] No`n"

$siNoLog = Read-host

#Como en el anterior realiza una comprobación de lo que el usuario escriba. 
While("S","N" -notcontains $sinolog){
    Write-host "No ha ingresado un valor valido" -ForegroundColor Yellow
    $sinolog = Read-Host "Vuelva a intentarlo" 
}

#Aca hace una pequeña comprobación para que no lo hagas por error.
If($siNoLog -eq "S"){
    
    #Aca genera dos números al azar y te los imprime en pantalla como una suma para que lo resuelvas.
    $comp = (1..9)
    $int1 = $RandomComp = Get-Random -InputObject $comp 
    $int2 = $RandomComp = Get-Random -InputObject $comp 
    Write-host "`nConfirmarción:`n"
    $resultado = Read-Host ("$int1 + $int2")

    #Aca comprueba que el resultado que diste sea correcto y sigue con el proceso depende del mismo. 
    if(($int1+$int2) -eq $resultado){
        Write-host "`nBien continuamos`n"
        #Te pide que ingreses una ruta.
        $ruta = Read-Host ("Ingrese la ruta en donde quiere que se guarde el archivo de texto.`n[Las carpeta/s deben ser creadas con antelación]")
        #Comprueba si el path es correcto.
        $existe = Test-Path $ruta 
        #Te va a seguir pidiendo hasta que escribas una ruta existente.
        while($existe -eq $false){
            Write-host "La ruta ingresada contiene errores.`n"
            $ruta = Read-Host ("Ingrese la ruta en donde quiere que se guarde el archivo de texto.`n[Las carpeta/s deben ser creadas con antelación]")
            $existe = Test-Path $ruta 
        }
        #Te pide una pequeña descripción para saber cual contraseña vas a generar.
        $desc = Read-Host ("Ingrese una descripción.`n[No se admiten saltos de línea]")
        #Comprueba que no hayas dejado vacío la desrcripción.
        while($desc -eq ""){
           $desc = Read-Host ("Ingrese una descripción.`n[No se admiten saltos de línea]") 
        }
    }else{
        Write-host "¡Hay que volver a la escuela!"
        $siNoLog = "N"
    }


}elseif($sinoLog -eq "N"){

}

#Este es un pequeño encabezado de la contraseña 
Write-host "`nGenerando contraseña`n"

Write-host "--------------------------------------------------`n"

#Esta variable lo uso para iterar en cada uno de los loops que explicaré más adelante.
$i=1 

#Este switch depende de cada una de las opciones o preferencias referidas a lo largo del programa.
Switch($bloqMayus){

A{
    If($yesnoEsp -eq "N"){
    
        #--- EMPIEZA EL IF DEL YESNOALFA 1 ---
        if($yesnoalfa -eq "N"){
        
            #--- EMPIEZA EL DO (ALFABETICO-MAYUSCULAS-SINESPECIALES) ---        
            Do{
            #Aca se asignan los valores en los cuales el "Get-Random" va a usar.
            $asciiMayus = 65..90
            #Aca realiza el random mencionado anteriormente.
            $Random = Get-Random -InputObject $asciiMayus
            #Aca lo suma a un array los numeros convertidos a char que PowerShell los entiende como ASCII.
            $pass += ([char]$Random)
            $i++
        #El while sigue hasta la cantidad de caracteres que el usuario eligió al principio.
        }While($i -le $long)            
            #--- TERMINA EL DO --- 
            
        }else{ #--- ELSE DEL YESNOALFA 1 ---

            #--- EMPIEZA EL DO (ALFANUMERICO-MAYUSCULAS-SINESPECIALES) ---  
            Do{
                #En este caso selecciono los números del 1 al 9 y del 65 al 90 para hacer los ASCII.
                $asciiMayus = (1..9) + (65..90)
                $Random = Get-Random -InputObject $asciiMayus
                #En este if los sumo dependiendo que son para convertir cada valor en su apropiado formato.
                if((0..9) -contains $random){
                    $pass += ([string]$Random)
                }else{
                    $pass += ([char]$Random)
                }
                $i++
            }While($i -le $long)     
            #--- TERMINA EL DO ---                           
                
        } #--- CIERRE DEL YESNOALFA 1 ---

    }Else{ #--- ELSE DEL YESNOESP

        #--- EMPIEZA EL IF DEL YESNOALFA 2 ---
        if($yesnoalfa -eq "N"){
    
            #--- EMPIEZA EL DO (ALFABETICO-MAYUSCULAS-CONESPECIALES) ---
            Do{
            #La diferencia aquí es que agrega los caracteres especiales.
            $asciiMayusE = (33..47) + (65..90)
            $Random = Get-Random -InputObject $asciiMayusE
            $pass += ([char]$Random)
            $i++
        }While($i -le $long)   
            #--- TERMINA EL DO ---

        }else{

            #--- EMPIEZA EL DO (ALFANUMERICO-MAYUSCULAS-CONESPECIALES) ---
            Do{
                $asciiMayusE = (0..9) + (33..47) + (65..90)
                $Random = Get-Random -InputObject $asciiMayusE
                if((0..9) -contains $random){
                    $pass += ([string]$Random)
                }else{
                    $pass += ([char]$Random)
                }
                $i++
            }While($i -le $long)
            #--- TERMINA EL DO ---             
        
        } #--- CIERRE DEL YESNOALFA 2 ---

    } #CIERRE DEL YESNOESP

            #--- EMPIEZA LA IMPRESION DE LA CONTRASEÑA ---
            #Este if corresponde al tema del log, si es que el usuario lo desea o no.
            if($sinoLog -eq "S"){
            
                #Con este comando crea un archivo "txt" en la carpeta "C:\Password.txt" con el nombre "Password" y empieza a guardar.
                Start-Transcript -Path $ruta"\password.txt" -append -Force

                Write-host "No comparta esta información con nadie`n"

                #Aca como el usuario desea usar el log, imprimo la descripción que le pedí anteriormente.
                Write-host "Descripción:`n"$desc 

                #Aca le pongo el mismo color de fondo y letra que la linea de comando para que no se pueda ver a simple vista.
                Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
                Write-host "`n[Para ver la contraseña seleccione con el mouse]"     

                Write-host "`n--------------------------------------------------`n"
            
                #Aca termina de guardar lo que imprime en pantalla
                Stop-Transcript

                #Salir del programa avisandote que va a borrar el contenido de la pantalla.
                Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
                Read-Host ("¿Desea salir?`nPresione la tecla enter")
                cls
                Exit
            
            #Este es el camino que toma si el usuario no quiere usar el log. Que es igual que el anterior sin el "Transcript" .
            }else{ #--- ELSE DE LA IMPRESION ---
        
                Write-host "No comparta esta información con nadie`n"
            
                Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
                Write-host "`n[Para ver la contraseña seleccione con el mouse]"          

                Write-host "`n--------------------------------------------------`n" 
            
                Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
                Read-Host ("¿Desea salir?`nPresione la tecla enter")   
                cls
                Exit

            }  #--- TERMINA LA IMPRESION ---  

} #CIERRE DEL SWITCH

B{
    If($yesnoEsp -eq "N"){
    
        #--- EMPIEZA EL IF DEL YESNOALFA 1 ---
        if($yesnoalfa -eq "N"){
        
            #--- EMPIEZA EL DO (ALFABETICO-MINUSCULAS-SINESPECIALES) ---        
            Do{
            #Aca se asignan los valores en los cuales el "Get-Random" va a usar.
            $asciiMinus = 97..122
            #Aca realiza el random mencionado anteriormente.
            $Random = Get-Random -InputObject $asciiMinus
            #Aca lo suma a un array los numeros convertidos a char que PowerShell los entiende como ASCII.
            $pass += ([char]$Random)
            $i++
        #El while sigue hasta la cantidad de caracteres que el usuario eligió al principio.
        }While($i -le $long)            
            #--- TERMINA EL DO --- 
            
        }else{ #--- ELSE DEL YESNOALFA 1 ---

            #--- EMPIEZA EL DO (ALFANUMERICO-MINUSCULAS-SINESPECIALES) ---  
            Do{
                #En este caso selecciono los números del 1 al 9 y del 65 al 90 para hacer los ASCII.
                $asciiMinus = (1..9) + (97..122)
                $Random = Get-Random -InputObject $asciiMinus
                #En este if los sumo dependiendo que son para convertir cada valor en su apropiado formato.
                if((0..9) -contains $random){
                    $pass += ([string]$Random)
                }else{
                    $pass += ([char]$Random)
                }
                $i++
            }While($i -le $long)     
            #--- TERMINA EL DO ---                           
                
        } #--- CIERRE DEL YESNOALFA 1 ---

    }Else{ #--- ELSE DEL YESNOESP

        #--- EMPIEZA EL IF DEL YESNOALFA 2 ---
        if($yesnoalfa -eq "N"){
    
            #--- EMPIEZA EL DO (ALFABETICO-MINUSCULAS-CONESPECIALES) ---
            Do{
            #La diferencia aquí es que agrega los caracteres especiales.
            $asciiMinusE = (33..47) + (97..122)
            $Random = Get-Random -InputObject $asciiMinusE
            $pass += ([char]$Random)
            $i++
        }While($i -le $long)   
            #--- TERMINA EL DO ---

        }else{

            #--- EMPIEZA EL DO (ALFANUMERICO-MINUSCULAS-CONESPECIALES) ---
            Do{
                $asciiMinusE = (0..9) + (33..47) + (97..122)
                $Random = Get-Random -InputObject $asciiMinusE
                if((0..9) -contains $random){
                    $pass += ([string]$Random)
                }else{
                    $pass += ([char]$Random)
                }
                $i++
            }While($i -le $long)
            #--- TERMINA EL DO ---             
        
        } #--- CIERRE DEL YESNOALFA 2 ---

    } #CIERRE DEL YESNOESP

            #--- EMPIEZA LA IMPRESION DE LA CONTRASEÑA  ---
            #Este if corresponde al tema del log, si es que el usuario lo desea o no.
            if($sinoLog -eq "S"){
            
                #Con este comando crea un archivo "txt" en la carpeta "C:\Password.txt" con el nombre "Password" y empieza a guardar.
                Start-Transcript -Path $ruta"\password.txt" -append -Force

                Write-host "No comparta esta información con nadie`n"

                #Aca como el usuario desea usar el log, imprimo la descripción que le pedí anteriormente.
                Write-host "Descripción:`n"$desc 

                #Aca le pongo el mismo color de fondo y letra que la linea de comando para que no se pueda ver a simple vista.
                Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
                Write-host "`n[Para ver la contraseña seleccione con el mouse]"     

                Write-host "`n--------------------------------------------------`n"
            
                #Aca termina de guardar lo que imprime en pantalla
                Stop-Transcript

                #Salir del programa avisandote que va a borrar el contenido de la pantalla.
                Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
                Read-Host ("¿Desea salir?`nPresione la tecla enter")
                cls
                Exit
            
            #Este es el camino que toma si el usuario no quiere usar el log. Que es igual que el anterior sin el "Transcript" .
            }else{ #--- ELSE DE LA IMPRESION  ---
        
                Write-host "No comparta esta información con nadie`n"
            
                Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
                Write-host "`n[Para ver la contraseña seleccione con el mouse]"          

                Write-host "`n--------------------------------------------------`n" 
            
                Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
                Read-Host ("¿Desea salir?`nPresione la tecla enter")   
                cls
                Exit

            }  #--- TERMINA LA IMPRESION  ---  

} #CIERRE DEL SWITCH

C{
    If($yesnoEsp -eq "N"){
    
        #--- EMPIEZA EL IF DEL YESNOALFA 1 ---
        if($yesnoalfa -eq "N"){
        
            #--- EMPIEZA EL DO (ALFABETICO-AMBOS-SINESPECIALES) ---        
            Do{
                #Aca se asignan los valores en los cuales el "Get-Random" va a usar.
                $asciiAmbos = (65..90) + (97..122)
                #Aca realiza el random mencionado anteriormente.
                $Random = Get-Random -InputObject $asciiAmbos
                #Aca lo suma a un array los numeros convertidos a char que PowerShell los entiende como ASCII.
                $pass += ([char]$Random)
                $i++
                #El while sigue hasta la cantidad de caracteres que el usuario eligió al principio.
            }While($i -le $long)            
            #--- TERMINA EL DO --- 
            
        }else{ #--- ELSE DEL YESNOALFA 1 ---

            #--- EMPIEZA EL DO (ALFANUMERICO-AMBOS-SINESPECIALES) ---  
            Do{
                #En este caso selecciono los números del 1 al 9 y del 65 al 90 para hacer los ASCII.
                $asciiAmbos = (1..9) + (65..90) + (97..122)
                $Random = Get-Random -InputObject $asciiAmbos
                #En este if los sumo dependiendo que son para convertir cada valor en su apropiado formato.
                if((0..9) -contains $random){
                    $pass += ([string]$Random)
                }else{
                    $pass += ([char]$Random)
                }
                $i++
            }While($i -le $long)     
            #--- TERMINA EL DO ---                           
                
        } #--- CIERRE DEL YESNOALFA 1 ---

    }Else{ #--- ELSE DEL YESNOESP

        #--- EMPIEZA EL IF DEL YESNOALFA 2 ---
        if($yesnoalfa -eq "N"){
    
            #--- EMPIEZA EL DO (ALFABETICO-AMBOS-CONESPECIALES) ---
            Do{
            #La diferencia aquí es que agrega los caracteres especiales.
            $asciiAmbosE = (33..47) + (65..90) + (97..122)
            $Random = Get-Random -InputObject $asciiAmbosE
            $pass += ([char]$Random)
            $i++
        }While($i -le $long)   
            #--- TERMINA EL DO ---

        }else{

            #--- EMPIEZA EL DO (ALFANUMERICO-MINUSCULAS-CONESPECIALES) ---
            Do{
                $asciiAmbosE = (0..9) + (33..47) + (65..90) + (97..122)
                $Random = Get-Random -InputObject $asciiAmbosE
                if((0..9) -contains $random){
                    $pass += ([string]$Random)
                }else{
                    $pass += ([char]$Random)
                }
                $i++
            }While($i -le $long)
            #--- TERMINA EL DO ---             
        
        } #--- CIERRE DEL YESNOALFA 2 ---

    } #CIERRE DEL YESNOESP

            #--- EMPIEZA LA IMPRESION DE LA CONTRASEÑA ---
            #Este if corresponde al tema del log, si es que el usuario lo desea o no.
            if($sinoLog -eq "S"){
            
                #Con este comando crea un archivo "txt" en la carpeta "C:\Password.txt" con el nombre "Password" y empieza a guardar.
                Start-Transcript -Path $ruta"\password.txt" -append -Force

                Write-host "No comparta esta información con nadie`n"

                #Aca como el usuario desea usar el log, imprimo la descripción que le pedí anteriormente.
                Write-host "Descripción:`n"$desc 

                #Aca le pongo el mismo color de fondo y letra que la linea de comando para que no se pueda ver a simple vista.
                Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
                Write-host "`n[Para ver la contraseña seleccione con el mouse]"     

                Write-host "`n--------------------------------------------------`n"
            
                #Aca termina de guardar lo que imprime en pantalla
                Stop-Transcript

                #Salir del programa avisandote que va a borrar el contenido de la pantalla.
                Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
                Read-Host ("¿Desea salir?`nPresione la tecla enter")
                cls
                Exit
            
            #Este es el camino que toma si el usuario no quiere usar el log. Que es igual que el anterior sin el "Transcript" .
            }else{ #--- ELSE DE LA IMPRESION  ---
        
                Write-host "No comparta esta información con nadie`n"
            
                Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
                Write-host "`n[Para ver la contraseña seleccione con el mouse]"          

                Write-host "`n--------------------------------------------------`n" 
            
                Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
                Read-Host ("¿Desea salir?`nPresione la tecla enter")   
                cls
                Exit

            }  #--- TERMINA LA IMPRESION  ---  

} #CIERRE DEL SWITCH



}
}
##Esta función es la que utilizo cuando alguien quiere crear una contraseña numerica.
function set-numerica{
Write-host "`nUsted a seleccionado la opción 'Numerica'`n" -BackgroundColor Yellow -ForegroundColor black

try{
    [int]$long = Read-Host ("¿Qué longitud quiere que tenga su clave?")
}
catch{
    Write-Host "`n*En este campo solo se permite el uso de enteros.*`n*Por favor vuelva a ejecutar el programa*`n" -ForegroundColor Red
    Write-Host "¡Hasta luego!" -ForegroundColor Yellow
    exit
}

while($long -le 0){
    try{
        [int]$long = Read-Host ("¿Qué longitud quiere que tenga su clave?")
    }
    catch{
        Write-Host "`n*En este campo solo se permite el uso de enteros.*`n*Por favor vuelva a ejecutar el programa*`n" -ForegroundColor Red
        Write-Host "¡Hasta luego!" -ForegroundColor Yellow
        exit
    }    
}

Write-Host "`n¿Desea guardar esta información en un archivo de texto?`n[En caso de guardar se le pedirá una descripción para que recuede para que es la contraseña]`n"

Write-host "[S] Si`n"
    
Write-host "[N] No`n"

$siNoLog = Read-host

While("S","N" -notcontains $sinolog){
    Write-host "No ha ingresado un valor valido" -ForegroundColor Yellow
    $sinolog = Read-Host "Vuelva a intentarlo" 
}

If($siNoLog -eq "S"){
    
    #Aca genera dos números al azar y te los imprime en pantalla como una suma para que lo resuelvas.
    $comp = (1..9)
    $int1 = $RandomComp = Get-Random -InputObject $comp 
    $int2 = $RandomComp = Get-Random -InputObject $comp 
    Write-host "`nConfirmarción:`n"
    $resultado = Read-Host ("$int1 + $int2")

    #Aca comprueba que el resultado que diste sea correcto y sigue con el proceso depende del mismo. 
    if(($int1+$int2) -eq $resultado){
        Write-host "`nBien continuamos`n"
        $ruta = Read-Host ("Ingrese la ruta en donde quiere que se guarde el archivo de texto.`n[Las carpeta/s deben ser creadas con antelación]")
        $existe = Test-Path $ruta 
        while($existe -eq $false){
            Write-host "La ruta ingresada contiene errores.`n"
            $ruta = Read-Host ("Ingrese la ruta en donde quiere que se guarde el archivo de texto.`n[Las carpeta/s deben ser creadas con antelación]")
            $existe = Test-Path $ruta 
        }
        $desc = Read-Host ("Ingrese una descripción.`n[No se admiten saltos de línea]")
        while($desc -eq ""){
           $desc = Read-Host ("Ingrese una descripción.`n[No se admiten saltos de línea]") 
        }
    }else{
        Write-host "¡Hay que volver a la escuela!"
        $siNoLog = "N"
    }


}elseif($sinoLog -eq "N"){

}

$i=1

Write-host "`nGenerando contraseña`n"

Write-host "--------------------------------------------------`n"

Do{
    #Aca toma del 0 al 9 porque esto es solo para contraseñas numericas.
    $numbers = 0..9
    $Random = Get-Random -InputObject $numbers
    #Para poder sumarlas en un array y que no me los sume aritmeticamente las convierto en strings.
    $pass += ([string]$random)
    $i++
}While($i -le $long)

if($sinoLog -eq "S"){
            
    Start-Transcript -Path $ruta"\Password.txt" -append -Force

    Write-host "No comparta esta información con nadie`n"

    Write-host "Descripción:`n"$desc 

    Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
    Write-host "`n[Para ver la contraseña seleccione con el mouse]"     

    Write-host "`n--------------------------------------------------`n"
            
    Stop-Transcript

    Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
    Read-Host ("¿Desea salir?`nPresione la tecla enter")  
    cls
    Exit 
        
}else{
        
    Write-host "No comparta esta información con nadie`n"

    Write-host $pass -ForegroundColor DarkBlue -BackgroundColor DarkBlue  
            
    Write-host "`n[Para ver la contraseña seleccione con el mouse]"       

    Write-host "`n--------------------------------------------------`n"    

    Write-host "El contenido de la pantalla se va a borrar una vez salga del programa"
    Read-Host ("¿Desea salir?`nPresione la tecla enter")   
    cls
    Exit

}

}

##Esta función es la que utilizo para configurar la paleta de colores de la ventana de comandos y poder camuflar las contraseñas.
function set-colors{
 
    $psISE.Options.ConsolePaneBackgroundColor = "DarkBlue"
    $psIse.Options.ConsolePaneForegroundColor = "White"
    $psISE.Options.ConsolePaneTextBackgroundColor = "DarkBlue"
}

#Llamo a la función que como mencione antes lo hago para poder manejar mejor la cantidad de código.
set-colors

#Pequeño mensaje de bienvenida.
Write-Host "Bienvenidos al generador de P a"([char]36)([char]36) "w 0 r d 5`n" -BackgroundColor Yellow -ForegroundColor black

#Menú principal donde me deja elegir que tipo de contraseña deseo generar.
Write-host "¿Qué tipo de contraseña desea crear?`n"

Write-host "[A] Alfabetica / Alfanumerica`n"
    
Write-host "[N] Numerica`n"

$tipo = Read-Host ("Escriba su opción") 

#Una pequeña comprobación como realize en anteriores ocaciones.
While("A", "N" -notcontains $tipo){
    
    Write-host "¿Qué tipo de contraseña desea crear?`n"

    Write-host "[A] Alfabetica / Alfanumerica`n"
    
    Write-host "[N] Numerica`n"

    $tipo = Read-Host ("Escriba su opción") 

}

#El switch que dependiendo de la opción elegida te manda a cada una de las funciones.
Switch($tipo){

A{set-alfa}

N{set-numerica}

}