!=======================================================================
! Generated by  : PSCAD v4.5.3.0
!
! Warning:  The content of this file is automatically generated.
!           Do not modify, as any changes made here will be lost!
!-----------------------------------------------------------------------
! Component     : Main
! Description   : 
!-----------------------------------------------------------------------


!=======================================================================

      SUBROUTINE MainDyn()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 'emtstor.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's2.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'fnames.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'matlab.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------

!     SUBR    3PHVSRC       ! 3-Phase Source model

!---------------------------------------
! Variable Declarations
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      REAL     V_A, V_B, V_C

! Internal Variables
      REAL     RVD1_1, RVD1_2, RVD1_3, RVD1_4

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOF, IT_0                         ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------

! Dsdyn <-> Dsout transfer index storage

      NTXFR = NTXFR + 1

      TXFR(NTXFR,1) = NSTOL
      TXFR(NTXFR,2) = NSTOI
      TXFR(NTXFR,3) = NSTOF
      TXFR(NTXFR,4) = NSTOC

! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      ISTOF     = NSTOF
      NSTOF     = NSTOF + 3
      NPGB      = NPGB + 3
      INODE     = NNODE + 2
      NNODE     = NNODE + 8
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 15
!---------------------------------------
! Transfers from storage arrays
!---------------------------------------

      V_A      = STOF(ISTOF + 1)
      V_B      = STOF(ISTOF + 2)
      V_C      = STOF(ISTOF + 3)

!---------------------------------------
! Electrical Node Lookup
!---------------------------------------


!---------------------------------------
! Configuration of Models
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Main.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSD:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 1:[source_3] Three Phase Voltage Source Model 2 'Source 1'
! Three Phase Source: Source 1  Type: Ideal
!  
      RVD1_1 = RTCF(NRTCF)
      RVD1_2 = RTCF(NRTCF+1)
      RVD1_3  = 0.0*PI_BY180
      RVD1_4 = RTCF(NRTCF+3)
      NRTCF  = NRTCF + 4
      CALL EMTDC_3PHVSRC(SS(1), (IBRCH(1)+1), (IBRCH(1)+2), (IBRCH(1)+3)&
     &, RVD1_4, .TRUE., RVD1_1 , RVD1_2, RVD1_3)
!

! 1:[xfmr-3p2w] 3 Phase 2 Winding Transformer 
!  TRANSFORMER SATURATION SUBROUTINE
      CALL TSAT1_EXE( (IBRCH(1)+10), (IBRCH(1)+11), (IBRCH(1)+12),SS(1),&
     &1.0,0)

!---------------------------------------
! Feedbacks and transfers to storage
!---------------------------------------

      STOF(ISTOF + 1) = V_A
      STOF(ISTOF + 2) = V_B
      STOF(ISTOF + 3) = V_C

!---------------------------------------
! Transfer to Exports
!---------------------------------------

!---------------------------------------
! Close Model Data read
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE MainOut()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 'emtstor.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's2.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'fnames.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'matlab.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------

      REAL    EMTDC_VVDC    ! 

!---------------------------------------
! Variable Declarations
!---------------------------------------


! Electrical Node Indices

! Control Signals
      REAL     V_A, V_B, V_C

! Internal Variables
      INTEGER  IVD1_1

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOL, ISTOI, ISTOF, ISTOC, IT_0    ! Storage Indices
      INTEGER IPGB                                ! Control/Monitoring
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------

! Dsdyn <-> Dsout transfer index storage

      NTXFR = NTXFR + 1

      ISTOL = TXFR(NTXFR,1)
      ISTOI = TXFR(NTXFR,2)
      ISTOF = TXFR(NTXFR,3)
      ISTOC = TXFR(NTXFR,4)

! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      IPGB      = NPGB
      NPGB      = NPGB + 3
      INODE     = NNODE + 2
      NNODE     = NNODE + 8
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 15
!---------------------------------------
! Transfers from storage arrays
!---------------------------------------

      V_A      = STOF(ISTOF + 1)
      V_B      = STOF(ISTOF + 2)
      V_C      = STOF(ISTOF + 3)

!---------------------------------------
! Electrical Node Lookup
!---------------------------------------


!---------------------------------------
! Configuration of Models
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Main.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSO:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 10:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 4
      V_A = 0.0

! 20:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 4
      V_B = 0.0

! 30:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 4
      V_C = 0.0

! 40:[pgb] Output Channel 'Untitled'

      PGB(IPGB+1) = V_A

! 50:[pgb] Output Channel 'Untitled'

      PGB(IPGB+2) = V_B

! 60:[pgb] Output Channel 'Untitled'

      PGB(IPGB+3) = V_C

!---------------------------------------
! Feedbacks and transfers to storage
!---------------------------------------

      STOF(ISTOF + 1) = V_A
      STOF(ISTOF + 2) = V_B
      STOF(ISTOF + 3) = V_C

!---------------------------------------
! Close Model Data read
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE MainDyn_Begin()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------


!---------------------------------------
! Variable Declarations
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals

! Internal Variables
      INTEGER  IVD1_1
      REAL     RVD1_1, RVD1_2, RVD1_3, RVD1_4
      REAL     RVD1_5, RVD1_6

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      INODE     = NNODE + 2
      NNODE     = NNODE + 8
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 15
!---------------------------------------
! Electrical Node Lookup
!---------------------------------------


!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 1:[source_3] Three Phase Voltage Source Model 2 'Source 1'
      RTCF(NRTCF)   = 6.0*SQRT_2*SQRT_1BY3
      RTCF(NRTCF+1) = 50.0*TWO_PI
      RTCF(NRTCF+3) = 0.0
      NRTCF = NRTCF + 4

! 1:[xfmr-3p2w] 3 Phase 2 Winding Transformer 
      CALL COMPONENT_ID(ICALL_NO,581344849)
      RVD1_1 = ONE_3RD*100.0
      RVD1_2 = 6.0
      RVD1_3 = 33.0*SQRT_1BY3
      CALL E_TF2W_CFG((IXFMR + 1),1,RVD1_1,50.0,0.1,0.0,RVD1_2,RVD1_3,1.&
     &0)
      CALL E_TF2W_CFG((IXFMR + 2),1,RVD1_1,50.0,0.1,0.0,RVD1_2,RVD1_3,1.&
     &0)
      CALL E_TF2W_CFG((IXFMR + 3),1,RVD1_1,50.0,0.1,0.0,RVD1_2,RVD1_3,1.&
     &0)
      IF (0.0 .LT. 0.001) THEN
        RVD1_5 = 0.0
        RVD1_6 = 0.0
        IVD1_1 = 0
      ELSE
        RVD1_6 = 0.0
        RVD1_4 = 6.0/(100.0*RVD1_6)
        RVD1_5 = RVD1_4*RVD1_2*RVD1_2
        RVD1_6 = RVD1_4*RVD1_3*RVD1_3
        IVD1_1 = 1
      ENDIF
      CALL E_BRANCH_CFG( (IBRCH(1)+4),SS(1),IVD1_1,0,0,RVD1_5,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+5),SS(1),IVD1_1,0,0,RVD1_5,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+6),SS(1),IVD1_1,0,0,RVD1_5,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+7),SS(1),IVD1_1,0,0,RVD1_6,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+8),SS(1),IVD1_1,0,0,RVD1_6,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+9),SS(1),IVD1_1,0,0,RVD1_6,0.0,0.0)
      CALL TSAT1_CFG( (IBRCH(1)+10), (IBRCH(1)+11), (IBRCH(1)+12),SS(1),&
     &RVD1_1,RVD1_2,0.2,1.17,50.0,0.0,1.0,0.0)

      RETURN
      END

!=======================================================================

      SUBROUTINE MainOut_Begin()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------


!---------------------------------------
! Variable Declarations
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals

! Internal Variables
      INTEGER  IVD1_1

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      INODE     = NNODE + 2
      NNODE     = NNODE + 8
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 15
!---------------------------------------
! Electrical Node Lookup
!---------------------------------------


!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 10:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 4

! 20:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 4

! 30:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 4

! 40:[pgb] Output Channel 'Untitled'

! 50:[pgb] Output Channel 'Untitled'

! 60:[pgb] Output Channel 'Untitled'

      RETURN
      END
