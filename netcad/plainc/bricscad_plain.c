#include <windows.h>
#include <stdio.h>
#include <ole2.h>      // COM headers
#include <oaidl.h>

// Import BricsCAD COM interfaces (generated from .tlb with MIDL compiler)
// Replace with your generated header if available
#import "Bricscad.tlb" no_namespace

int main() {
    HRESULT hr;
    IDispatch *pBricsCADApp = NULL;
    IDispatch *pActiveDocument = NULL;
    VARIANT varResult;

    // Initialize COM
    hr = CoInitialize(NULL);
    if (FAILED(hr)) {
        printf("COM initialization failed: 0x%08lx\n", hr);
        return 1;
    }

    // Create BricsCAD Application instance
    hr = CoCreateInstance(
        CLSID_BricscadApp,         // Replace with BricsCAD's CLSID
        NULL,
        CLSCTX_LOCAL_SERVER,
        IID_IDispatch,
        (void**)&pBricsCADApp
    );

    if (FAILED(hr)) {
        printf("Failed to create BricsCAD instance: 0x%08lx\n", hr);
        CoUninitialize();
        return 1;
    }

    // Make BricsCAD visible
    DISPID dispidVisible;
    OLECHAR *szVisible = L"Visible";
    hr = pBricsCADApp->GetIDsOfNames(IID_NULL, &szVisible, 1, LOCALE_USER_DEFAULT, &dispidVisible);
    if (SUCCEEDED(hr)) {
        VARIANT varVisible;
        VariantInit(&varVisible);
        varVisible.vt = VT_BOOL;
        varVisible.boolVal = VARIANT_TRUE;

        DISPPARAMS dispParams = { &varVisible, NULL, 1, 0 };
        hr = pBricsCADApp->Invoke(
            dispidVisible,
            IID_NULL,
            LOCALE_USER_DEFAULT,
            DISPATCH_PROPERTYPUT,
            &dispParams,
            &varResult,
            NULL,
            NULL
        );
        VariantClear(&varVisible);
    }

    // Get ActiveDocument
    OLECHAR *szActiveDocument = L"ActiveDocument";
    DISPID dispidActiveDocument;
    hr = pBricsCADApp->GetIDsOfNames(IID_NULL, &szActiveDocument, 1, LOCALE_USER_DEFAULT, &dispidActiveDocument);
    if (SUCCEEDED(hr)) {
        hr = pBricsCADApp->Invoke(
            dispidActiveDocument,
            IID_NULL,
            LOCALE_USER_DEFAULT,
            DISPATCH_PROPERTYGET,
            NULL,
            &varResult,
            NULL,
            NULL
        );
        if (SUCCEEDED(hr) && varResult.pdispVal) {
            pActiveDocument = varResult.pdispVal;
        }
    }

    // Execute a command (e.g., draw a line)
    if (pActiveDocument) {
        OLECHAR *szSendCommand = L"SendCommand";
        DISPID dispidSendCommand;
        hr = pActiveDocument->GetIDsOfNames(IID_NULL, &szSendCommand, 1, LOCALE_USER_DEFAULT, &dispidSendCommand);
        if (SUCCEEDEDhr)) {
            // Command string (end with newline to execute)
            VARIANT varCommand;
            VariantInit(&varCommand);
            varCommand.vt = VT_BSTR;
            varCommand.bstrVal = SysAllocString(L"LINE 0,0 100,100\n");

            DISPPARAMS dispParams = { &varCommand, NULL, 1, 0 };
            hr = pActiveDocument->Invoke(
                dispidSendCommand,
                IID_NULL,
                LOCALE_USER_DEFAULT,
                DISPATCH_METHOD,
                &dispParams,
                &varResult,
                NULL,
                NULL
            );
            VariantClear(&varCommand);
        }
    }

    // Cleanup
    if (pActiveDocument) pActiveDocument->Release();
    if (pBricsCADApp) pBricsCADApp->Release();
    CoUninitialize();

    return 0;
}
