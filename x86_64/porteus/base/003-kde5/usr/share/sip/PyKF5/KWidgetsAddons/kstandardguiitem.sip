// Discarded CLASS_DECL on line 17 'QString' (by default forward declaration handling)
namespace KStandardGuiItem
{
%TypeHeaderCode
#include <kstandardguiitem.h>
%End
    enum BidiMode {
        UseRTL,
        IgnoreRTL
    };
    enum StandardItem {
        Ok,
        Cancel,
        Yes,
        No,
        Discard,
        Save,
        DontSave,
        SaveAs,
        Apply,
        Clear,
        Help,
        Defaults,
        Close,
        Back,
        Forward,
        Print,
        Continue,
        Open,
        Quit,
        AdminMode,
        Reset,
        Delete,
        Insert,
        Configure,
        Find,
        Stop,
        Add,
        Remove,
        Test,
        Properties,
        Overwrite,
        CloseWindow,
        CloseDocument
    };
    KGuiItem guiItem(KStandardGuiItem::StandardItem id);
    QString standardItem(KStandardGuiItem::StandardItem id);
    KGuiItem ok();
    KGuiItem cancel();
    KGuiItem yes();
    KGuiItem no();
    KGuiItem insert();
    KGuiItem discard();
    KGuiItem save();
    KGuiItem help();
    KGuiItem dontSave();
    KGuiItem saveAs();
    KGuiItem apply();
    KGuiItem clear();
    KGuiItem defaults();
    KGuiItem close();
    KGuiItem closeWindow();
    KGuiItem closeDocument();
    KGuiItem print();
    KGuiItem properties();
    KGuiItem reset();
    KGuiItem overwrite();
    KGuiItem adminMode();
    KGuiItem cont();
    KGuiItem del();
    KGuiItem open();
    KGuiItem back(KStandardGuiItem::BidiMode useBidi = KStandardGuiItem::IgnoreRTL);
    KGuiItem forward(KStandardGuiItem::BidiMode useBidi = KStandardGuiItem::IgnoreRTL);
    KGuiItem configure();
    // Discarded FUNCTION_DECL on line 247 'backAndForward' (by rules_PyKF5.py:FunctionRuleDb[2],function_discard)
    KGuiItem quit();
    KGuiItem find();
    KGuiItem stop();
    KGuiItem add();
    KGuiItem remove();
    KGuiItem test();
    void assign(QPushButton*  button, KStandardGuiItem::StandardItem item);
};
