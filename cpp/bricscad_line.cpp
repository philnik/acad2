#include <iostream>
#include <windows.h>

/*
#import "C:\\Program Files\\Bricsys\\BricsCAD V24 en_US\\BricscadApp.tlb" no_namespace
#import "C:\\Program Files\\Bricsys\\BricsCAD V24 en_US\\BricscadDb.tlb" no_namespace
#import "C:\\Program Files\\Bricsys\\BricsCAD V24 en_US\\BricscadCommon.tlb" no_namespace
*/

#import "C:\\Program Files\\Bricsys\\BricsCAD V24 en_US\\API\\COM\\axbricscadapp1.tlb" no_namespace
#import "C:\\Program Files\\Bricsys\\BricsCAD V24 en_US\\API\\COM\\axbricscaddb1.tlb" no_namespace

int main() {
    // Initialize COM
    CoInitialize(NULL);

    try {
        // Create BricsCAD Application COM Object
        IAcadApplicationPtr pBricsCAD;
        HRESULT hr = pBricsCAD.CreateInstance("BricscadApp.AcadApplication");

        if (FAILED(hr)) {
            std::cerr << "Failed to launch BricsCAD COM instance." << std::endl;
            return -1;
        }

        // Make BricsCAD visible
        pBricsCAD->Visible = VARIANT_TRUE;

        // Get active document
        IAcadDocumentPtr pDoc = pBricsCAD->ActiveDocument;
        if (!pDoc) {
            std::cerr << "No active document found!" << std::endl;
            return -1;
        }

        // Get ModelSpace
        IAcadModelSpacePtr pModelSpace = pDoc->ModelSpace;
        
        // Define Line Start & End Points
        VARIANT ptStart, ptEnd;
        VariantInit(&ptStart);
        VariantInit(&ptEnd);

        SAFEARRAYBOUND sab[1];
        sab[0].lLbound = 0;
        sab[0].cElements = 3; // 3D Point (x, y, z)

        ptStart.vt = VT_ARRAY | VT_R8;
        ptEnd.vt = VT_ARRAY | VT_R8;
        ptStart.parray = SafeArrayCreate(VT_R8, 1, sab);
        ptEnd.parray = SafeArrayCreate(VT_R8, 1, sab);

        double* start;
        double* end;
        SafeArrayAccessData(ptStart.parray, (void**)&start);
        SafeArrayAccessData(ptEnd.parray, (void**)&end);

        start[0] = 0.0;  // X1
        start[1] = 0.0;  // Y1
        start[2] = 0.0;  // Z1

        end[0] = 100.0;  // X2
        end[1] = 100.0;  // Y2
        end[2


	    1::1   1 == 1 
