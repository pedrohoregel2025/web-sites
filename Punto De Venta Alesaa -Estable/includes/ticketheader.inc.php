<?php
    $pdf->setXY(2,1.5);
    $pdf->MultiCell(73, 4.2, $empresa, 0,'C',0 ,1);

    $pdf->setXY(2,10);
    $pdf->SetFont('Arial', '', 6.9);
    $pdf->MultiCell(73, 4.2, $direccion, 0,'C',0 ,1);

    $get_YD = $pdf->GetY();

    $pdf->setXY(2,6);
    $pdf->SetFont('Arial', '', 8);
    $pdf->MultiCell(73, 4.2, $propietario, 0,'C',0 ,1);


    $pdf->setXY(2,$get_YD);
    $pdf->MultiCell(73, 4.2, 'RFC : '.$rfc.'    Régimen : '.$regimen_fiscal, 0,'C',0 ,1);

    $pdf->setXY(2,$get_YD + 4);
    $pdf->MultiCell(73, 4.2, 'No. Resolución : '.$numero_resolucion, 0,'C',0 ,1);

    $pdf->setXY(2,$get_YD + 8);
    $pdf->MultiCell(73, 4.2, 'Fecha Resolución : '.$fecha_resolucion, 0,'C',0 ,1);

    $pdf->setXY(2,$get_YD + 12);
    $pdf->MultiCell(73, 4.2, 'Serie : '.$serie, 0,'C',0 ,1);


    $get_YH = $pdf->GetY();




