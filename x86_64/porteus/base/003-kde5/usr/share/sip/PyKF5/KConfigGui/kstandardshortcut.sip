namespace KStandardShortcut
{
%TypeHeaderCode
#include <kstandardshortcut.h>
%End
    enum StandardShortcut {
        AccelNone,
        Open,
        New,
        Close,
        Save,
        Print,
        Quit,
        Undo,
        Redo,
        Cut,
        Copy,
        Paste,
        PasteSelection,
        SelectAll,
        Deselect,
        DeleteWordBack,
        DeleteWordForward,
        Find,
        FindNext,
        FindPrev,
        Replace,
        Home,
        Begin,
        End,
        Prior,
        Next,
        Up,
        Back,
        Forward,
        Reload,
        BeginningOfLine,
        EndOfLine,
        GotoLine,
        BackwardWord,
        ForwardWord,
        AddBookmark,
        ZoomIn,
        ZoomOut,
        FullScreen,
        ShowMenubar,
        TabNext,
        TabPrev,
        Help,
        WhatsThis,
        TextCompletion,
        PrevCompletion,
        NextCompletion,
        SubstringCompletion,
        RotateUp,
        RotateDown,
        OpenRecent,
        SaveAs,
        Revert,
        PrintPreview,
        Mail,
        Clear,
        ActualSize,
        FitToPage,
        FitToWidth,
        FitToHeight,
        Zoom,
        Goto,
        GotoPage,
        DocumentBack,
        DocumentForward,
        EditBookmarks,
        Spelling,
        ShowToolbar,
        ShowStatusbar,
        SaveOptions,
        KeyBindings,
        Preferences,
        ConfigureToolbars,
        ConfigureNotifications,
        TipofDay,
        ReportBug,
        SwitchApplicationLanguage,
        AboutApp,
        AboutKDE,
        DeleteFile,
        RenameFile,
        MoveToTrash,
        Donate,
        ShowHideHiddenFiles,
        CreateFolder,
        StandardShortcutCount
    };
    enum class Category {
        InvalidCategory,
        File,
        Edit,
        Navigation,
        View,
        Settings,
        Help
    };
    const QList<QKeySequence> & shortcut(KStandardShortcut::StandardShortcut id);
    QString name(KStandardShortcut::StandardShortcut id);
    QString label(KStandardShortcut::StandardShortcut id);
    QString whatsThis(KStandardShortcut::StandardShortcut id);
    KStandardShortcut::StandardShortcut find(const QKeySequence & keySeq);
    KStandardShortcut::StandardShortcut find(const char*  keyName);
    KStandardShortcut::StandardShortcut findByName(const QString & name);
    QList<QKeySequence> hardcodedDefaultShortcut(KStandardShortcut::StandardShortcut id);
    void saveShortcut(KStandardShortcut::StandardShortcut id, const QList<QKeySequence> & newShortcut);
    KStandardShortcut::Category category(KStandardShortcut::StandardShortcut id);
    const QList<QKeySequence> & open();
    const QList<QKeySequence> & openNew();
    const QList<QKeySequence> & close();
    const QList<QKeySequence> & save();
    const QList<QKeySequence> & print();
    const QList<QKeySequence> & quit();
    const QList<QKeySequence> & undo();
    const QList<QKeySequence> & redo();
    const QList<QKeySequence> & cut();
    const QList<QKeySequence> & copy();
    const QList<QKeySequence> & paste();
    const QList<QKeySequence> & pasteSelection();
    const QList<QKeySequence> & selectAll();
    const QList<QKeySequence> & deleteWordBack();
    const QList<QKeySequence> & deleteWordForward();
    const QList<QKeySequence> & find();
    const QList<QKeySequence> & findNext();
    const QList<QKeySequence> & findPrev();
    const QList<QKeySequence> & replace();
    const QList<QKeySequence> & zoomIn();
    const QList<QKeySequence> & zoomOut();
    const QList<QKeySequence> & home();
    const QList<QKeySequence> & begin();
    const QList<QKeySequence> & end();
    const QList<QKeySequence> & beginningOfLine();
    const QList<QKeySequence> & endOfLine();
    const QList<QKeySequence> & prior();
    const QList<QKeySequence> & next();
    const QList<QKeySequence> & gotoLine();
    const QList<QKeySequence> & addBookmark();
    const QList<QKeySequence> & tabNext();
    const QList<QKeySequence> & tabPrev();
    const QList<QKeySequence> & fullScreen();
    const QList<QKeySequence> & help();
    const QList<QKeySequence> & completion();
    const QList<QKeySequence> & prevCompletion();
    const QList<QKeySequence> & nextCompletion();
    const QList<QKeySequence> & substringCompletion();
    const QList<QKeySequence> & rotateUp();
    const QList<QKeySequence> & rotateDown();
    const QList<QKeySequence> & whatsThis();
    const QList<QKeySequence> & reload();
    const QList<QKeySequence> & up();
    const QList<QKeySequence> & back();
    const QList<QKeySequence> & forward();
    const QList<QKeySequence> & backwardWord();
    const QList<QKeySequence> & forwardWord();
    const QList<QKeySequence> & showMenubar();
    const QList<QKeySequence> & deleteFile();
    const QList<QKeySequence> & renameFile();
    const QList<QKeySequence> & createFolder();
    const QList<QKeySequence> & moveToTrash();
    const QList<QKeySequence> & preferences();
    const QList<QKeySequence> & showHideHiddenFiles();
};
