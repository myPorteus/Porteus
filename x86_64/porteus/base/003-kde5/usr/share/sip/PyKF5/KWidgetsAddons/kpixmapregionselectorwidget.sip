// Discarded CLASS_DECL on line 17 'QMenu' (by default forward declaration handling)
class KPixmapRegionSelectorWidget: QWidget
{
%TypeHeaderCode
#include <kpixmapregionselectorwidget.h>
%End
    // Discarded VAR_DECL on line 31 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 31 'metaObject' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacast' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'qt_metacall' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'tr' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
    // Discarded CXX_METHOD on line 31 'trUtf8' (by rules_PyKF5.py:FunctionRuleDb[8],function_discard)
public:
    enum RotateDirection {
        Rotate90,
        Rotate180,
        Rotate270
    };
    // Modified PARM_DECL on line 48 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KPixmapRegionSelectorWidget(QWidget*  parent /TransferThis/ = nullptr);
    virtual ~KPixmapRegionSelectorWidget();
    void setPixmap(const QPixmap & pixmap);
    QPixmap pixmap() const;
    void setSelectedRegion(const QRect & rect);
    QRect selectedRegion() const;
    QRect unzoomedSelectedRegion() const;
    void resetSelection();
    QImage selectedImage() const;
    void setSelectionAspectRatio(int width, int height);
    void setFreeSelectionAspectRatio();
    void setMaximumWidgetSize(int width, int height);
    void rotate(KPixmapRegionSelectorWidget::RotateDirection direction);
public Q_SLOTS:
    void rotateClockwise();
    void rotateCounterclockwise();
Q_SIGNALS:
    void pixmapRotated();
protected:
    virtual QMenu * createPopupMenu();
    virtual bool eventFilter(QObject*  obj, QEvent*  ev);
private:
    // Discarded CLASS_DECL on line 146 'KPixmapRegionSelectorWidgetPrivate' (by default forward declaration handling)
    KPixmapRegionSelectorWidget(const KPixmapRegionSelectorWidget & __0);
};
