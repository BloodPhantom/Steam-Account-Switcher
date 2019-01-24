﻿Class GUI_AccountSwitcher {
    Create() {
        global PROGRAM
        global GuiAccountSwitcher, GuiAccountSwitcher_Controls, GuiAccountSwitcher_Submit
        static guiCreated

        ; Free ImageButton memory
		for key, value in GuiAccountSwitcher_Controls ; TO_DO
			if IsIn(key, "hBTN_CloseGUI,hBTN_TabAccounts,hBTN_TabOptions,hBTN_Login")
				ImageButton.DestroyBtnImgList(value)
		
		; Initialize gui arrays
		Gui, AccountSwitcher:Destroy
		Gui.New("AccountSwitcher", "-Caption -Border +LabelGUI_AccountSwitcher_ +HwndhGuiAccountSwitcher", "Steam Account Switcher")
		; Gui.New("AccountSwitcher", "+AlwaysOnTop +ToolWindow +LabelGUI_AccountSwitcher_ +HwndhGuiAccountSwitcher", "AccountSwitcher")
		GuiAccountSwitcher.Is_Created := False

		guiCreated := False
		guiFullHeight := 230, guiFullWidth := 400, borderSize := 1, borderColor := "Black"
		guiHeight := guiFullHeight-(2*borderSize), guiWidth := guiFullWidth-(2*borderSize)
		leftMost := borderSize, rightMost := guiWidth-borderSize
		upMost := borderSize, downMost := guiHeight-borderSize

        Style_SystemButton := [ [0, "0xdddfdd", , "Black"] ; normal
			,  [0, "0x8fddfa"] ; hover
			,  [0, "0x44c6f6"] ] ; press

	    Style_WhiteButton := [ [0, "White", , "Black"] ; normal
			,  [0, "0xdddfdd"] ; hover
			,  [0, "0x8fddfa"] ; press
			,  [0, "0x8fddfa", , "White"] ] ; default

        Style_LoginButton := [ [0, "0x132f44", , "0x6ab5f6"] ; normal
			,  [0, "0x163750", , "0x6ab5f6"] ; hover
			,  [3, "0x163750", "0x102638", "0x0f8fff", 0] ] ; press

        Style_Tab := [ [0, "0x1c4563", "0x878787", "0x80c4ff", 0, , ""] ; normal
			,  [0, "0x132f44", "", "0x80c4ff", 0] ; hover
			,  [3, "0x132f44", "0x0f2434", "0x0f8fff", 0]  ; press
			,  [3, "0x132f44", "0x0f2434", "0x0f8fff", 0 ] ] ; default
  
        Style_Tab := [ [0, "0x132f44", "", "0x80c4ff", 0, , ""] ; normal
			,  [0, "0x163850", "", "0x80c4ff", 0] ; hover
			,  [3, "0x102638", "0x102638", "0x0f8fff", 0]  ; press
			,  [0, "0x1c4563", "", "0x80c4ff", 0 ] ] ; default


        Style_RedBtn := [ [0, "0xe01f1f", "", "White", 0, , ""] ; normal
			, [0, "0xa20b0b", "", "White", 0] ; hover
			, [3, "0xa20b0b", "0x7c0909", "Black", 0]  ; press
			, [3, "0xff5c5c", "0xe60000", "White", 0 ] ] ; default


        Header_X := leftMost, Header_Y := upMost, Header_W := guiWidth-(borderSize*2)-30, Header_H := 18 ; 30=closebtn
        CloseBtn_X := Header_X+Header_W, CloseBtn_Y := Header_Y, CloseBtn_W := 30, CloseBtn_H := Header_H
        ; Tab_Num := 2, Tab_X := leftMost, Tab_Y := Header_Y+Header_H, Tab_W := 35, Tab_H := (guiHeight-Header_H)/Tab_Num-borderSize
        Tab_X := leftMost, Tab_Y := Header_Y+Header_H, Tab_W := guiWidth-80-2, Tab_H := 30
        Tab2_X := Tab_X+Tab_W, Tab2_Y := Tab_Y, Tab2_W := 80, Tab2_H := Tab_H
        ; AccountsList_X := leftMost+Tab_W, AccountsList_Y := Header_Y+Header_H+5, AccountsList_W := guiWidth-Tab_W-borderSize-5, AccountsList_H := guiHeight-Header_H-borderSize-41 ; 30=loginbtn
        AccountsList_X := leftMost, AccountsList_Y := Header_Y+Header_H+Tab_H+5, AccountsList_W := guiWidth-borderSize-5, AccountsList_H := guiHeight-Header_H-Tab_H-41 ; 30=loginbtn
        LoginBtn_X := AccountsList_X+4, LoginBtn_Y := AccountsList_Y+AccountsList_H+2, LoginBtn_W := AccountsList_W-4, LoginBtn_H := 30

        GuiAccountSwitcher.AccountsList_W := AccountsList_W


        /* * * * * * *
		* 	CREATION
		*/

        backGroundColor := "3d4952"
		Gui.Margin("AccountSwitcher", 0, 0)
		Gui.Color("AccountSwitcher", backGroundColor)
		Gui.Font("AccountSwitcher", "Segoe UI", "10")
		Gui, AccountSwitcher:Default ; Required for LV_ cmds

		; *	* Borders
		bordersPositions := [{X:0, Y:0, W:guiFullWidth, H:borderSize}, {X:0, Y:0, W:borderSize, H:guiFullHeight} ; Top and Left
			,{X:0, Y:downMost, W:guiFullWidth, H:borderSize}, {X:rightMost, Y:0, W:borderSize, H:guiFullHeight}] ; Bottom and Right

		Loop 4 ; Left/Right/Top/Bot borders
			Gui.Add("AccountSwitcher", "Progress", "x" bordersPositions[A_Index]["X"] " y" bordersPositions[A_Index]["Y"] " w" bordersPositions[A_Index]["W"] " h" bordersPositions[A_Index]["H"] " Background" borderColor)

		; * * Title bar
		Gui.Add("AccountSwitcher", "Text", "x" Header_X " y" Header_Y " w" Header_W " h" Header_H " hwndhTEXT_HeaderGhost BackgroundTrans ", "") ; Title bar, allow moving
		Gui.Add("AccountSwitcher", "Progress", "xp yp wp hp Background1B1E28") ; Title bar background
		Gui.Add("AccountSwitcher", "Text", "xp yp wp hp Center 0x200 cbdbdbd BackgroundTrans ", "Steam Account Switcher v" PROGRAM.VERSION) ; Title bar text
		imageBtnLog .= Gui.Add("AccountSwitcher", "ImageButton", "x" CloseBtn_X " y" CloseBtn_Y " w" CloseBtn_W " h" CloseBtn_H " 0x200 Center hwndhBTN_CloseGUI", "X", Style_RedBtn, PROGRAM.FONTS["Segoe UI"], 10)
		__f := GUI_AccountSwitcher.DragGui.bind(GUI_AccountSwitcher, GuiHwnd:=GuiAccountSwitcher.Handle)
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls.hTEXT_HeaderGhost,% __f
		__f := GUI_AccountSwitcher.Close.bind(GUI_AccountSwitcher)
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls.hBTN_CloseGUI,% __f

        ; Side tabs
        allTabs := "Accounts|Options"
        Gui.Add("AccountSwitcher", "Tab2", "x0 y0 w0 h0 vTab_AllTabs hwndhTab_AllTabs Choose1", allTabs) ; Make our list of tabs
        Gui, AccountSwitcher:Tab
        GuiAccountSwitcher.Tabs_Controls := {}

        imageBtnLog .= Gui.Add("AccountSwitcher", "ImageButton", "x" Tab_X " y" Tab_Y " w" Tab_W " h" Tab_H " hwndhBTN_TabAccounts", "Accounts", Style_Tab, PROGRAM.FONTS["Segoe UI"], 10)
        __f := GUI_AccountSwitcher.SelectTab.bind(GUI_AccountSwitcher, "Accounts")
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hBTN_TabAccounts"],% __f
        GuiAccountSwitcher.Tabs_Controls["Accounts"] := GuiAccountSwitcher_Controls.hBTN_TabAccounts

        imageBtnLog .= Gui.Add("AccountSwitcher", "ImageButton", "x" Tab2_X " y" Tab2_Y " w" Tab2_W " h" Tab2_H " hwndhBTN_TabOptions", "Options", Style_Tab, PROGRAM.FONTS["Segoe UI"], 10)
        __f := GUI_AccountSwitcher.SelectTab.bind(GUI_AccountSwitcher, "Options")
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hBTN_TabOptions"],% __f
        GuiAccountSwitcher.Tabs_Controls["Options"] := GuiAccountSwitcher_Controls.hBTN_TabOptions

        /* * * * * * * * * * *
		*	TAB ACCOUNTS
		*/
        Gui, AccountSwitcher:Tab, Accounts

        ; Accounts list
        Gui.Add("AccountSwitcher", "ListView", "x" AccountsList_X " y" AccountsList_Y " w" AccountsList_W " h" AccountsList_H " -HDR -Multi -E0x200 AltSubmit +LV0x10000 hwndhLV_AccountsList cWhite Background" backGroundColor, "Accounts List")
        __f := GUI_AccountSwitcher.LVAccounts_OnClick.bind(GUI_AccountSwitcher)
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hLV_AccountsList"],% __f
        LV_SetSelColors(GuiAccountSwitcher_Controls.hLV_AccountsList, "0x183a54", "0x0f8fff") ; ListView Select color

        accountsList := GUI_AccountSwitcher.GetAccountsList()
        GUI_AccountSwitcher.LVAccounts_SetContent(content:=accountsList)
        GUI_AccountSwitcher.LVAccounts_SetColumnWidth()
        

        imgBtnLog .= Gui.Add("AccountSwitcher", "ImageButton", "x" LoginBtn_X " y" LoginBtn_Y " w" LoginBtn_W " h" LoginBtn_H " hwndhBTN_Login", "Login", Style_LoginButton, PROGRAM.FONTS["Segoe UI"], 10)
        __f := GUI_AccountSwitcher.Login.bind(GUI_AccountSwitcher)
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hBTN_Login"],% __f

        /* * * * * * * * * * *
        *   TAB Options
        */
        Gui, AccountSwitcher:Tab, Options

        Gui.Add("AccountSwitcher", "Text", "x" leftMost+5 " y" Tab_Y+Tab_H+8 " cWhite", "Detected Steam folder:")
        Gui.Add("AccountSwitcher", "Edit", "x+5 yp-3 w240 R1 ReadOnly cWhite", Steam.GetInstallationFolder())

        Gui.Add("AccountSwitcher", "Text", "x" leftMost+170 " y" guiHeight-25 " cWhite", "Quick links:")
        Gui.Add("AccountSwitcher", "Picture", "x+7 y" guiHeight-25-4 " w25 h25 hwndhIMG_GitHub", PROGRAM.IMAGES_FOLDER "\GitHub.png")
        Gui.Add("AccountSwitcher", "Picture", "x+5 yp w25 h25 hwndhIMG_Discord", PROGRAM.IMAGES_FOLDER "\Discord.png")
        Gui.Add("AccountSwitcher", "Picture", "x+5 y" guiHeight-34 " w92 h32 hwndhIMG_Paypal", PROGRAM.IMAGES_FOLDER "\DonatePaypal.png")
        __f := GUI_AccountSwitcher.OnPictureLinkClick.bind(GUI_AccountSwitcher, "Paypal")
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hIMG_Paypal"],% __f
		__f := GUI_AccountSwitcher.OnPictureLinkClick.bind(GUI_AccountSwitcher, "Discord")
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hIMG_Discord"],% __f
		__f := GUI_AccountSwitcher.OnPictureLinkClick.bind(GUI_AccountSwitcher, "GitHub")
		GuiControl, AccountSwitcher:+g,% GuiAccountSwitcher_Controls["hIMG_GitHub"],% __f

        Gui, AccountSwitcher:Tab


        GUI_AccountSwitcher.SelectTab("Accounts")
        Gui.Show("AccountSwitcher", "h" guiHeight " w" guiWidth " xCenter yCenter NoActivate Hide")
        Return

        Gui_AccountSwitcher_ContextMenu:
            ctrlHwnd := Get_UnderMouse_CtrlHwnd()
			GuiControlGet, ctrlName, AccountSwitcher:,% ctrlHwnd

			Gui_AccountSwitcher.ContextMenu(ctrlHwnd, ctrlName)
        Return
    }

    /* * * * * * * *
    * TABS
    */

    SelectTab(which) {
        global GuiAccountSwitcher, GuiAccountSwitcher_Controls

        GuiControl, AccountSwitcher:ChooseString,% GuiAccountSwitcher_Controls.hTab_AllTabs,% which

        for tabName, handle in GuiAccountSwitcher.Tabs_Controls {
			if (tabName = which)
				GuiControl, AccountSwitcher:+Disabled,% handle
			else
				GuiControl, AccountSwitcher:-Disabled,% handle
		}
    }

    /* * * * * * * *
    * LV ACCOUNTS
    */

    LVAccounts_OnClick(CtrlHwnd, GuiEvent, EventInfo) {
        global GuiAccountSwitcher

        if IsIn(GuiEvent,"Normal,D,I,K") {
            rowID := LV_GetNext(0, "F")
                if (rowID = 0) {
                    rowID := LV_GetCount()
                }
                LV_GetText(accName, rowID)
                LV_Modify(rowID, "+Select")
                GuiAccountSwitcher.SelectedAccountRow := rowID
                GuiAccountSwitcher.SelectedAccount := accName
        }
    }

    LVAccounts_SetContent(content) {
        if !(content)
            return

        GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")
        GUI_AccountSwitcher.LVAccounts_SetColumnWidth()

        if IsObject(content) {
            for accName, nothing in content
                LV_Add("", accName)
            
            GUI_AccountSwitcher.LVAccounts_SaveAccountsList()
        }
        else
            Loop, Parse, content,% ","
                LV_Add("", A_LoopField)
    }

    LVAccounts_SetColumnWidth() {
        global GuiAccountSwitcher
        GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")

        Loop % LV_GetCount()
            accountsInList++
        if (accountsInList >= 7) { ; Make col smaller to hide horizontal scroll
            SysGet, VSBW, 2 ; Get vertical scroll size
            LV_ModifyCol(1, GuiAccountSwitcher.AccountsList_W-(VSBW+5)) ; VSWB+4 = no hor bar
        }
        else {
            LV_ModifyCol(1, GuiAccountSwitcher.AccountsList_W)
        }
    }

    LVAccounts_GetContent() {
        GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")
        allContent := []
        Loop % LV_GetCount() {
            LV_GetText(thisLineContent, A_Index)
            allContent.Push(thisLineContent)
        }
        return allContent
    }

    LVAccounts_DeleteContent() {
        GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")
        LV_Delete()
    }

    LVAccounts_SaveAccountsList() {
        global PROGRAM

        accountsObj := GUI_AccountSwitcher.LVAccounts_GetContent()
        for index, account in accountsObj
            accountsList := accountsList ? accountsList "," account : account

        INI.Set(PROGRAM.INI_FILE, "SETTINGS_MAIN", "SavedAccounts", accountsList)
    }
    
    /* * * * * *
    * FUNCTIONS
    */

    RemoveButtonFocus() {
        global GuiAccountSwitcher
		ControlFocus,,% "ahk_id " GuiAccountSwitcher.Handle ; Remove focus
    }

    Show() {
        global GuiAccountSwitcher

        hiddenWin := A_DetectHiddenWindows
		DetectHiddenWindows, On
		foundHwnd := WinExist("ahk_id " GuiAccountSwitcher.Handle)
		DetectHiddenWindows, %hiddenWin%

		if (foundHwnd) {
            GUI_AccountSwitcher.SelectTab("Accounts")
			Gui, AccountSwitcher:Show, xCenter yCenter
		}
		else {
			AppendToLogs("GUI_AccountSwitcher.Show(" whichTab "): Non existent. Recreating.")
			GUI_AccountSwitcher.Create()
			GUI_AccountSwitcher.Show()
            return
		}
    }

    OnPictureLinkClick(picName) {
        global PROGRAM

		urlLink := picName="Paypal"?PROGRAM.LINK_SUPPORT
		: picName="Discord"?PROGRAM.LINK_DISCORD
		: picName="GitHub"?PROGRAM.LINK_GITHUB
		: ""

		if (urlLink)
			Run,% urlLink
    }

    SetDefaultListView(lvName) {
        global GuiAccountSwitcher_Controls
        Gui, AccountSwitcher:Default
        Gui, AccountSwitcher:ListView,% GuiAccountSwitcher_Controls[lvName]
    }

    GetAccountsList() {
        global PROGRAM

        localSettings := Get_LocalSettings()
        Declare_LocalSettings(localSettings)

        if (PROGRAM.SETTINGS.SETTINGS_MAIN.SavedAccounts)
            return PROGRAM.SETTINGS.SETTINGS_MAIN.SavedAccounts
        else return Steam.GetAccountsList()
    }

    Login() {
        global PROGRAM, GuiAccountSwitcher

        account := GuiAccountSwitcher.SelectedAccount
        if (!account)
            return

        Gui, AccountSwitcher:Hide

        Steam.SetAutoLoginUser(account)
        Process, Exist, Steam.exe
        if (ErrorLevel)
            Steam.Exit()

        Process, WaitClose, Steam.exe, 5
        Process, Exist, Steam.exe
        if (ErrorLevel) {
            Process, Close, %ErrorLevel%
            Sleep 100
            Process, WaitClose, %ErrorLevel%, 5
            if (ErrorLevel) {
                MsgBox(4096, PROGRAM.NAME, "Failed to close steam.exe process.`nPlease close Steam manually.")
                Process, WaitClose, %ErrorLevel%
            }
        }

        Steam.Start()
        ExitApp
    }

    ContextMenu(CtrlHwnd, CtrlName) {
        global GuiAccountSwitcher, GuiAccountSwitcher_Controls, GuiAccountSwitcher_Submit

        if (CtrlHwnd = GuiAccountSwitcher_Controls.hLV_AccountsList) {
            GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")

            rowID := LV_GetNext(0, "F")
            if (rowID = 0) {
                rowID := LV_GetCount()
            }
            LV_GetText(accName, rowID)
            LV_Modify(rowID, "+Select")
            GuiAccountSwitcher.SelectedAccountRow := rowID
            GuiAccountSwitcher.SelectedAccount := accName
            
            try Menu,RClickMenu,DeleteAll
            Menu, RClickMenu, Add, Add a new account, RClickMenu_AddNewAccount
		    Menu, RClickMenu, Add, Remove this account, RClickMenu_RemoveThisAccount
            Menu, RClickMenu, Add, %accName%, DoNothing
            Menu, RClickMenu, Disable, %accName%
            Menu, RClickMenu, Show
        }
        Return

        RClickMenu_AddNewAccount:
            GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")
            InputBox, newAccName, Adding an account,% ""
            . A_TAb A_TAb  "/!\ IMPORTANT /!\"
            . "`nYou need to tick the ""Remember my password"" checkbox!"
            . "`n"
            . "`nAccount name:", , 370, 180
            if (!ErrorLevel) {
                LV_Add("", newAccName)
                GUI_AccountSwitcher.LVAccounts_SetColumnWidth()
                GUI_AccountSwitcher.LVAccounts_SaveAccountsList()
            }
        Return

        RClickMenu_RemoveThisAccount:
            GUI_AccountSwitcher.SetDefaultListView("hLV_AccountsList")
            LV_Delete(GuiAccountSwitcher.SelectedAccountRow)
            GUI_AccountSwitcher.LVAccounts_SetColumnWidth()

            GUI_AccountSwitcher.LVAccounts_SaveAccountsList()
        Return

    }

    SaveSettings() {
        global PROGRAM
        global GuiAccountSwitcher_Submit
        GUI_AccountSwitcher.Submit()

        GUI_AccountSwitcher.LVAccounts_SaveAccountsList()
    }

    Submit(ctrlName="") {
        global GuiAccountSwitcher_Submit
		Gui.Submit("AccountSwitcher")

		if (CtrlName) {
			Return GuiAccountSwitcher_Submit[ctrlName]
		}
    }

    DragGui(GuiHwnd) {
        PostMessage, 0xA1, 2,,,% "ahk_id " GuiHwnd
        GUI_AccountSwitcher.RemoveButtonFocus()
    }

    Close() {
        ExitApp
    }
}