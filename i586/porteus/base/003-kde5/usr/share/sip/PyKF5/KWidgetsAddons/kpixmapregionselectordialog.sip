// Discarded CLASS_DECL on line 16 'KPixmapRegionSelectorWidget' (by default forward declaration handling)
// Discarded CLASS_DECL on line 18 'QImage' (by default forward declaration handling)
class KPixmapRegionSelectorDialog: QDialog
{
%TypeHeaderCode
#include <kpixmapregionselectordialog.h>
%End
    // Discarded VAR_DECL on line 39 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 39 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 39 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    // Modified PARM_DECL on line 47 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPixmapRegionSelectorDialog(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPixmapRegionSelectorDialog();
    KPixmapRegionSelectorWidget * pixmapRegionSelectorWidget() const;
    static QRect // Modified PARM_DECL on line 67 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    getSelectedRegion(const QPixmap & pixmap, QWidget*  parent /Transfer/ = nullptr);
    static QRect // Modified PARM_DECL on line 77 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    getSelectedRegion(const QPixmap & pixmap, int aspectRatioWidth, int aspectRatioHeight, QWidget*  parent /Transfer/ = nullptr);
    static QImage // Modified PARM_DECL on line 86 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    getSelectedImage(const QPixmap & pixmap, QWidget*  parent /Transfer/ = nullptr);
    static QImage // Modified PARM_DECL on line 96 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    getSelectedImage(const QPixmap & pixmap, int aspectRatioWidth, int aspectRatioHeight, QWidget*  parent /Transfer/ = nullptr);
    void adjustRegionSelectorWidgetSizeToFitScreen();
private:
    // Discarded CLASS_DECL on line 105 'KPixmapRegionSelectorDialogPrivate' (by default forward declaration handling)
    KPixmapRegionSelectorDialog(const KPixmapRegionSelectorDialog & __0);
};
