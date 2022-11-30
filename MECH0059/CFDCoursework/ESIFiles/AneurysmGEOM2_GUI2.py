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
GuiVersion.RecordVersion("2020.5.0.13107")

GuiFILE.SetMode("ACEU")
GuiFILE.Open(r"C:\Users\dar_h\Documents\MECH0059\CFD Coursework\AneurysmGEOM2.DTF")
GuiPT.Set("Flow", 1)
GuiMO.Set("Shared/Title", "NewtonianUncoiled2
")
GuiVC.Set([58, 55], "Shared/FluidSubtype", "Liquid")
GuiVC.Set([58, 55], "Shared/Density", 1060)
GuiVC.Set([58, 55], "Shared/Mu", 0.00357)
GuiBC.Set([11], "Flow/U", 0.27)
GuiBC.Set([15, 19], "Shared/BC_Type", "Outlet")
GuiBC.Set([15, 19], "Flow/T", 310)
GuiIC.Set([55, 58], "Shared/T", 310)
GuiSC.Set("Iter/Max_Iteration", 4000)
GuiSC.Set("Iter/Convergence_Crit", 1E-18)
GuiSC.Set("Spatial/Velocity_diff_method", "Central")
GuiSC.Set("Solvers/Velocity_Scheme", "AMG")
GuiSC.Set("Solvers/Velocity_Sweeps", 5)
GuiSC.Set("Solvers/Velocity_Criterion", 0.01)
GuiSC.Set("Solvers/PCorrection_Sweeps", 10)
GuiSC.Set("Relax/Velocity", 0.1)
GuiOut.Set("Graphic/LaminarViscosity", 0)
GuiOut.Set("Graphic/P0", 0)
GuiOut.Set("Graphic/StrainRate", 1)
GuiFILE.Save()
GuiRun.Submit()
GuiBC.Set([11], "Shared/BC_Type", "Inlet")
GuiBC.Set([11], "Flow/T", 310)
GuiBC.Set([11], "Flow/U", 310)
GuiFILE.Save()
GuiRun.Submit()
GuiBC.Set([11], "Flow/U", 0.27)
GuiFILE.Save()
GuiRun.Submit()