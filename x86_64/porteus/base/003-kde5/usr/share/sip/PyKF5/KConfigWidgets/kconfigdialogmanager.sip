// Discarded CLASS_DECL on line 18 'KConfigDialogManagerPrivate' (by default forward declaration handling)
// Discarded CLASS_DECL on line 20 'KCoreConfigSkeleton' (by default forward declaration handling)
// Discarded CLASS_DECL on line 21 'KConfigSkeleton' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KConfigSkeletonItem' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'QWidget' (by default forward declaration handling)
class KConfigDialogManager: QObject
{
%TypeHeaderCode
#include <kconfigdialogmanager.h>
%End
    // Discarded VAR_DECL on line 201 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 201 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 201 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 201 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 201 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 201 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
Q_SIGNALS:
    void settingsChanged();
    void settingsChanged(QWidget*  widget);
    void widgetModified();
public:
    // Modified PARM_DECL on line 240 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigDialogManager(QWidget*  parent /TransferThis/, KCoreConfigSkeleton*  conf);
    // Modified PARM_DECL on line 247 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KConfigDialogManager(QWidget*  parent /TransferThis/, KConfigSkeleton*  conf);
    virtual ~KConfigDialogManager();
    void addWidget(QWidget*  widget);
    bool hasChanged() const;
    bool isDefault() const;
    static QHash<QString, QByteArray> * propertyMap();
    static QHash<QString, QByteArray> * changedMap();
public Q_SLOTS:
    void updateSettings();
    void updateWidgets();
    void updateWidgetsDefault();
    void setDefaultsIndicatorsVisible(bool enabled);
protected:
    void init(bool trackChanges);
    bool parseChildren(const QWidget*  widget, bool trackChanges);
    QByteArray getUserProperty(const QWidget*  widget) const;
    QByteArray getCustomProperty(const QWidget*  widget) const;
    QByteArray getUserPropertyChangedSignal(const QWidget*  widget) const;
    QByteArray getCustomPropertyChangedSignal(const QWidget*  widget) const;
    void setProperty(QWidget*  w, const QVariant & v);
    QVariant property(QWidget*  w) const;
    void setupWidget(QWidget*  widget, KConfigSkeletonItem*  item);
    static void initMaps();
private:
    KConfigDialogManager(const KConfigDialogManager & __0);
};
