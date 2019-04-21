﻿Describe "EdiTools testing" {
    # Common file contents for all tests
    $835Body = "ISA*01*0000000000*01*0000000000*ZZ*ABCDEFGHIJKLMNO*ZZ*123456789012345*101127*1719*U*00400*000003438*0*P*>~GS*HP*ABCCOM*01017*20110315*1005*1*X*004010X091A1~ST*835*07504123~BPR*H*5.75*C*NON************20110315~TRN*1*A04B001017.07504*1346000128~DTM*405*20110308~N1*PR*ASHTABULA COUNTY ADAMH BD*XX*6457839886~N3*4817 STATE ROAD SUITE 203~N4*ASHTABULA*OH*44004~N1*PE*LAKE AREA RECOVERY CENTER *FI*346608640~N3*2801 C. COURT~N4*ASHTABULA*OH*44004~REF*PQ*1017~LX*1~CLP*444444*1*56.70*56.52*0*MC*0000000655555555*53~NM1*QC*1*FUDD*ELMER*S***MI*1333333~NM1*82*2*WECOVERWY SVCS*****FI*346608640~REF*F8*A76B04054~SVC*HC:H0005:HF:H9*56.70*56.52**6~DTM*472*20110205~CAS*CO*42*0.18*0~REF*6R*444444~CLP*999999*4*25.95*0*25.95*13*0000000555555555*11~NM1*QC*1*SAM*YOSEMITE*A***MI*3333333~NM1*82*2*ACME AGENCY*****FI*310626223~REF*F8*H57B10401~SVC*ZZ:M2200:HE*25.95*0**1~DTM*472*20021224~CAS*CR*18*25.95*0~CAS*CO*42*0*0~REF*6R*999999~CLP*888888*4*162.13*0*162.13*MC*0000000456789123*11~NM1*QC*1*SQUAREPANTS*BOB* ***MI*2222222~NM1*82*2*BIKINI AGENCY*****FI*310626223~REF*F8*H57B10401~SVC*ZZ:M151000:F0*162.13*0**1.9~DTM*472*20020920~CAS*CO*29*162.13*0*42*0*0~REF*6R*888888~CLP*111111*2*56.52*18.88*0*13*0000000644444444*53~NM1*QC*1*LEGHORN*FOGHORN*P***MI*7777777~NM1*82*2*CHICKENHAWK SVCS*****FI*346608640~REF*F8*A76B04054~SVC*HC:H0005:HF:H9*56.52*18.88**6~DTM*472*20031209~CAS*CO*42*0*0~CAS*OA*23*37.64*0~REF*6R*111111~CLP*121212*4*56.52*0*0*13*0000000646464640*53~NM1*QC*1*EXPLORER*DORA****MI*1717171~NM1*82*2*SWIPER AGENCY*****FI*346608640~REF*F8*A76B04054~SVC*HC:H0005:HF:H9*56.52*0**6~DTM*472*20031202~CAS*CO*42*0*0~CAS*OA*23*57.6*0*23*-1.08*0~REF*6R*121212~CLP*333333*1*74.61*59.69*14.92*13*0000000688888888*55~NM1*QC*1*BEAR*YOGI* ***MI*2222222~NM1*82*2*JELLYSTONE SVCS*****FI*346608640~REF*F8*A76B04054~SVC*ZZ:A0230:HF*74.61*59.69**1~DTM*472*20110203~CAS*PR*2*14.92*0~CAS*CO*42*0*0~REF*6R*333333~CLP*777777*25*136.9*0*0*13*0000000622222222*53~NM1*QC*1*BIRD*TWEETY*M***MI*4444444~NM1*82*2*GRANNY AGENCY*****FI*340716747~REF*F8*A76B03293~SVC*HC:H0015:HF:99:H9*136.9*0**1~DTM*472*20030911~CAS*PI*104*136.72*0~CAS*CO*42*0.18*0~REF*6R*777777~CLP*123456*22*-42.58*-42.58*0*13*0000000657575757*11~NM1*QC*1*SIMPSON*HOMER* ***MI*8787888~NM1*82*2*DOH GROUP*****FI*310626223~REF*F8*A57B04033~SVC*HC:H0036:GT:UK*-42.58*-42.58**-2~DTM*472*20110102~CAS*CR*141*0*0*42*0*0*22*0*0~CAS*OA*141*0*0~REF*6R*123456~CLP*090909*22*-86.76*-86.76*0*MC*0000000648484848*53~NM1*QC*1*DUCK*DAFFY*W***MI*1245849~NM1*82*2*ABTHSOLUTE HELP*****FI*346608640~REF*F8*A76B04054~SVC*HC:H0004:HF:H9*-86.76*-86.76**-4~DTM*472*20110210~CAS*CR*22*0*0*42*0*0~CAS*OA*22*0*0~REF*6R*090909~LQ*HE*MA92~SE*93*07504123~GE*1*1~IEA*1*004075123"
    $numberOfSegments = $835Body.Split("~").Count - 1

    It "has 96 segments" {
        $numberOfSegments | Should Be 96
    }

    Context "Test file has segment delimiters only" {
        $filePathSegDelimOnly = Join-Path $TestDrive 'testFileStandardFormat.txt'    #'TestDrive:\testFileStandardFormat.txt'
        Set-Content -Path $filePathSegDelimOnly -Value $835Body

        It "returns HasCarriageReturn as false" {
            $ediFile = Get-EdiFile -InputObject $filePathSegDelimOnly
            $ediFile.HasCarriageReturn | Should Be $false
        }

        It "returns HasLineFeed as false" {
            $ediFile = Get-EdiFile -InputObject $filePathSegDelimOnly
            $ediFile.HasLineFeed | Should Be $false
        }

    }

    Context "Test file has segment delimiter and line feed" {
        # $filePathSegDelimWithLineFeed = 'TestDrive:\file1-LineFeedOnly.txt'
        # Set-Content -Path $filePathSegDelimWithLineFeed -Value ($835Body).Replace("~", "~`n")
    }

    Context "Test file has segment delimiter, carriage return, and line feed" {
        # $filePathSegDelimWithCarriageReturnAndLineFeed = 'TestDrive:\file1-LineFeedOnly.txt'
        # Set-Content -Path $filePathSegDelimWithCarriageReturnAndLineFeed -Value ($835Body).Replace("~", "~`r`n")
    }
    Context "Test file has carriage return and line feed AS the segment delimiter" {
        # $filePathCarriageReturnAndLineFeedOnly = 'TestDrive:\file1-LineFeedOnly.txt'
        # Set-Content -Path $filePathCarriageReturnAndLineFeedOnly -Value ($835Body).Replace("~", "`r`n")
    }

}
