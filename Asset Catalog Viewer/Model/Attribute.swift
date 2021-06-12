//
//  Attribute.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//


/// Rendition Attributes.
enum Attribute {
    
    /// ThemeSize
    enum Size: UInt16 {
        /// kCoreThemeSizeRegular
        case Regular = 0
        /// kCoreThemeSizeSmall
        case Small = 1
        /// kCoreThemeSizeMini
        case Mini = 2
        /// kCoreThemeSizeLarge
        case Large = 3
    }
    
    /// ThemeDirection
    enum Direction: UInt16 {
        /// kCoreThemeDirectionHorizontal
        case Horizontal = 0
        /// kCoreThemeDirectionVertical
        case Vertical = 1
        /// kCoreThemeDirectionPointingUp
        case PointingUp = 2
        /// kCoreThemeDirectionPointingDown
        case PointingDown = 3
        /// kCoreThemeDirectionPointingLeft
        case PointingLeft = 4
        /// kCoreThemeDirectionPointingRight
        case PointingRight = 5
    }
    
    /// ThemeValue
    enum Value: UInt16 {
        /// kCoreThemeValueOff
        case Off = 0
        /// kCoreThemeValueOn
        case On = 1
        /// kCoreThemeValueMixed
        case Mixed = 2
    }
    
    /// ThemeState
    enum State: UInt16 {
        /// kCoreThemeStateNormal
        case Normal = 0
        /// kCoreThemeStateRollover
        case Rollover = 1
        /// kCoreThemeStatePressed
        case Pressed = 2
        /// obsolete_kCoreThemeStateInactive
        case Inactive = 3
        /// kCoreThemeStateDisabled
        case Disabled = 4
        /// kCoreThemeStateDeeplyPressed
        case DeeplyPressed = 5
    }
    
    /// ThemePresentationState
    enum PresentationState: UInt16 {
        /// kCoreThemePresentationStateActive
        case Active = 0
        /// kCoreThemePresentationStateInactive
        case Inactive = 1
        /// kCoreThemePresentationStateActiveMain
        case Main = 2
    }
    
    /// ThemeDrawingLayer
    enum Layer: UInt16 {
        /// kCoreThemeLayerBase
        case Base = 0
        /// kCoreThemeLayerHighlight
        case Highlight = 1
        /// kCoreThemeLayerMask
        case Mask = 2
        /// kCoreThemeLayerPulse
        case Pulse = 3
        /// kCoreThemeLayerHitMask
        case HitMask = 4
        /// kCoreThemeLayerPatternOverlay
        case PatternOverlay = 5
        /// kCoreThemeLayerOutline
        case Outline = 6
        /// kCoreThemeLayerInterior
        case Interior = 7
    }
    
    /// ThemeScale
    enum Scale: UInt16 {
        /// Universal scale factor.
        case Universal = 0
        /// @1x scale factor.
        case x1 = 1
        /// @2x scale factor.
        case x2 = 2
        /// @3x scale factor.
        case x3 = 3
        
        /// Returns the name of the scale factor enum case.
        var string: String {
            switch self {
            case .Universal:    return "Universal"
            case .x1:           return "1x"
            case .x2:           return "2x"
            case .x3:           return "3x"
            }
        }
    }
    
    /// ThemeIdiom
    enum Idiom: UInt16 {
        /// kCoreThemeIdiomUniversal
        case Universal = 0
        /// kCoreThemeIdiomPhone
        case iPhone = 1
        /// kCoreThemeIdiomPad
        case iPad = 2
        /// kCoreThemeIdiomTV
        case AppleTV = 3
        /// kCoreThemeIdiomCar
        case CarPlay = 4
        /// kCoreThemeIdiomWatch
        case AppleWatch = 5
        /// kCoreThemeIdiomMarketing
        case Marketing = 6
        /// kCoreThemeIdiomMac
        case Mac = 7
    }
    
    /// ThemeUISizeClass
    enum SizeClass: UInt16 {
        /// kCoreThemeUISizeClassUnspecified
        case Universal = 0
        /// kCoreThemeUISizeClassCompact
        case Compact = 1
        /// kCoreThemeUISizeClassRegular
        case Regular = 2
    }
    
    /// ThemeMemoryClass
    enum Memory: UInt16 {
        /// kCoreThemeMemoryClassLow
        case `Any` = 0
        /// kCoreThemeMemoryClass1GB
        case Class1GB = 1
        /// kCoreThemeMemoryClass2GB
        case Class2GB = 2
        /// kCoreThemeMemoryClass4GB
        case Class4GB = 3
        /// kCoreThemeMemoryClass3GB
        case Class3GB = 4
        /// kCoreThemeMemoryClass6GB
        case Class6GB = 6
        /// kCoreThemeMemoryClass8GB
        case Class8GB = 8
        /// kCoreThemeMemoryClass16GB
        case Class16GB = 16
        
        /// Returns the name of the memory class enum case.
        var string: String {
            switch self {
            case .Any:          return "Any Memory"
            case .Class1GB:     return "1 GB"
            case .Class2GB:     return "2 GB"
            case .Class4GB:     return "4 GB"
            case .Class3GB:     return "3 GB"
            case .Class6GB:     return "6 GB"
            case .Class8GB:     return "8 GB"
            case .Class16GB:    return "16 GB"
            }
        }
    }
    
    /// ThemeGraphicsFeatureSetClass
    enum Graphics: UInt16 {
        /// kCoreThemeFeatureSetOpenGLES2 / GLES2,0
        case OpenGLES2 = 0
        /// kCoreThemeFeatureSetMetalGPUFamily1 / APPLE1
        case MetalGPUFamily1 = 1
        /// kCoreThemeFeatureSetMetalGPUFamily2 / APPLE2
        case MetalGPUFamily2 = 2
        /// kCoreThemeFeatureSetMetalGPUFamily3_Deprecated / APPLE3v1
        case MetalGPUFamily3_Deprecated = 3
        /// kCoreThemeFeatureSetMetalGPUFamily3 / APPLE3
        case MetalGPUFamily3 = 4
        /// kCoreThemeFeatureSetMetalGPUFamily4 / APPLE4
        case MetalGPUFamily4 = 5
        /// kCoreThemeFeatureSetMetalGPUFamily5 / APPLE5
        case MetalGPUFamily5 = 6
        /// kCoreThemeFeatureSetMetalGPUFamily6 / APPLE6
        case MetalGPUFamily6 = 7
        /// kCoreThemeFeatureSetMetalGPUFamily7 / APPLE7
        case MetalGPUFamily7 = 8
    }
    
    /// ThemeDisplayGamut
    enum Gamut: UInt16 {
        /// kCoreThemeDisplayGamutSRGB
        case sRGB = 0
        /// kCoreThemeDisplayGamutP3
        case P3 = 1
    }
    
    /// ThemeDeploymentTarget
    enum Target: UInt16 {
        /// kCoreThemeDeploymentTargetAny
        case TargetAny = 0
        /// kCoreThemeDeploymentTarget2016
        case Target2016 = 1
        /// kCoreThemeDeploymentTarget2017
        case Target2017 = 2
        /// kCoreThemeDeploymentTarget2018
        case Target2018 = 3
        /// kCoreThemeDeploymentTarget2018Plus
        case Target2018Plus = 4
        /// kCoreThemeDeploymentTarget2019
        case Target2019 = 5
        /// kCoreThemeDeploymentTarget2020
        case Target2020 = 6
    }
    
    /// ThemeGlyphWeight
    enum GlyphWeight: UInt16 {
        /// kCoreThemeVectorGlyphWeightNone
        case None = 0
        /// kCoreThemeVectorGlyphWeightUltralight
        case Ultralight = 1
        /// kCoreThemeVectorGlyphWeightThin
        case Thin = 2
        /// kCoreThemeVectorGlyphWeightLight
        case Light = 3
        /// kCoreThemeVectorGlyphWeightRegular
        case Regular = 4
        /// kCoreThemeVectorGlyphWeightMedium
        case Medium = 5
        /// kCoreThemeVectorGlyphWeightSemibold
        case Semibold = 6
        /// kCoreThemeVectorGlyphWeightBold
        case Bold = 7
        /// kCoreThemeVectorGlyphWeightHeavy
        case Heavy = 8
        /// kCoreThemeVectorGlyphWeightBlack
        case Black = 9
    }
    
    /// ThemeGlyphSize
    enum GlyphSize: UInt16 {
        /// kCoreThemeVectorGlyphSizeNone
        case None = 0
        /// kCoreThemeVectorGlyphSizeSmall
        case Small = 1
        /// kCoreThemeVectorGlyphSizeMedium
        case Medium = 2
        /// kCoreThemeVectorGlyphSSizeLarge
        case Large = 3
    }
    
    /// ThemeElement
    enum Element: UInt16 {
        /// kCoreThemeCheckBoxID - CheckBox
        case CheckBox = 1
        /// kCoreThemeRadioButtonID - Radio Button
        case RadioButton = 2
        /// kCoreThemePushButtonID - Push Button
        case PushButton = 3
        /// kCoreThemeBevelButtonGradientID - Bevel Button Gradient
        case BevelButtonGradient = 4
        /// kCoreThemeBevelButtonRoundID - Bevel Button Round
        case BevelButtonRound = 5
        /// kCoreThemeDisclosureButtonID - Disclosure Button
        case DisclosureButton = 6
        /// kCoreThemeComboBoxButtonID - Combo Box Button
        case ComboBoxButton = 7
        /// kCoreThemeTabButtonID - Tab Button
        case TabButton = 8
        /// kCoreThemeGroupedImagesID - Grouped/Packed Images
        case GroupedImages = 9
        /// kCoreThemeGlassButtonID - Glass Push Button
        case GlassPushButton = 10
        /// kCoreThemeBasicButtonID - Basic Button
        case BasicButton = 11
        /// kCoreThemePopUpButtonTexturedID - Pop-Up Button Textured
        case TexturedPopUpButton = 12
        /// kCoreThemeSquarePopUpButtonID - Square Pop-Up Button
        case SquarePopUpButton = 13
        /// kCoreThemePullDownButtonTexturedID - Pull-Down Button Rounded
        case RoundedPullDownButton = 14
        /// kCoreThemeSquarePullDownButtonID - Pull-Down Button Square
        case SquarePullDownButton = 15
        /// kCoreThemeBoxID - Box
        case Box = 16
        /// kCoreThemeMenuID - Menu
        case Menu = 17
        /// kCoreThemeScrollerID - Scroller
        case Scroller = 18
        /// kCoreThemeSplitViewID - SplitView
        case SplitView = 19
        /// kCoreThemeStepperElementID - Stepper
        case Stepper = 20
        /// kCoreThemeTabViewElementID - Tab View
        case TabView = 21
        /// kCoreThemeTableViewElementID - Table View
        case TableView = 22
        /// kCoreThemeTextFieldElementID - Text Field
        case TextField = 23
        /// kCoreThemeWindowID - Window
        case Window = 24
        /// kCoreThemePatternsElementID - Patterns
        case Patterns = 25
        /// kCoreThemeButtonGlyphsID - Button Glyphs
        case ButtonGlyphs = 26
        /// kCoreThemeBezelElementID - Bezel
        case Bezel = 27
        /// kCoreThemeProgressBarID - Progress Bar
        case ProgressBar = 28
        /// kCoreThemeImageWellID - Image Well
        case ImageWell = 29
        /// kCoreThemeSliderID - Slider
        case Slider = 30
        /// kCoreThemeDialID - Dial
        case Dial = 31
        /// kCoreThemeDrawerID - Drawer
        case Drawer = 32
        /// kCoreThemeToolbarID - Toolbar
        case Toolbar = 33
        /// kCoreThemeCursorsID - Cursors
        case Cursors = 34
        /// kCoreThemeTimelineID - Timeline
        case Timeline = 35
        /// kCoreThemeZoomBarID - Zoom Bar
        case ZoomBar = 36
        /// kCoreThemeZoomSliderID - Zoom Slider
        case ZoomSlider = 37
        /// kCoreThemeIconsID - Icons
        case Icons = 38
        /// kCoreThemeListColorPickerScrollerID - List Color Picker Scroller
        case ListColorPickerScroller = 39
        /// kCoreThemeColorPanelID - Color Panel
        case ColorPanel = 40
        /// kCoreThemeTextureID - Texture Group
        case TextureGroup = 41
        /// kCoreThemeBrowserID - Browser
        case Browser = 42
        /// kCoreThemeNavID - Nav Panel
        case NavPanel = 43
        /// kCoreThemeSearchFieldID - Search Field
        case SearchField = 44
        /// kCoreThemeFontPanelID - Font Panel
        case FontPanel = 45
        /// kCoreThemeScrubberID - Scrubber
        case Scrubber = 46
        /// kCoreThemeTexturedWindowID - Textured Window
        case TexturedWindow = 47
        /// kCoreThemeUtilityWindowID - Utility Window
        case UtilityWindow = 48
        /// kCoreThemeTransientColorPickerID - Transient Color Picker
        case TransientColorPicker = 49
        /// kCoreThemeSegmentedScrubberID - Segmented Scrubber
        case SegmentedScrubber = 50
        /// kCoreThemeCommandsID - Commands
        case Commands = 51
        /// kCoreThemePathControlID - Path Control
        case PathControl = 52
        /// kCoreThemeCustomButtonID - Custom Button for Zero Code
        case CustomButton = 53
        /// kCoreThemeZeroCodePlaceHolderID - Zero Code Place Holder
        case ZeroCodePlaceHolder = 54
        /// kCoreThemeRuleEditorID - Rule Editor
        case RuleEditor = 55
        /// kCoreThemeTokenFieldID - Token Field
        case TokenField = 56
        /// kCoreThemePopUpTableViewArrowsID - PopUp Arrows for TableViews
        case PopUpTableViewArrows = 57
        /// kCoreThemePullDownTableViewArrowsID - PullDown Arrow for TableViews
        case PullDownTableViewArrows = 58
        /// kCoreThemeComboBoxTableArrowID - Combo Box Arrow for TableViews
        case ComboBoxTableViewArrow = 59
        /// kCoreThemeRuleEditorPopUpID - Rule Editor - PopUp Button
        case RuleEditorPopUp = 60
        /// kCoreThemeRuleEditorStepperID - Rule Editor - Stepper
        case RuleEditorStepper = 61
        /// kCoreThemeRuleEditorComboBoxID - Rule Editor - ComboBox
        case RuleEditorComboBox = 62
        /// kCoreThemeRuleEditorActionButtonsID - Rule Editor - Action Buttons
        case RuleEditorActionButtons = 63
        /// kCoreThemeColorSliderID - Color Slider
        case ColorSlider = 64
        /// kCoreThemeGradientControlGradientID - Control Gradient
        case GradientControl = 65
        /// kCoreThemeGradientControlBezelID - Gradient Bezel
        case GradientControlBezel = 66
        /// kCoreThemeMegaTrackballID - MegaTrackball
        case MegaTrackball = 67
        // 68-73: Not Found
        /// kCoreThemeLevelIndicatorRelevancyID - LevelIndicatorRelevancy
        case LevelIndicatorRelevancy = 74
        // 75-78: Not Found
        /// kCoreThemeToolbarRaisedEffectID - Toolbar Raised Effect
        case ToolbarRaisedEffect = 79
        /// kCoreThemeSidebarRaisedEffectID - Sidebar Raised Effect
        case SidebarRaisedEffect = 80
        /// kCoreThemeLoweredEmbossedEffectID - Lowered Embossed Effect
        case LoweredEmbossedEffect = 81
        /// kCoreThemeTitlebarRaisedEffectID - Fullscreen/TAL Window Controls Effect
        case TitlebarRaisedEffect = 82
        /// kCoreThemeSegmentedControlRoundedID - Segmented Control Rounded
        case SegmentedControlRounded = 83
        /// kCoreThemeSegmentedControlTexturedID - Segmented Control Textured
        case SegmentedControlTextured = 84
        /// kCoreThemeNamedElementID - Named Element
        case NamedElement = 85
        /// kCoreThemeLetterpressEffectID - Letterpress Emboss Effect
        case LetterpressEmbossEffect = 86
        /// kCoreThemeRoundRectButtonID - Round Rect Button
        case RoundRectButton = 87
        /// kCoreThemeButtonRoundID - Round Button
        case RoundButton = 88
        /// kCoreThemeButtonRoundTexturedID - Textured Round Button
        case TexturedRoundButton = 89
        /// kCoreThemeButtonRoundHelpID - Round Help Button
        case RoundHelpButton = 90
        /// kCoreThemeScrollerOverlayID - Scroll Bar Overlay
        case ScrollBarOverlay = 91
        /// kCoreThemeScrollViewFrameID - Scroll View Frame
        case ScrollViewFrame = 92
        /// kCoreThemePopoverID - Popover
        case Popover = 93
        /// kCoreThemeLightContentEffectID - Light Content Effect
        case LightContentEffect = 94
        /// kCoreThemeDisclosureTriangleElementID - Disclosure Triangle
        case DisclosureTriangle = 95
        /// kCoreThemeSourceListElementID - Source List
        case SourceList = 96
        /// kCoreThemePopUpButtonID - Pop-Up Button
        case PopUpButton = 97
        /// kCoreThemePullDownButtonID - Pull-Down Button
        case PullDownButton = 98
        /// kCoreThemeTextFieldTexturedElementID - Textured Text Field
        case TexturedTextField = 99
        /// kCoreThemeComboBoxButtonTexturedID - Textured Combo Box
        case TexturedComboBox = 100
        /// kCoreThemeStructuredImageElementID - Structured Image
        case StructuredImage = 101
        /// kCoreThemePopUpButtonInsetID - Pop-Up Button Inset
        case PopUpButtonInset = 102
        /// kCoreThemePullDownButtonInsetID - Pull Down Button Inset
        case PullDownButtonInset = 103
        /// kCoreThemeSheetID - Sheet
        case Sheet = 104
        /// kCoreThemeBevelButtonSquareID - Bevel Button Square
        case BevelButtonSquare = 105
        /// kCoreThemeBevelButtonPopUpArrowID - Bevel Button Pop Up Arrow
        case BevelButtonPopUpArrow = 106
        /// kCoreThemeRecessedButtonID - Recessed Button
        case RecessedButton = 107
        /// kCoreThemeSegmentedControlSeparatedToolbarID - Segmented Control Separated Toolbar
        case SegmentedControlSeparatedToolbar = 108
        /// kCoreThemeLightEffectID - Light Effect
        case LightEffect = 109
        /// kCoreThemeDarkEffectID - Dark Effect
        case DarkEffect = 110
        /// kCoreThemeButtonRoundInsetID - Round Button Inset
        case ButtonRoundInset = 111
        /// kCoreThemeSegmentedControlSeparatedID - Segmented Control Separated
        case SegmentedControlSeparated = 112
        /// kCoreThemeBorderlessEffectID - Borderless Effect
        case BorderlessEffect = 113
        /// kCoreThemeMenuBarEffectID - MenuBar Effect
        case MenuBarEffect = 114
        /// kCoreThemeSecondaryBoxID - Secondary Box
        case SecondaryBox = 115
        /// kCoreThemeDockBadgeID - Dock Badge
        case DockBadge = 116
        /// kCoreThemeBannerID - Banner
        case Banner = 117
        /// kCoreThemePushButtonTexturedID - Textured Button
        case TexturedPushButton = 118
        /// kCoreThemeSegmentedControlInsetID - Inset Segmented Control
        case SegmentedControlInset = 119
        /// kCoreThemeHUDWindowID - HUD Window
        case HUDWindow = 120
        /// kCoreThemeFullScreenWindowID - FullScreen Window
        case FullScreenWindow = 121
        /// kCoreThemeTableViewOpaqueElementID - Table View Opaque
        case TableViewOpaque = 122
        /// kCoreThemeTableViewTranslucentElementID - Table View Translucent
        case TableViewTranslucent = 123
        /// kCoreThemeImageWellOpaqueID - Image Well Opaque
        case ImageWellOpaque = 124
        /// kCoreThemeStateTransformEffectID - State Transform Effect
        case StateTransformEffect = 125
        // 126: Not Found
        /// kCoreThemeLightMaterialID - Light Material
        case LightMaterial = 127
        /// kCoreThemeMacLightMaterialID - Mac Light Material
        case MacLightMaterial = 128
        /// kCoreThemeUltralightMaterialID - Ultralight Material
        case UltralightMaterial = 129
        /// kCoreThemeMacUltralightMaterialID - Mac Ultralight Material
        case MacUltralightMaterial = 130
        /// kCoreThemeMacDarkMaterialID - Mac Dark Material
        case MacDarkMaterial = 131
        /// kCoreThemeMacMediumDarkMaterialID - Mac Medium Dark Material
        case MacMediumDarkMaterial = 132
        /// kCoreThemeMacUltradarkMaterialID - Mac Ultradark Material
        case MacUltradarkMaterial = 133
        /// kCoreThemeTitlebarMaterialID - Titlebar Material
        case TitlebarMaterial = 134
        /// kCoreThemeSelectionMaterialID - Selection Material
        case SelectionMaterial = 135
        /// kCoreThemeEmphasizedSelectionMaterialID - Emphasized Selection Material
        case EmphasizedSelectionMaterial = 136
        /// kCoreThemeHeaderMaterialID - Header Material
        case HeaderMaterial = 137
        /// kCoreThemeComboBoxButtonToolbarID - Toolbar Combo Box
        case ComboBoxButtonToolbar = 138
        /// kCoreThemePopUpButtonToolbarID - Pop-Up Button Toolbar
        case PopUpButtonToolbar = 139
        /// kCoreThemePullDownButtonToolbarID - Pull-Down Button Rounded Toolbar
        case PullDownButtonToolbar = 140
        /// kCoreThemeButtonRoundToolbarID - Toolbar Round Button
        case ButtonRoundToolbar = 141
        /// kCoreThemeSegmentedControlSeparatedTexturedID - Segmented Control Separated Textured
        case SegmentedControlSeparatedTextured = 142
        /// kCoreThemeSegmentedControlToolbarID - Segmented Control Toolbar
        case SegmentedControlToolbar = 143
        /// kCoreThemePushButtonToolbarID - Toolbar Button
        case PushButtonToolbar = 144
        /// kCoreThemeLightOpaqueMaterialID - Opaque Light Material
        case LightOpaqueMaterial = 145
        /// kCoreThemeMacLightOpaqueMaterialID - Opaque Mac Light Material
        case MacLightOpaqueMaterial = 146
        /// kCoreThemeUltralightOpaqueMaterialID - Opaque Ultralight Material
        case UltralightOpaqueMaterial = 147
        /// kCoreThemeMacUltralightOpaqueMaterialID - Opaque Mac Ultralight Material
        case MacUltralightOpaqueMaterial = 148
        /// kCoreThemeMacDarkOpaqueMaterialID - Opaque Mac Dark Material
        case MacDarkOpaqueMaterial = 149
        /// kCoreThemeMacMediumDarkOpaqueMaterialID - Opaque Mac Medium Dark Material
        case MacMediumDarkOpaqueMaterial = 150
        /// kCoreThemeMacUltradarkOpaqueMaterialID - Opaque Mac Ultradark Material
        case MacUltradarkOpaqueMaterial = 151
        /// kCoreThemeTitlebarOpaqueMaterialID - Opaque Titlebar Material
        case TitlebarOpaqueMaterial = 152
        /// kCoreThemeSelectionOpaqueMaterialID - Opaque Selection Material
        case SelectionOpaqueMaterial = 153
        /// kCoreThemeEmphasizedSelectionOpaqueMaterialID - Opaque Emphasized Selection Material
        case EmphasizedSelectionOpaqueMaterial = 154
        /// kCoreThemeHeaderOpaqueMaterialID - Opaque Header Material
        case HeaderOpaqueMaterial = 155
        /// kCoreThemeRecessedPullDownButtonID - Recessed Pull Down Button
        case RecessedPullDownButton = 156
        /// kCoreThemeBezelTintEffectID - Bezel Tint Effect
        case BezelTintEffect = 157
        /// kCoreThemeDefaultBezelTintEffectID - Default Bezel Tint Effect
        case DefaultBezelTintEffect = 158
        /// kCoreThemeOnOffBezelTintEffectID - On-Off Bezel Tint Effect
        case OnOffBezelTintEffect = 159
        /// kCoreThemeMacMediumLightMaterialID - Mac Medium Light Material
        case MacMediumLightMaterial = 160
        /// kCoreThemeMacMediumLightOpaqueMaterialID - Opaque Mac Medium Light Material
        case MacMediumLightOpaqueMaterial = 161
        /// kCoreThemeSelectionOverlayID - Selection Overlay
        case SelectionOverlay = 162
        /// kCoreThemeRangeSelectorID - Range Selector
        case RangeSelector = 163
        /// kCoreThemeModelAssetID - Model Asset
        case ModelAsset = 164
        // 165: Not Found
        /// kCoreThemeSegmentedControlSmallSquareID - Segmented Control Small Square
        case SegmentedControlSmallSquare = 166
        /// kCoreThemeLevelIndicatorID - LevelIndicator
        case LevelIndicator = 167
        /// kCoreThemeMenuMaterialID - Menu Material
        case MenuMaterial = 168
        /// kCoreThemeMenuBarMaterialID - Menu Bar Material
        case MenuBarMaterial = 169
        /// kCoreThemePopoverMaterialID - Popover Material
        case PopoverMaterial = 170
        /// kCoreThemePopoverLabelMaterialID - Popover Label Material
        case PopoverLabelMaterial = 171
        /// kCoreThemeToolTipMaterialID - ToolTip Material
        case ToolTipMaterial = 172
        /// kCoreThemeSidebarMaterialID - Sidebar Material
        case SidebarMaterial = 173
        /// kCoreThemeWindowBackgroundMaterialID - Window Background Material
        case WindowBackgroundMaterial = 174
        /// kCoreThemeUnderWindowBackgroundMaterialID - Under Window Background Material
        case UnderWindowBackgroundMaterial = 175
        /// kCoreThemeContentBackgroundMaterialID - Content Background Material
        case ContentBackgroundMaterial = 176
        /// kCoreThemeSpotlightBackgroundMaterialID - Spotlight Background Material
        case SpotlightBackgroundMaterial = 177
        /// kCoreThemeNotificationCenterBackgroundMaterialID - Notification Center Background Material
        case NotificationCenterBackgroundMaterial = 178
        /// kCoreThemeSheetMaterialID - Sheet Material
        case SheetMaterial = 179
        /// kCoreThemeHUDWindowMaterialID - HUD Window Material
        case HUDWindowMaterial = 180
        /// kCoreThemeFullScreenUIMaterialID - Full Screen UI Material
        case FullScreenUIMaterial = 181
        /// kCoreThemeMenuOpaqueMaterialID - Opaque Menu Material
        case MenuOpaqueMaterial = 182
        /// kCoreThemeMenuBarOpaqueMaterialID - Opaque Menu Bar Material
        case MenuBarOpaqueMaterial = 183
        /// kCoreThemePopoverOpaqueMaterialID - Opaque Popover Material
        case PopoverOpaqueMaterial = 184
        /// kCoreThemePopoverLabelOpaqueMaterialID - Opaque Popover Label Material
        case PopoverLabelOpaqueMaterial = 185
        /// kCoreThemeToolTipOpaqueMaterialID - Opaque ToolTip Material
        case ToolTipOpaqueMaterial = 186
        /// kCoreThemeSidebarOpaqueMaterialID - Opaque Sidebar Material
        case SidebarOpaqueMaterial = 187
        /// kCoreThemeWindowBackgroundOpaqueMaterialID - Opaque Window Background Material
        case WindowBackgroundOpaqueMaterial = 188
        /// kCoreThemeUnderWindowBackgroundOpaqueMaterialID - Opaque Under Window Background Material
        case UnderWindowBackgroundOpaqueMaterial = 189
        /// kCoreThemeContentBackgroundOpaqueMaterialID - Opaque Content Background Material
        case ContentBackgroundOpaqueMaterial = 190
        /// kCoreThemeSpotlightBackgroundOpaqueMaterialID - Opaque Spotlight Background Material
        case SpotlightBackgroundOpaqueMaterial = 191
        /// kCoreThemeNotificationCenterBackgroundOpaqueMaterialID - Opaque Notification Center Background Material
        case NotificationCenterBackgroundOpaqueMaterial = 192
        /// kCoreThemeSheetOpaqueMaterialID - Opaque Sheet Material
        case SheetOpaqueMaterial = 193
        /// kCoreThemeHUDWindowOpaqueMaterialID - Opaque HUD Window Material
        case HUDWindowOpaqueMaterial = 194
        /// kCoreThemeFullScreenUIOpaqueMaterialID - Opaque Full Screen UI Material
        case FullScreenUIOpaqueMaterial = 195
        /// kCoreThemeTextHighlightEffectID - Color Effect for Text Highlights
        case TextHighlightEffect = 196
        /// kCoreThemeRowSelectionEffectID - Color Effect for Selected Rows
        case RowSelectionEffect = 197
        /// kCoreThemeFocusRingEffectID - Color Effect for Focus Rings
        case FocusRingEffect = 198
        /// kCoreThemeBoxSquareID - Square Box
        case BoxSquare = 199
        /// kCoreThemeSelectionEffectID - Color Effect for Selection
        case SelectionEffect = 200
        /// kCoreThemeUnderPageBackgroundMaterialID - UnderPage Background Material
        case UnderPageBackgroundMaterial = 201
        /// kCoreThemeUnderPageBackgroundOpaqueMaterialID - UnderPage Background Opaque Material
        case UnderPageBackgroundOpaqueMaterial = 202
        /// kCoreThemeInlineSidebarMaterialID - Inline Sidebar Material
        case InlineSidebarMaterial = 203
        /// kCoreThemeInlineSidebarOpaqueMaterialID - Inline Sidebar Opaque Material
        case InlineSidebarOpaqueMaterial = 204
        /// kCoreThemeMenuBarMenuMaterialID - MenuBar Menu Material
        case MenuBarMenuMaterial = 205
        /// kCoreThemeMenuBarMenuOpaqueMaterialID - MenuBar Menu Opaque Material
        case MenuBarMenuOpaqueMaterial = 206
        /// kCoreThemeHUDControlsBackgroundMaterialID - HUD Controls Background Material
        case HUDControlsBackgroundMaterial = 207
        /// kCoreThemeHUDControlsBackgroundOpaqueMaterialID - HUD Controls Background Opaque Material
        case HUDControlsBackgroundOpaqueMaterial = 208
        /// kCoreThemeSystemBezelMaterialID - System Bezel Material
        case SystemBezelMaterial = 209
        /// kCoreThemeSystemBezelOpaqueMaterialID - System Bezel Opaque Material
        case SystemBezelOpaqueMaterial = 210
        /// kCoreThemeLoginWindowControlMaterialID - Login Window Control Material
        case LoginWindowControlMaterial = 211
        /// kCoreThemeLoginWindowControlOpaqueMaterialID - Login Window Control Opaque Material
        case LoginWindowControlOpaqueMaterial = 212
        /// kCoreThemeDesktopStackMaterialID - Desktop Stack Material
        case kCoreThsemeDesktopStackMaterial = 213
        /// kCoreThemeDesktopStackOpaqueMaterialID - Desktop Stack Opaque Material
        case DesktopStackOpaqueMaterial = 214
        /// kCoreThemeDetailAccentEffectID - Color Effect for Detail Accent Colors
        case DetailAccentEffect = 215
        /// kCoreThemeToolbarStateTransformEffectID - Toolbar State Transform Effect
        case ToolbarStateTransformEffect = 216
        /// kCoreThemeStatefulColorsSystemEffectID - Stateful Colors System Effect
        case StatefulColorsSystemEffect = 217
        /// kCoreThemeSwitchElementID - Switch
        case SwitchElement = 218
        /// kCoreThemeInlineTitlebarMaterialID - Inline Titlebar Material
        case InlineTitlebarMaterial = 219
        /// kCoreThemeInlineTitlebarOpaqueMaterialID - Inline Titlebar Opaque Material
        case InlineTitlebarOpaqueMaterial = 220
        /// kCoreThemeSliderModernID - Slider Modern
        case SliderModern = 221
        /// kCoreThemeSegmentedControlSliderID - Segmented Control Slider
        case SegmentedControlSlider = 222
        /// kCoreThemeSegmentedControlSliderToolbarID - Segmented Control Slider Toolbar
        case SegmentedControlSliderToolbar = 223
        /// kCoreThemeSheetUnderlayMaterialID - Sheet Underlay Material
        case SheetUnderlayMaterial = 224
        /// kCoreThemeSheetUnderlayOpaqueMaterialID - Opaque Sheet Underlay Material
        case OpaqueSheetUnderlayMaterial = 225
        /// kCoreThemeAlertMaterialID - Alert Material
        case AlertMaterial = 226
        /// kCoreThemeAlertOpaqueMaterialID - Opaque Alert Material
        case OpaqueAlertMaterial = 227
        /// kCoreThemeMenuBarSelectionMaterialID - Menu Bar Selection Material
        case MenuBarSelectionMaterial = 228
        /// kCoreThemeMenuBarSelectionOpaqueMaterialID - Opaque Menu Bar Selection Material
        case OpaqueMenuBarSelectionMaterial = 229
        /// kCoreThemeOverlayBackingMaterialID - Overlay Backing Material
        case OverlayBackingMaterial = 230
        /// kCoreThemeOverlayBackingOpaqueMaterialID - Overlay Backing Opaque Material
        case OverlayBackingOpaqueMaterial = 231
        /// kCoreThemeSliderModernToolbarID - Slider Modern Toolbar
        case SliderModernToolbar = 232
        /// kCoreThemeDiscreteSelectionEffectID - Color Effect for Discrete Selection
        case DiscreteSelectionColorEffect = 233
        /// kCoreThemeAlertSheetMaterialID - Alert Sheet Material
        case AlertSheetMaterial = 234
        /// kCoreThemeAlertSheetOpaqueMaterialID - Opaque Alert Sheet Material
        case OpaqueAlertSheetMaterial = 235
    }
    
    /// ThemePart
    enum Part: UInt16 {
        /// kCoreThemeBasicPartID - Basic - Basic Part
        case BasicPart = 0
        /// kCoreThemeTitlebarControlsID - Basic Button - Titlebar Controls
        case TitlebarControls = 1
        /// kCoreThemeShowHideButtonID - Basic Button - Show Hide Button
        case ShowHideButton = 2
        /// kCoreThemeBoxPrimaryID - Box - Primary Box
        case BoxPrimary = 3
        /// kCoreThemeBoxSecondaryID - Box - Secondary Box
        case BoxSecondary = 4
        /// kCoreThemeBoxMetalID - Box - Metal Box
        case BoxMetal = 5
        /// kCoreThemeBoxWellID - Box - Well Box
        case BoxWell = 6
        /// kCoreThemeMenuGlyphsID - Menu - Menu Glyphs
        case MenuGlyphs = 7
        /// kCoreThemeCornerID - Scroller - Corner
        case Corner = 8
        /// kCoreThemeSlotID - Scroller - Slot
        case Slot = 9
        /// kCoreThemeThumbID - Scroller / Zoom / SplitView - Thumb
        case Thumb = 10
        /// kCoreThemeNoArrowID - Scroller - No Arrow
        case NoArrow = 11
        /// kCoreThemeSingleArrowID - Scroller / Toolbar - Single Arrow
        case SingleArrow = 12
        /// kCoreThemeDoubleArrowMinEndID - Scroller - Double Arrow Min End
        case DoubleArrowMinEnd = 13
        /// kCoreThemeDoubleArrowMaxEndID - Scroller - Double Arrow Max End
        case DoubleArrowMaxEnd = 14
        /// kCoreThemeDividerID - SplitView - Divider
        case Divider = 15
        /// kCoreThemeTabViewPrimaryTabID - Tab View - Primary Tab
        case TabViewPrimaryTab = 16
        /// kCoreThemeTabViewSecondaryTabID - Tab View - Secondary Tab
        case TabViewSecondaryTab = 17
        /// kCoreThemeTabViewRodID - Tab View - Tab View Rod
        case TabViewRod = 18
        /// kCoreThemeTabViewLargeRodID - Tab View - Large Rod
        case TabViewLargeRod = 19
        /// kCoreThemeTabViewSmallRodID - Tab View - Small Rod
        case TabViewSmallRod = 20
        /// kCoreThemeTabViewMiniRodID - Tab View - Mini Rod
        case TabViewMiniRod = 21
        /// kCoreThemeTabViewPaneID - Tab View - Tab Pane
        case TabViewPane = 22
        /// kCoreThemePrimaryListHeaderID - Table View - Primary ListHeader
        case PrimaryListHeader = 23
        /// kCoreThemeSecondaryListHeaderID - Table View - Secondary ListHeader
        case SecondaryListHeader = 24
        /// kCoreThemeListHeaderGlyphsID - Table View - ListHeader Glyphs
        case ListHeaderGlyphs = 25
        /// kCoreThemeTitlebarID - Window - Title Bar
        case Titlebar = 26
        /// kCoreThemeWindowButtonsID - Window - Buttons
        case WindowButtons = 27
        /// kCoreThemeResizeControlID - Window - Resize Control
        case ResizeControl = 28
        /// kCoreThemeDoubleArrowID - Toolbar - Double Arrow
        case DoubleArrow = 29
        /// kCoreThemeToolbarIconsID - Toolbar - Toolbar Icons
        case ToolbarIcons = 30
        /// kCoreThemeToolbarSpacerIconsID - Toolbar - Spacer Icons
        case ToolbarSpacerIcons = 31
        /// kCoreThemeProgressBackgroundID - Progress Bar - Background
        case ProgressBackground = 32
        /// kCoreThemeProgressBarDeterminateID - Progress Bar - Determinate
        case ProgressBarDeterminate = 33
        /// kCoreThemeProgressBarIndeterminateID - Progress Bar - Indeterminate
        case ProgressBarIndeterminate = 34
        /// kCoreThemeSliderTrackID - Slider - Track
        case SliderTrack = 35
        /// kCoreThemeSliderKnobID - Slider  - Knob
        case SliderKnob = 36
        /// kCoreThemeSliderTickID - Slider - Tick
        case SliderTick = 37
        /// kCoreThemeThumbnailBezelID - Bezel - Thumbnail
        case ThumbnailBezel = 38
        /// kCoreThemeColorSwatchBezelID - Bezel - Color Swatch
        case ColorSwatchBezel = 39
        /// kCoreThemeRoundBezelID - Text Field - Round Text Field
        case RoundBezel = 40
        /// kCoreThemeSquareBezelID - Text Field - Square Text Field
        case SquareBezel = 41
        /// kCoreThemeVectorArtworkImageID - Vector Artwork Image
        case VectorArtworkImage = 42
        /// kCoreThemeStandardCursorsID - Cursors - Standard Cursors
        case StandardCursors = 43
        /// kCoreThemeTimelineStreamID - Timeline - Stream
        case TimelineStream = 44
        /// kCoreThemeTimelineClipID - Timeline - Clip
        case TimelineClip = 45
        /// kCoreThemeTimelineSelectedClipID - Timeline - Selected Clip
        case TimelineSelectedClip = 46
        /// kCoreThemeTimelineLockOverlayID - Timeline - Lock Overlay
        case TimelineLockOverlay = 47
        // 48: Not Found
        /// kCoreThemeTimelineLockedGlyphID - Timeline - Locked Glyph
        case TimelineLockedGlyph = 49
        /// kCoreThemePlayHeadID - Timeline / Zoom Bar - Play Head
        case PlayHead = 50
        /// kCoreThemeTimelineTrackSizeButtonID - Timeline - Track Size Button
        case TimelineTrackSizeButton = 51
        /// kCoreThemeTimeCodeIconID - Timeline - Time Code Icon
        case TimeCodeIcon = 52
        /// kCoreThemeGlassRoundButtonID - Glass Button / Button Glyphs - Round Button
        case GlassRoundButton = 53
        /// kCoreThemeGlassVisibilityButtonID - Glass Button / Button Glyphs - Visibility Button
        case GlassVisibilityButton = 54
        /// kCoreThemeTabButtonSingletonID - Tab Button - Singleton
        case TabButtonSingleton = 55
        /// kCoreThemeTabButtonMatrixID - Tab Button - Matrix
        case TabButtonMatrix = 56
        /// kCoreThemeSampleGlyphsTabButtonsID - Button Glyphs - Sample Glyphs for Tab Matrix Buttons
        case SampleGlyphsTabButtons = 57
        /// kCoreThemeSampleGlyphsSingleTabButtonID - Button Glyphs - Sample Glyphs for Singleton Tab Buttons
        case SampleGlyphsSingleTabButton = 58
        /// kCoreThemeVectorGlyphID - Glyph Vector Data
        case VectorGlyph = 59
        /// kCoreThemeModelPartID
        case ModelPart = 60
        /// kCoreThemeLargeTextBezelID - Bezel - Large Text Bezel
        case LargeTextBezel = 61
        /// kCoreThemeDisplayTextBezelID - Text Field - Display Text Bezel
        case DisplayTextBezel = 62
        /// kCoreThemeSlideOutBezelID - Drawer - Slideout Bezel
        case SlideOutBezel = 63
        // 64: Not Found
        /// kCoreThemeDrawerAffordanceID - Drawer - Affordance
        case DrawerAffordance = 65
        /// kCoreThemeDimpleID - Dial - Dimple
        case Dimple = 66
        /// kCoreThemeDisclosureTriangleID - Disclosure - Triangle
        case DisclosureTriangle = 67
        /// kCoreThemeDisclosureKnobID - Disclosure - Knob
        case DisclosureKnob = 68
        /// kCoreThemeDisclosureGlyphID - Disclosure - Glyph
        case DisclosureGlyph = 69
        /// kCoreThemeTypeAlignGlyphID - Button Glyphs - Type Alignment Glyph
        case TypeAlignGlyph = 70
        /// kCoreThemeTypeLeadingGlyphID - Button Glyphs - Type Leading Glyph
        case TypeLeadingGlyph = 71
        /// kCoreThemeFontPanelGlyphsID - Button Glyphs - Font Panel Glyphs
        case FontPanelGlyphs = 72
        /// kCoreThemePreferencesID - Icons - Preferences
        case Preferences = 73
        /// kCoreThemeNoteGlyphID - Icons - Note Glyph
        case NoteGlyph = 74
        /// kCoreThemePreviewBezelID - Bezel - Preview Bezel
        case PreviewBezel = 75
        /// kCoreThemeGlassHelpButtonID - Glass Button / Button Glyphs - Help Button
        case GlassHelpButton = 76
        /// kCoreThemeColumnResizerID - Browser - Column Resize
        case ColumnResizer = 77
        /// kCoreThemeSearchButtonID - Search Field - Search Button
        case SearchButton = 78
        /// kCoreThemeCancelButtonID - Search Field - Cancel Button
        case CancelButton = 79
        /// kCoreThemeSnapBackButtonID - Search Field - SnapBack Button
        case SnapBackButton = 80
        /// kCoreThemeArrowsID - Scrubber / Segmented Scrubber - Arrows
        case Arrows = 81
        /// kCoreThemeScopeButtonID - Nav Panel - Scope Button
        case ScopeButton = 82
        /// kCoreThemePreviewButtonID - Nav Panel - Preview Button
        case PreviewButton = 83
        /// kCoreThemeWindowTextureID - Textured Window - Scratches
        case TexturedWindowScratches = 84
        /// kCoreThemeWindowTextureGradientID - Textured Window - Gradient
        case TexturedWindowGradient = 85
        /// kCoreThemeWindowRoundCornerID - Window - Round Corner
        case WindowRoundCorner = 86
        /// kCoreThemeUnifiedWindowFillID - Unified Toolbar - Gradient
        case UnifiedWindowFill = 87
        /// kCoreThemeMenuBarID - Menu - Menu Bar
        case MenuBar = 88
        /// kCoreThemeAppleMenuID - Menu - Apple Menu
        case AppleMenu = 89
        /// kCoreThemeBoxMatteWellID - Box - Matte Well Box
        case BoxMatteWell = 90
        /// kCoreThemeTransientColorPickerImageID - Transient Color Picker - Image
        case TransientColorPickerImage = 91
        /// kCoreThemeTransientColorPickerImageGrayscaleID - Transient Color Picker - Grayscale Image
        case TransientColorPickerImageGrayscale = 92
        /// kCoreThemeTransientColorWellButtonLeftPartID - Transient Color Picker - Color Well Left Part
        case TransientColorWellButtonLeft = 93
        /// kCoreThemeTransientColorWellButtonSeparatorID - Transient Color Picker - Color Well Separator
        case TransientColorWellSeparator = 94
        /// kCoreThemeTransientColorWellButtonRightPartID - Transient Color Picker - Color Well Right Part
        case TransientColorWellButtonRight = 95
        /// kCoreThemeTransientColorWellButtonLeftPartLgID - Transient Color Picker - Color Well (Large) Left Part
        case TransientColorWellButtonLeftLarge = 96
        /// kCoreThemeTransientColorWellButtonSeparatorLgID - Transient Color Picker - Color Well (Large) Separator
        case TransientColorWellSeparatorLarge = 97
        /// kCoreThemeTransientColorWellButtonRightPartLgID - Transient Color Picker - Color Well (Large) Right Part
        case TransientColorWellButtonRightLarge = 98
        /// kCoreThemeCaretID - Segmented Scrubber - Caret
        case Caret = 99
        /// kCoreThemeScrubbingArrowsID - Segmented Scrubber - Scrubbing Arrows
        case ScrubbingArrows = 100
        /// kCoreThemeCommandIconsID - Commands - Icons
        case CommandIcons = 101
        /// kCoreThemeCommandKeyCapID - Commands - Key Cap
        case CommandKeyCap = 102
        /// kCoreThemeCommandInfoID - Commands - Extra KeyPad Glyphs
        case CommandInfo = 103
        /// kCoreThemePathControlDividerID - Path Control - Divider
        case PathControlDivider = 104
        /// kCoreThemePathControlNavBarID - Path Control - Navigation Bar
        case PathControlNavBar = 105
        /// kCoreThemeBoxRaisedID - Box - Raised Box
        case BoxRaised = 106
        /// kCoreThemeBoxInsetID - Box - Inset Box
        case BoxInset = 107
        /// kCoreThemeCommandsSearchFocus - Commands - Searching Focus
        case CommandsSearchFocus = 108
        /// kCoreThemeCommandsSearchOverlay - Commands - Searching Overlay
        case CommandsSearchOverlay = 109
        // 110-111: Not Found
        /// kCoreThemeTableViewChevronID - TableView - Chevron
        case TableViewChevron = 112
        /// kCoreThemeZoomSmallGlyphID - Zero Code - Small Glyph
        case ZoomSmallGlyph = 113
        /// kCoreThemeZoomLargeGlyphID - Zero Code - Large Glyph
        case ZoomLargeGlyph = 114
        /// kCoreThemeCommandKeyCapPatchID - Commands - Key Cap Patch
        case CommandKeyCapPatch = 115
        /// kCoreThemeNavigateBackwardID - Button Glyphs - Navigate Backward
        case NavigateBackward = 116
        /// kCoreThemeNavigateForwardID - Button Glyphs - Navigate Forward
        case NavigateForward = 117
        // 118: Not Found
        /// kCoreThemeGroupWellID - Box - Group Well Box
        case GroupWellBox = 119
        /// kCoreThemeTableViewScrubbingArrowsID - Segmented Scrubber - TableView Scrubbing Arrows
        case TableViewScrubbingArrows = 120
        /// kCoreThemeProgressSpinningID - Progress Indicator - Spinning
        case ProgressSpinning = 121
        /// kCoreThemeLabelBulletRoundID - Rule Editor - Label Bullets Round (Tiger)
        case LabelBulletRound = 122
        /// kCoreThemeLabelSelectorRoundID - Rule Editor - Label Selectors Round (Tiger)
        case LabelSelectorRound = 123
        /// kCoreThemeLabelBulletSquareID - Rule Editor - Label Bullets Square (Leopard)
        case LabelBulletSquare = 124
        /// kCoreThemeLabelSelectorSquareID - Rule Editor - Label Selectors Square (Leopard)
        case LabelSelectorSquare = 125
        /// kCoreThemeDisclosureTriangleSidebarID - Disclosure - Nav Sidebar Highlighted Triangle
        case DisclosureTriangleSidebar = 126
        /// kCoreThemePackedContentsNamesID - Packed Contents Names
        case PackedContentsNames = 127
        /// kCoreThemeTransientColorPickerSwatchBackgroundID - Transient Color Picker - Swatch Background
        case TransientColorPickerSwatchBackground = 128
        /// kCoreThemeSegmentedControlSeparatorID - Segmented Control Separator
        case SegmentedControlSeparator = 129
        /// kCoreThemeColorLabelPatternsID - Color Label Patterns
        case ColorLabelPatterns = 130
        /// kCoreThemeMegaTrackballPuckID - MegaTrackball - Puck
        case MegaTrackballPuck = 131
        /// kCoreThemeMegaTrackballGlyphsID - MegaTrackball - Glyphs
        case MegaTrackballGlyphs = 132
        /// kCoreThemeMegaTrackballBaseGradientID - MegaTrackball - Base Gradient
        case MegaTrackballBaseGradient = 133
        /// kCoreThemeMegaTrackballHueRingID - MegaTrackball - Hue Ring
        case MegaTrackballHueRing = 134
        /// kCoreThemeMegaTrackballBaseShadowMaskID - MegaTrackball - Base Shadow Mask
        case MegaTrackballBaseShadowMask = 135
        /// kCoreThemeMegaTrackballCenterID - MegaTrackball - Center
        case MegaTrackballCenter = 136
        /// kCoreThemeZoomUnifiedGlyphID - Icons - Unified Zoom
        case ZoomUnifiedGlyph = 137
        /// kCoreThemeSegmentedControlBezelID - Segmented Control Bezel
        case SegmentedControlBezel = 138
        /// kCoreThemeBrowserBranchID - Browser - Branch Image
        case BrowserBranch = 139
        /// kCoreThemePaneCapLoweredMenuIndicatorPartID - Pane Cap  - Lowered Menu Indicator
        case PaneCapLoweredMenuIndicator = 140
        /// kCoreThemePaneCapCenteredMenuIndicatorPartID - Pane Cap  - Centered Menu Indicator
        case PaneCapCenteredMenuIndicator = 141
        /// kCoreThemePaneCapPopUpMenuIndicatorPartID - Pane Cap  - Pop Up Menu Indicator
        case PaneCapPopUpMenuIndicator = 142
        /// kCoreThemeCloseButtonGlyphID - Content Tab View -Close Button Glyph
        case CloseButtonGlyph = 143
        /// kCoreThemeContentTabViewTabID - Content Tab View  - Tab
        case ContentTabViewTab = 144
        /// kCoreThemeContentTabViewMenuChevronID - Content Tab View  - Menu Chevron
        case ContentTabViewMenuChevron = 145
        /// kCoreThemeContentViewMenuGrabberID - Content Tab View  - Menu Grabber
        case ContentViewMenuGrabber = 146
        /// kCoreThemeContentViewMenuButtonGlyphID - Content Tab View  - Menu Button Glyph
        case ContentViewMenuButtonGlyph = 147
        /// kCoreThemeContentViewMenuThumbnailHighlightID - Content Tab View  - Menu Thumbnail Highlight
        case ContentViewMenuThumbnailHighlight = 148
        /// kCoreThemeNavPushButtonPartID - Nav Panel - Scope Bar Push (Save) Button
        case NavPanelPushButton = 149
        // 150-152: Not Found
        /// kCoreThemeToolbarSelectionIndicatorID - Toolbar Item Selection Indicator
        case ToolbarSelectionIndicator = 153
        // 154-159: Not Found
        /// kCoreThemeSplitViewGrabberID - SplitView - Grabber
        case SplitViewGrabber = 160
        // 161-170: Not Found
        /// kCoreThemePaneCapHeaderID - Pane Cap Header
        case PaneCapHeader = 171
        /// kCoreThemePaneCapFooterID - Pane Cap Footer
        case PaneCapFooter = 172
        // 173-174: Not Found
        /// kCoreThemeWindowOverlayPatternID - Window - Overlay Pattern
        case WindowOverlayPattern = 175
        /// kCoreThemeWindowBackgroundImageID - Window - Background Image
        case WindowBackgroundImage = 176
        /// kCoreThemeWindowBottomGradientID - Window - Bottom Gradient
        case WindowBottomGradient = 177
        /// kCoreThemeImageEffectID - Image Effect Definition
        case ImageEffect = 178
        /// kCoreThemeTextEffectID - Text Effect Definition
        case TextEffect = 179
        /// kCoreThemeMenuSeparatorID - Menu Separator
        case MenuSeparator = 180
        /// kCoreThemeArtworkImageID - Artwork Image
        case ArtworkImage = 181
        /// kCoreThemeWindowTitlebarSeparatorID - Window Titlebar Separator
        case WindowTitlebarSeparator = 182
        /// kCoreThemeMenuPartID - Menu Background
        case MenuPart = 183
        /// kCoreThemeMenuItemPartID - Menu Item
        case MenuItemPart = 184
        /// kCoreThemeNamedEffectID - Named Effect
        case NamedEffect = 185
        /// kCoreThemeExpandedThumbID - Scroller - Expanded Thumb
        case ExpandedThumb = 186
        /// kCoreThemeTokenFieldTokenBackgroundID - Token Field - Token Background
        case TokenFieldTokenBackground = 187
        /// kCoreThemeProgressBarDeterminateCompleteID - Progress Bar Complete - Determinate
        case ProgressBarDeterminateComplete = 188
        /// kCoreThemeProgressBarDeterminateShadowID - Progress Bar Shadow - Determinate
        case ProgressBarDeterminateShadow = 189
        /// kCoreThemeProgressSpinningDeterminateID - Progress Spinner - Determinate
        case ProgressSpinningDeterminate = 190
        /// kCoreThemePopoverBackgroundID - Popover - Popover Background
        case PopoverBackground = 191
        /// kCoreThemePopoverAreaOfInterestID - Popover - Popover Area of Interest
        case PopoverAreaOfInterest = 192
        /// kCoreThemeSourceListBackgroundID - Source List - Source List Background
        case SourceListBackground = 193
        /// kCoreThemeSourceListSelectionID - Source List - Selected Item
        case SourceListSelection = 194
        /// kCoreThemeSourceListMenuHighlightID - Source List - Menu Highlight
        case SourceListMenuHighlight = 195
        /// kCoreThemeWindowBottomBarSeparatorID - Window BottomBar Separator
        case WindowBottomBarSeparator = 196
        /// kCoreThemePopUpArrowButton - PopUp Arrow Button
        case PopUpArrowButton = 197
        /// kCoreThemePopUpArrowsOnly - PopUp Arrows Only
        case PopUpArrowsOnly = 198
        /// kCoreThemeListHeaderGlyphsPlusBackgroundID - List Header Arrow Plus Background
        case ListHeaderGlyphsPlusBackground = 199
        /// kCoreThemeAnimationPartID - Animation
        case AnimationPart = 200
        /// kCoreThemePopUpArrowsSubpartID - PopUp Arrows Subpart
        case PopUpArrowsSubpart = 201
        /// kCoreThemePopUpEndcapSubpartID - PopUp Endcap Subpart
        case PopUpEndcapSubpart = 202
        /// kCoreThemeDockBadgeBackgroundID - Dock Badge Background
        case DockBadgeBackground = 203
        /// kCoreThemeGroupHeaderID - Table View Group Header
        case GroupHeader = 204
        /// kCoreThemeSliderBackgroundID - Slider Background
        case SliderBackground = 205
        /// kCoreThemeRecognitionGroupID - Recognition Group
        case RecognitionGroup = 206
        /// kCoreThemeRecognitionObjectID - Recognition Object
        case RecognitionObject = 207
        /// kCoreThemeFlattenedImageID - Flattened Image
        case FlattenedImage = 208
        /// kCoreThemeRadiosityImageID - Radiosity Image
        case RadiosityImage = 209
        /// kCoreThemeFillID - Fill
        case Fill = 210
        /// kCoreThemeOuterStrokeID - Outer Stroke
        case OuterStroke = 211
        /// kCoreThemeInnerStrokeID - Inner Stroke
        case InnerStroke = 212
        /// kCoreThemeRangeSelectorNoHandleID - Range Selector No Handle
        case RangeSelectorNoHandle = 213
        /// kCoreThemeRangeSelectorSingleHandleID - Range Selector Single Handle
        case RangeSelectorSingleHandle = 214
        /// kCoreThemeRangeSelectorDualHandleID - Range Selector Dual Handle
        case RangeSelectorDualHandle = 215
        /// kCoreThemeRangeSelectorMonoHandleID - Range Selector Mono Handle
        case RangeSelectorMonoHandle = 216
        /// kCoreThemeColorPartID - Color Part
        case ColorPart = 217
        /// kCoreThemeMultisizeImageSetPartID - Multi-size Image Set Part
        case MultisizeImageSetPart = 218
        /// kCoreThemeModelAssetPartID - Top Level Model Asset
        case ModelAssetPart = 219
        /// kCoreThemeMultisizeImagePartID - Multi-size Image Part
        case MultisizeImagePart = 220
        /// kCoreThemeLevelIndicatorFillID - Level Indicator Fill
        case LevelIndicatorFill = 221
        /// kCoreThemeLevelIndicatorMaskID - Level Indicator Mask
        case LevelIndicatorMask = 222
        /// kCoreThemeLevelIndicatorOutlineID - Level Indicator Border
        case LevelIndicatorBorder = 223
        /// kCoreThemeLevelIndicatorRelevancyBackgroundID - Level Indicator Relevancy Background
        case LevelIndicatorRelevancyBackground = 224
        /// kCoreThemeLevelIndicatorTickMarkMajorID - Level Indicator Tick Mark Major
        case LevelIndicatorTickMarkMajor = 225
        /// kCoreThemeLevelIndicatorTickMarkMinorID - Level Indicator Tick Mark Minor
        case LevelIndicatorTickMarkMinor = 226
        /// kCoreThemeMaskID - Mask Part
        case MaskPart = 227
        /// kCoreThemeBorderPartID - Border Part
        case BorderPart = 228
        /// kCoreThemeRightPartID - Right Part
        case RightPart = 229
        /// kCoreThemeLeftPartID - Left Part
        case LeftPart = 230
        /// kCoreThemeTextStylePartID - Text Style Part
        case TextStylePart = 231
        /// kCoreThemeModelMeshID - Model Mesh Object
        case ModelMesh = 232
        /// kCoreThemeModelSubMeshID - Model SubMesh Object
        case ModelSubMesh = 233
        /// kCoreThemeKnobPartID - Knob
        case Knob = 234
        /// kCoreThemeLabelPartID - Label
        case Label = 235
        /// kCoreThemeProgressSpinningDeterminateTrackID - Progress Spinner - Determinate Track
        case ProgressSpinnerDeterminateTrack = 236
        /// kCoreThemeShadowPartID - Shadow Part
        case ShadowPart = 237
        /// kCoreThemeSidebarPartID - SplitView - Sidebar Divider
        case SplitViewSidebarDivider = 238
    }
    
}
