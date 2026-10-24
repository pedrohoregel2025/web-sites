<?php
require('fpdf/fpdf.php');

class PDF extends FPDF
{
    // Page header
    function Header()
    {
        if ($this->page == 1)
        {
            // Logo
            //  $this->Image('logo.png',10,6,30);
            // Arial bold 15
            $this->SetFont('Arial','B',15);
            // Move to the right
            $this->Cell(105);
            // Title
            $this->Cell(105,10,'REPORTE DE PROVEEDORES DE ALMACÉN',0,0,'C');

            // Line break
            $this->Ln(20);
        }
    }

// Page footer
    function Footer()
    {
        // Position at 1.5 cm from bottom
        $this->SetY(-15);
        // Arial italic 8
        $this->SetFont('Arial','I',8);
        // Page number
        $this->Cell(275,10,'Pagina '.$this->PageNo().'/{nb}',0,0,'L');
        $this->Cell(43.2,10,date('d/m/Y H:i:s'),0,0,'C');
    }
}

    function __autoload($className){
            $model = "../model/". $className ."_model.php";
            $controller = "../controller/". $className ."_controller.php";
        
           require_once($model);
           require_once($controller);
    }

    $objProveedor = new Proveedor();
    $listado = $objProveedor->Listar_Proveedores();

try {
    // Instanciation of inherited class
    $pdf = new PDF('L','mm',array(216,330));
    $pdf->AliasNbPages();
    $pdf->AddPage();
    $pdf->SetFont('Arial','',11);
    $pdf->SetFillColor(255,255,255);
    $pdf->Cell(30,5,'Cod. Interno',0,0,'L',1);
    $pdf->Cell(100,5,'Proveedor',0,0,'L',1);
    $pdf->Cell(27,5,'Teléfono',0,0,'L',1);
    $pdf->Cell(42,5,'RFC',0,0,'L',1);
    $pdf->Cell(20,5,'Régimen',0,0,'C',1);
    $pdf->Cell(75,5,'Contacto',0,0,'L',1);
    $pdf->Cell(20,5,'Estado',0,0,'C',1);
    $pdf->Line(322,28,10,28);
    $pdf->Line(322,37,10,37);
    $pdf->Ln(9);
    $total = 0;
    if (is_array($listado) || is_object($listado))
    {
        foreach ($listado as $row => $column) {

            $rfc = $column['clave_rfc'];
            $telefono = $column['numero_telefono'];
						
            $telefono = substr($telefono, 0, 3).'-'.substr($telefono, 3, 3).'-'.substr($telefono, 6, 4);
						//Dejar el formato por default						
            //$rfc =  substr($rfc, 0, 4).'-'.substr($rfc, 4, 6).'-'.substr($rfc, 10, 3).'-'.substr($rfc, 13);
						
            $estado = $column['estado'];
            if($estado == '1')
            {
                $estado = 'ACTIVO';

            } else {

                $estado = 'INACTIVO';
            }

            $pdf->setX(9);
            $pdf->Cell(30,5,$column["codigo_proveedor"],0,0,'L',1);
            $pdf->Cell(100,5,$column["nombre_proveedor"],0,0,'L',1);
            $pdf->Cell(27,5,$telefono,0,0,'L',1);
            $pdf->Cell(42,5,$rfc,0,0,'L',1);
            $pdf->Cell(20,5,$column["regimen_fiscal"],0,0,'C',1);
            $pdf->Cell(75,5,$column["nombre_contacto"],0,0,'L',1);
            $pdf->Cell(20,5,$estado,0,0,'C',1);
            $pdf->Ln(6);
            $get_Y = $pdf->GetY();
            $total = $total + 1 ;
        }

        $pdf->Line(322,$get_Y+1,10,$get_Y+1);
        $pdf->SetFont('Arial','B',11);
        $pdf->Text(10,$get_Y + 10,'TOTAL DE PROVEEDORES REGISTRADOS : '.number_format($total, 2, '.', ','));
    }
    

    $pdf->Output('I','Reporte_de_Proveedores.pdf');



} catch (Exception $e) {

    // Instanciation of inherited class
    $pdf = new PDF();
    $pdf->AliasNbPages();
    $pdf->AddPage('L','Letter');
    $pdf->Text(50,50,'ERROR AL IMPRIMIR');
    $pdf->SetFont('Times','',12);
    $pdf->Output();
    
}

?>