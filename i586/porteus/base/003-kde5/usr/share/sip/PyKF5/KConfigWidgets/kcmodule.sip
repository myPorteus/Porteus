// Discarded CLASS_DECL on line 21 'KAboutData' (by default forward declaration handling)
// Discarded CLASS_DECL on line 22 'KConfigDialogManager' (by default forward declaration handling)
// Discarded CLASS_DECL on line 23 'KCoreConfigSkeleton' (by default forward declaration handling)
// Discarded CLASS_DECL on line 24 'KConfigSkeleton' (by default forward declaration handling)
// Discarded CLASS_DECL on line 25 'KCModulePrivate' (by default forward declaration handling)
class KCModule: QWidget
{
%TypeHeaderCode
#include <kcmodule.h>
%End
    // Discarded VAR_DECL on line 84 'staticMetaObject' (by Qt5Ruleset.py:VariableRuleDb[0],variable_discard)
    // Discarded CXX_METHOD on line 84 'metaObject' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'qt_metacast' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'qt_metacall' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'tr' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
    // Discarded CXX_METHOD on line 84 'trUtf8' (by Qt5Ruleset.py:FunctionRuleDb[0],function_discard)
public:
    enum Button {
        NoAdditionalButton,
        Help,
        Default,
        Apply,
        Export
    };
    typedef QFlags<KCModule::Button> Buttons;
    // Modified PARM_DECL on line 109 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCModule(const KAboutData*  aboutData, QWidget*  parent /TransferThis/ = nullptr, const QList<QVariant> & args = QVariantList());
    // Modified PARM_DECL on line 117 'parent' (by Qt5Ruleset.py:ParameterRuleDb[0],parameter_transfer_to_parent):
    KCModule(QWidget*  parent /TransferThis/ = nullptr, const QList<QVariant> & args = QVariantList());
    virtual ~KCModule();
    virtual QString quickHelp() const;
    virtual const KAboutData * aboutData() const;
    void setAboutData(const KAboutData*  about);
    KCModule::Buttons buttons() const;
    QString rootOnlyMessage() const;
    bool useRootOnlyMessage() const;
    KAboutData componentData() const;
    QList<KConfigDialogManager *> configs() const;
    void setNeedsAuthorization(bool needsAuth);
    bool needsAuthorization() const;
    bool defaultsIndicatorsVisible() const;
    void setAuthAction(const KAuth::Action & action);
    KAuth::Action authAction() const;
    QString exportText() const;
    void setExportText(const QString & __0);
public Q_SLOTS:
    virtual void load();
    virtual void save();
    virtual void defaults();
    void setDefaultsIndicatorsVisible(bool show);
protected:
    KConfigDialogManager * addConfig(KCoreConfigSkeleton*  config, QWidget*  widget);
    KConfigDialogManager * addConfig(KConfigSkeleton*  config, QWidget*  widget);
    void setQuickHelp(const QString & help);
    virtual void showEvent(QShowEvent*  ev);
Q_SIGNALS:
    void changed(bool state);
    void defaulted(bool state);
    void quickHelpChanged();
    void rootOnlyMessageChanged(bool use, QString message);
    void defaultsIndicatorsVisibleChanged(bool show);
protected Q_SLOTS:
    void changed();
    void markAsChanged();
    void widgetChanged();
    void authStatusChanged(KAuth::Action::AuthStatus status);
protected:
    void setButtons(QFlags<KCModule::Button> btn);
    void setRootOnlyMessage(const QString & message);
    void setUseRootOnlyMessage(bool on);
    bool managedWidgetChangeState() const;
    bool managedWidgetDefaultState() const;
    void unmanagedWidgetChangeState(bool __0);
    void unmanagedWidgetDefaultState(bool __0);
private:
    private:
        KCModule(const KCModule &); // Generated
};
// Discarded FUNCTION_DECL on line 500 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
// Discarded FUNCTION_DECL on line 500 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
// Discarded FUNCTION_DECL on line 500 'operator|' (by Qt5Ruleset.py:FunctionRuleDb[16],function_discard)
