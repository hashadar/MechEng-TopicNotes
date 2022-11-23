import GuiVersion
import GuiDBM
import GuiFILE
import GuiML
import GuiPT
import GuiMO
import GuiVC
import GuiBC
import GuiIC
import GuiPC
import GuiFan
import GuiMacP
import GuiMR
import GuiMRF
import GuiViz
import GuiSC
import GuiOut
import GuiRun

#The following line is for backwards-compatibility, DO NOT DELETE IT.
GuiVersion.RecordVersion("2018.0.0.12183")

GuiFILE.SetMode("ACEU")
GuiFILE.Open(r"C:\Users\dar_h\Documents\MECH0059\CFD Coursework\AneurysmGEOM16.DTF")
GuiVC.Set("Shared/VCSettingMode", "Porous Media")
GuiSC.Set("Relax/Pressure", 0.3)
GuiSC.Set("Relax/Pressure", 1)
GuiSC.Set("Relax/Velocity", 0.9)
GuiSC.Set("Relax/Velocity", 0.1)
GuiFILE.CloseCurrentSim()
