(* ::Package:: *)

(* ::Title:: *)
(*Analytical Solar Devices*)


(* ::Subtitle:: *)
(*Solar Cell & Modules Library*)


(* ::Chapter:: *)
(*Initialization*)


(* :Copyright: Haohui Liu  *)

(* :Name: Analytical Solar Devices *)

(* :Author: Dr. Liu Haohui *)

(* :Initial Mathematica Version: 12.0 *)

(*:Summary:
	provides analytical models for single junction and multi-junction solar cells and modules.
*)

BeginPackage["AnalyticalSolarDevices`"];


(* ::Section::Closed:: *)
(*Elementary cell models*)


If[ Not@ValueQ[SiCell::usage],
SiCell::usage = "Elementary two diode Si cell model. \
SiCell[spec, T] calculates the full IV curve under the given spectrum and temperature. \
SiCell[spec, T, probe] calculates the current and voltage at the given probe point."]

Options[SiCell]={LuminescentCoupling->0,DeviceArea->1,DeviceParameters->parameters["PERC"],DeviceQE->EQE["PERC"],MetalCoverage->0,SamplePoints->"Default"};

If[ Not@ValueQ[GaAsCell::usage],
GaAsCell::usage = "Elementary two diode GaAs cell model. \
GaAsCell[spec, T] calculates the full IV curve under the given spectrum and temperature. \
GaAsCell[spec, T, probe] calculates the current and voltage at the given probe point."]

Options[GaAsCell]={LuminescentCoupling->0,DeviceArea->1,DeviceParameters->parameters["Alta"],DeviceQE->EQE["Alta"],MetalCoverage->0,OutputCoupling->False};

If[ Not@ValueQ[InGaPCell::usage],
InGaPCell::usage = "Elementary two diode InGaP cell model. \
InGaPCell[spec, T] calculates the full IV curve under the given spectrum and temperature. \
InGaPCell[spec, T, probe] calculates the current and voltage at the given probe point."]

Options[InGaPCell]={LuminescentCoupling->0,DeviceArea->1,DeviceParameters->parameters["Sample InGaP"],DeviceQE->IQE["Sample InGaP"],MetalCoverage->0,OutputCoupling->False};

If[ Not@ValueQ[TwoDiodePerovskiteCell::usage],
TwoDiodePerovskiteCell::usage = "Elementary two diode perovskite cell model. \
TwoDiodePerovskiteCell[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoDiodePerovskiteCell[spec, T, probe] calculates the current and voltage at the given probe point."]

Options[TwoDiodePerovskiteCell]={LuminescentCoupling->0,DeviceArea->1,DeviceParameters->parameters["perovskite_Yang2015"],DeviceQE->EQE["perovskite_Yang2015"],MetalCoverage->0,OutputCoupling->False};

If[ Not@ValueQ[PerovskiteCell::usage],
PerovskiteCell::usage = "Elementary perovskite cell model based on a physics model. \
PerovskiteCell[spec, T] calculates the full IV curve under the given spectrum and temperature. \
PerovskiteCell[spec, T, probe] calculates the current and voltage at the given probe point."]

Options[PerovskiteCell]={LuminescentCoupling->0,DeviceArea->1,DeviceParameters->parameters["perovskite_nip_Yang2017b"],DeviceQE->EQE["perovskite_Yang2017"],MetalCoverage->0,OutputCoupling->False};


(* ::Section::Closed:: *)
(*Single junction module models*)


If[ Not@ValueQ[SiModule::usage],
SiModule::usage = "Simple model for a c-Si module. \
SiModule[spec, T] calculates the full IV curve under the given spectrum and temperature."]

(* default is utility type 72 cell module with M2 156.75mm2 c-Si cell *)
Options[SiModule]={SeriesCells->72,ParallelCells->1,ModuleArea->1.938,DeviceArea->0.0245,DeviceParameters-><|"J01"->2*10^-9,"J02"->1*10^-6,"Rs"->0.006*0.0245,"Rsh"->8*0.0245|>,DeviceQE->EQE["PERC"],MetalCoverage->0.03};


(* ::Section::Closed:: *)
(*Tandem cell/module models*)


(* ::Text:: *)
(*Currently tandem models do not support changing of individual cell properties like device area. *)


(* --------------- two terminal -------------- *)

If[ Not@ValueQ[TwoTer2J::usage],
TwoTer2J::usage = "Tandem two-terminal model. \
TwoTer2J[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoTer2J[spec, T, \"mpp\"] calculates the current and voltage at the MPP point. \
Default options: {MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE[\"sample GS2T_top\"],EQE[\"sample GS2T_bot\"]},SubCells->{parameters[\"Alta\"],parameters[\"Kaneka_HJ-IBC\"]},CouplingEfficiency->0.51}"]

Options[TwoTer2J]={MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE["sample GS2T_top"],EQE["sample GS2T_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.51,RearIllumination->None};

If[ Not@ValueQ[TwoTer$GaAsSi::usage],
TwoTer$GaAsSi::usage = "Tandem two-terminal GaAs on Si model. \
TwoTer$GaAsSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoTer$GaAsSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[TwoTer$GaAsSi]={SubQE->{EQE["sample GS2T_top"],EQE["sample GS2T_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.51};

If[ Not@ValueQ[TwoTer$InGaPSi::usage],
TwoTer$InGaPSi::usage = "Tandem two-terminal InGaP on Si model. \
TwoTer$InGaPSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoTer$InGaPSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[TwoTer$InGaPSi]={SubQE->{EQE["sample InS2T_top"],EQE["sample InS2T_bot"]},SubCells->{parameters["Sample InGaP"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5};

If[ Not@ValueQ[TwoTer$InGapGaAsSi::usage],
TwoTer$InGapGaAsSi::usage = "Tandem two-terminal InGaP/GaAs on Si model. \
TwoTer$InGapGaAsSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoTer$InGapGaAsSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[TwoTer$InGapGaAsSi]={SubQE->{EQE["InGS Cariou2016_top"],EQE["InGS Cariou2016_mid"],EQE["InGS Cariou2016_bot"]},SubCells->{parameters["Sample InGaP"],parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->{0.5,0.5}};

If[ Not@ValueQ[TwoTer$2DiodePerovskiteSi::usage],
TwoTer$2DiodePerovskiteSi::usage = "Tandem two-terminal perovskite on Si model (perovskite top cell is two-diode model). \
TwoTer$2DiodePerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoTer$2DiodePerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[TwoTer$2DiodePerovskiteSi]={SubQE->{EQE["PS Sahli2018_top"],EQE["PS Sahli2018_bot"]},SubCells->{parameters["perovskite_Yang2015"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0};

If[ Not@ValueQ[TwoTer$PerovskiteSi::usage],
TwoTer$PerovskiteSi::usage = "Tandem two-terminal perovskite on Si model (perovskite top cell is physics-based model). \
TwoTer$PerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
TwoTer$PerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[TwoTer$PerovskiteSi]={SubQE->{EQE["PS Sahli2018_top"],EQE["PS Sahli2018_bot"]},SubCells->{parameters["perovskite_nip_Yang2017b"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0};

(* --------------- four terminal -------------- *)

If[ Not@ValueQ[FourTer2J::usage],
FourTer2J::usage = "Tandem dual junction four-terminal model. \
FourTer2J[spec, T] calculates the full IV curve under the given spectrum and temperature. Default options: {MaterialSystem\[Rule]{GaAsCell,SiCell},SubQE->{EQE[\"GS_Essig2017_top\"],EQE[\"GS_Essig2017_bot\"]}, \
SubCells->{parameters[\"Alta\"],parameters[\"Kaneka_HJ-IBC\"]},CouplingEfficiency->0.51}"]

Options[FourTer2J]={MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.51,RearIllumination->None};

If[ Not@ValueQ[FourTer$GaAsSi::usage],
FourTer$GaAsSi::usage = "Tandem four-terminal GaAs on Si model. \
FourTer$GaAsSi[spec, T] calculates the full IV curve under the given spectrum and temperature."]

Options[FourTer$GaAsSi]={SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.51};

If[ Not@ValueQ[FourTer$InGaPSi::usage],
FourTer$InGaPSi::usage = "Tandem four-terminal InGaP on Si model. \
FourTer$InGaPSi[spec, T] calculates the full IV curve under the given spectrum and temperature."]

Options[FourTer$InGaPSi]={SubQE->{EQE["InS_Essig2017_top"],EQE["InS_Essig2017_bot"]},SubCells->{parameters["Sample InGaP"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5};

If[ Not@ValueQ[FourTer$2DiodePerovskiteSi::usage],
FourTer$2DiodePerovskiteSi::usage = "Tandem four-terminal perovskite on Si model (perovskite top cell is two-diode model). \
FourTer$2DiodePerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature."]

Options[FourTer$2DiodePerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"]},SubCells->{parameters["perovskite_Yang2015"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0};

If[ Not@ValueQ[FourTer$PerovskiteSi::usage],
FourTer$PerovskiteSi::usage = "Tandem four-terminal perovskite on Si model (perovskite top cell is physics-based model). \
FourTer$PerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature."]

Options[FourTer$PerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"]},SubCells->{parameters["perovskite_nip_Yang2017b"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0};

(* --------------- Mechanical Voltage Match -------------- *)

If[ Not@ValueQ[VMatch2J::usage],
VMatch2J::usage = "Tandem (mechanically) voltage matched model. \
VMatch2J[spec, T] calculates the full IV curve under the given spectrum and temperature. \
VMatch2J[spec, T, \"mpp\"] calculates the current and voltage at the MPP point. Default options: {MaterialSystem\[Rule]{GaAsCell,SiCell},\
SubQE->{EQE[\"GS_Essig2017_top\"],EQE[\"GS_Essig2017_bot\"]},SubCells->{parameters[\"Alta\"],parameters[\"Kaneka_HJ-IBC\"]},CouplingEfficiency->0.5,StringNumber->{10,17}}"]

Options[VMatch2J]={MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,StringNumber->{10,17},RearIllumination->None};

If[ Not@ValueQ[VMatch$GaAsSi::usage],
VMatch$GaAsSi::usage = "Tandem (mechanically) voltage matched GaAs on Si model. \
VMatch$GaAsSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
VMatch$GaAsSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[VMatch$GaAsSi]={SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,StringNumber->{10,17}};

If[ Not@ValueQ[VMatch$InGaPSi::usage],
VMatch$InGaPSi::usage = "Tandem (mechanically) voltage matched InGaP on Si model. \
VMatch$InGaPSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
VMatch$InGaPSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[VMatch$InGaPSi]={SubQE->{EQE["InS_Essig2017_top"],EQE["InS_Essig2017_bot"]},SubCells->{parameters["Sample InGaP"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,StringNumber->{10,21}};

If[ Not@ValueQ[VMatch$2DiodePerovskiteSi::usage],
VMatch$2DiodePerovskiteSi::usage = "Tandem (mechanically) voltage matched perovskite on Si model (perovskite top cell is two-diode model). \
VMatch$2DiodePerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
VMatch$2DiodePerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[VMatch$2DiodePerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"]},SubCells->{parameters["perovskite_Yang2015"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0,StringNumber->{5,7}};

If[ Not@ValueQ[VMatch$PerovskiteSi::usage],
VMatch$PerovskiteSi::usage = "Tandem (mechanically) voltage matched perovskite on Si model (perovskite top cell is physics-based model). \
VMatch$PerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
VMatch$PerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[VMatch$PerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"]},SubCells->{parameters["perovskite_nip_Yang2017b"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0,StringNumber->{2,3}};

(* --------------- three terminal -------------- *)

If[ Not@ValueQ[ThreeTer2J::usage],
ThreeTer2J::usage = "Tandem three-terminal model. \
ThreeTer2J[spec, T] calculates the full IV curve under the given spectrum and temperature. \
ThreeTer2J[spec, T, \"mpp\"] calculates the current and voltage at the MPP point. Default options: {MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE[\"GS_Essig2017_top\"],EQE[\"GS_Essig2017_bot\"]},\
SubCells->{parameters[\"Alta\"],parameters[\"Kaneka_HJ-IBC\"]},CouplingEfficiency->0.5,StringNumber->{1,2}}"]

Options[ThreeTer2J]={MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,StringNumber->{1,2},RearIllumination->None};

If[ Not@ValueQ[ThreeTer$GaAsSi::usage],
ThreeTer$GaAsSi::usage = "Tandem three-terminal GaAs on Si model. \
ThreeTer$GaAsSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
ThreeTer$GaAsSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[ThreeTer$GaAsSi]={SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"]},CouplingEfficiency->0.5,StringNumber->{1,2}};

If[ Not@ValueQ[ThreeTer$InGaPSi::usage],
ThreeTer$InGaPSi::usage = "Tandem three-terminal InGaP on Si model. \
ThreeTer$InGaPSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
ThreeTer$InGaPSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[ThreeTer$InGaPSi]={SubQE->{EQE["InS_Essig2017_top"],EQE["InS_Essig2017_bot"]},CouplingEfficiency->0.5,StringNumber->{1,2}};

If[ Not@ValueQ[ThreeTer$2DiodePerovskiteSi::usage],
ThreeTer$2DiodePerovskiteSi::usage = "Tandem three-terminal perovskite on Si model (perovskite top cell is two-diode model). \
ThreeTer$2DiodePerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
ThreeTer$2DiodePerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[ThreeTer$2DiodePerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"]},SubCells->{parameters["perovskite_Yang2015"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0,StringNumber->{1,2}};

If[ Not@ValueQ[ThreeTer$PerovskiteSi::usage],
ThreeTer$PerovskiteSi::usage = "Tandem three-terminal perovskite on Si model (perovskite top cell is physics-based model). \
ThreeTer$PerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
ThreeTer$PerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[ThreeTer$PerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"]},SubCells->{parameters["perovskite_nip_Yang2017b"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0,StringNumber->{1,2}};

(* --------------- areal matched -------------- *)

If[ Not@ValueQ[AMatch2J::usage],
AMatch2J::usage = "Tandem areal matched model. \
AMatch2J[spec, T] calculates the full IV curve under the given spectrum and temperature. 
Default options: MaterialSystem->{GaAsCell,SiCell}, {SubQE->{EQE[\"GS_Essig2017_top\"],EQE[\"GS_Essig2017_bot\"],EQE[\"Kaneka_HJ-IBC\"]},\
SubCells->{parameters[\"Alta\"],parameters[\"Kaneka_HJ-IBC\"]},CouplingEfficiency->0.5,AreaRatio->0.7}"]

Options[AMatch2J]={MaterialSystem->{GaAsCell,SiCell},SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"],EQE["Kaneka_HJ-IBC"]},SubCells->{parameters["Alta"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,AreaRatio->0.7,RearIllumination->None};

If[ Not@ValueQ[AMatch$GaAsSi::usage],
AMatch$GaAsSi::usage = "Tandem areal matched GaAs on Si model. \
AMatch$GaAsSi[spec, T] calculates the full IV curve under the given spectrum and temperature."]

Options[AMatch$GaAsSi]={SubQE->{EQE["GS_Essig2017_top"],EQE["GS_Essig2017_bot"],EQE["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,AreaRatio->0.7};

If[ Not@ValueQ[AMatch$InGaPSi::usage],
AMatch$InGaPSi::usage = "Tandem areal matched InGaP on Si model. \
AMatch$InGaPSi[spec, T] calculates the full IV curve under the given spectrum and temperature."]

Options[AMatch$InGaPSi]={SubQE->{EQE["sample InS2T_top"],EQE["sample InS2T_bot"]},SubCells->{parameters["Sample InGaP"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0.5,AreaRatio->1};

If[ Not@ValueQ[AMatch$2DiodePerovskiteSi::usage],
AMatch$2DiodePerovskiteSi::usage = "Tandem areal matched perovskite on Si model (perovskite top cell is two-diode model). \
AMatch$2DiodePerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
AMatch$2DiodePerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[AMatch$2DiodePerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"],EQE["Kaneka_HJ-IBC"]},SubCells->{parameters["perovskite_Yang2015"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0,AreaRatio->0.93};

If[ Not@ValueQ[AMatch$PerovskiteSi::usage],
AMatch$PerovskiteSi::usage = "Tandem areal matched perovskite on Si model (perovskite top cell is physics-based model). \
AMatch$PerovskiteSi[spec, T] calculates the full IV curve under the given spectrum and temperature. \
AMatch$PerovskiteSi[spec, T, \"mpp\"] calculates the current and voltage at the MPP point."]

Options[AMatch$PerovskiteSi]={SubQE->{EQE["PS Werner2016_top"],EQE["PS Werner2016_bot"],EQE["Kaneka_HJ-IBC"]},SubCells->{parameters["perovskite_nip_Yang2017b"],parameters["Kaneka_HJ-IBC"]},CouplingEfficiency->0,AreaRatio->0.95};


(* ::Section::Closed:: *)
(*Others*)


If[ Not@ValueQ[TemperatureCoeff::usage],
TemperatureCoeff::usage = "TemperatureCoeff[spec, device] determines the temperature coefficient of {Isc, Voc, Pmpp}, for a given device model under a certain spectrum."]

If[ Not@ValueQ[CalcJsc::usage],
CalcJsc::usage = "CalcJsc[spec_,QE_,cellArea_:1.,metalCoverage_:0.] calculate raw Jsc without temperature correction or luminescent coupling."]


(* ::Chapter::Closed:: *)
(*Parameters Library*)


(* ::Text:: *)
(*QE range from 1 to 100, indicating %. *)
(*STC parameters are all in SI unit. *)


EQE=.;
IQE=.;
parameters=.;


(* ::Text:: *)
(*AM1.5G solar spectrum: *)


specAM15G={{280.,4.7309*10^-23},{280.5,1.2307*10^-21},{281.,5.6895*10^-21},{281.5,1.5662*10^-19},{282.,1.1946*10^-18},{282.5,4.5436*10^-18},{283.,1.8452*10^-17},{283.5,3.536*10^-17},{284.,7.267*10^-16},{284.5,2.4856*10^-15},{285.,8.0142*10^-15},{285.5,4.2613*10^-14},{286.,1.3684*10^-13},{286.5,8.3823*10^-13},{287.,2.7367*10^-12},{287.5,1.0903*10^-11},{288.,6.2337*10^-11},{288.5,1.7162*10^-10},{289.,5.6265*10^-10},{289.5,2.0749*10^-9},{290.,6.0168*10^-9},{290.5,1.3783*10^-8},{291.,3.5052*10^-8},{291.5,1.0913*10^-7},{292.,2.683*10^-7},{292.5,4.2685*10^-7},{293.,8.6466*10^-7},{293.5,2.2707*10^-6},{294.,4.1744*10^-6},{294.5,6.5911*10^-6},{295.,0.00001229},{295.5,0.000027826},{296.,0.000047904},{296.5,0.000071345},{297.,0.0000968},{297.5,0.00018608},{298.,0.00028988},{298.5,0.00035789},{299.,0.00049211},{299.5,0.00086068},{300.,0.0010205},{300.5,0.001245},{301.,0.00193},{301.5,0.0026914},{302.,0.0029209},{302.5,0.004284},{303.,0.0070945},{303.5,0.0089795},{304.,0.0094701},{304.5,0.011953},{305.,0.016463},{305.5,0.018719},{306.,0.018577},{306.5,0.021108},{307.,0.027849},{307.5,0.035635},{308.,0.037837},{308.5,0.04143},{309.,0.040534},{309.5,0.043306},{310.,0.050939},{310.5,0.06554},{311.,0.082922},{311.5,0.08408},{312.,0.093376},{312.5,0.098984},{313.,0.10733},{313.5,0.10757},{314.,0.11969},{314.5,0.1306},{315.,0.13625},{315.5,0.11838},{316.,0.12348},{316.5,0.15036},{317.,0.17158},{317.5,0.18245},{318.,0.17594},{318.5,0.18591},{319.,0.2047},{319.5,0.19589},{320.,0.20527},{320.5,0.24525},{321.,0.25024},{321.5,0.23843},{322.,0.22203},{322.5,0.21709},{323.,0.21226},{323.5,0.24861},{324.,0.27537},{324.5,0.28321},{325.,0.27894},{325.5,0.32436},{326.,0.3812},{326.5,0.40722},{327.,0.39806},{327.5,0.38465},{328.,0.35116},{328.5,0.37164},{329.,0.42235},{329.5,0.46878},{330.,0.47139},{330.5,0.428},{331.,0.40262},{331.5,0.41806},{332.,0.43623},{332.5,0.43919},{333.,0.42944},{333.5,0.40724},{334.,0.41497},{334.5,0.44509},{335.,0.46388},{335.5,0.45313},{336.,0.41519},{336.5,0.38214},{337.,0.3738},{337.5,0.40051},{338.,0.43411},{338.5,0.45527},{339.,0.46355},{339.5,0.47446},{340.,0.5018},{340.5,0.50071},{341.,0.47139},{341.5,0.46935},{342.,0.48934},{342.5,0.50767},{343.,0.51489},{343.5,0.48609},{344.,0.41843},{344.5,0.40307},{345.,0.45898},{345.5,0.48932},{346.,0.47778},{346.5,0.48657},{347.,0.49404},{347.5,0.47674},{348.,0.47511},{348.5,0.48336},{349.,0.46564},{349.5,0.47805},{350.,0.52798},{350.5,0.56741},{351.,0.55172},{351.5,0.53022},{352.,0.51791},{352.5,0.48962},{353.,0.5204},{353.5,0.57228},{354.,0.60498},{354.5,0.61156},{355.,0.6114},{355.5,0.59028},{356.,0.55387},{356.5,0.51942},{357.,0.45673},{357.5,0.46215},{358.,0.43006},{358.5,0.39926},{359.,0.46953},{359.5,0.56549},{360.,0.59817},{360.5,0.56531},{361.,0.52024},{361.5,0.50956},{362.,0.5342},{362.5,0.5851},{363.,0.60191},{363.5,0.58541},{364.,0.60628},{364.5,0.60058},{365.,0.62359},{365.5,0.68628},{366.,0.73532},{366.5,0.73658},{367.,0.72285},{367.5,0.70914},{368.,0.66759},{368.5,0.6631},{369.,0.69315},{369.5,0.74469},{370.,0.75507},{370.5,0.68261},{371.,0.69338},{371.5,0.72051},{372.,0.67444},{372.5,0.64253},{373.,0.61886},{373.5,0.55786},{374.,0.5564},{374.5,0.55227},{375.,0.5893},{375.5,0.65162},{376.,0.6748},{376.5,0.6639},{377.,0.71225},{377.5,0.79455},{378.,0.85595},{378.5,0.83418},{379.,0.74389},{379.5,0.66683},{380.,0.70077},{380.5,0.75075},{381.,0.76383},{381.5,0.68837},{382.,0.58678},{382.5,0.50762},{383.,0.45499},{383.5,0.44049},{384.,0.50968},{384.5,0.61359},{385.,0.67355},{385.5,0.64363},{386.,0.621},{386.5,0.6457},{387.,0.65147},{387.5,0.64204},{388.,0.63582},{388.5,0.63136},{389.,0.68543},{389.5,0.7597},{390.,0.79699},{390.5,0.80371},{391.,0.85138},{391.5,0.86344},{392.,0.79493},{392.5,0.66257},{393.,0.47975},{393.5,0.38152},{394.,0.49567},{394.5,0.68385},{395.,0.80772},{395.5,0.86038},{396.,0.75655},{396.5,0.55017},{397.,0.42619},{397.5,0.62945},{398.,0.85249},{398.5,1.0069},{399.,1.0693},{399.5,1.1021},
{400.,1.1141},{401.,1.1603},{402.,1.2061},{403.,1.1613},{404.,1.1801},{405.,1.1511},{406.,1.1227},{407.,1.1026},{408.,1.1514},{409.,1.2299},{410.,1.0485},{411.,1.1738},{412.,1.2478},{413.,1.1971},{414.,1.1842},{415.,1.2258},{416.,1.2624},{417.,1.2312},{418.,1.1777},{419.,1.2258},{420.,1.1232},{421.,1.2757},{422.,1.2583},{423.,1.2184},{424.,1.2117},{425.,1.2488},{426.,1.2135},{427.,1.1724},{428.,1.1839},{429.,1.0963},{430.,0.87462},{431.,0.79394},{432.,1.3207},{433.,1.2288},{434.,1.1352},{435.,1.2452},{436.,1.3659},{437.,1.3943},{438.,1.2238},{439.,1.1775},{440.,1.3499},{441.,1.3313},{442.,1.425},{443.,1.4453},{444.,1.4084},{445.,1.4619},{446.,1.3108},{447.,1.4903},{448.,1.5081},{449.,1.5045},{450.,1.5595},{451.,1.6173},{452.,1.5482},{453.,1.4297},{454.,1.5335},{455.,1.5224},{456.,1.5724},{457.,1.5854},{458.,1.5514},{459.,1.5391},{460.,1.5291},{461.,1.5827},{462.,1.5975},{463.,1.6031},{464.,1.5544},{465.,1.535},{466.,1.5673},{467.,1.4973},{468.,1.5619},{469.,1.5682},{470.,1.5077},{471.,1.5331},{472.,1.6126},{473.,1.5499},{474.,1.5671},{475.,1.6185},{476.,1.5631},{477.,1.5724},{478.,1.623},{479.,1.5916},{480.,1.6181},{481.,1.6177},{482.,1.6236},{483.,1.6038},{484.,1.5734},{485.,1.5683},{486.,1.2716},{487.,1.4241},{488.,1.5413},{489.,1.4519},{490.,1.6224},{491.,1.5595},{492.,1.4869},{493.,1.5903},{494.,1.5525},{495.,1.6485},{496.,1.5676},{497.,1.5944},{498.,1.5509},{499.,1.5507},{500.,1.5451},{501.,1.4978},{502.,1.4966},{503.,1.5653},{504.,1.4587},{505.,1.5635},{506.,1.6264},{507.,1.556},{508.,1.5165},{509.,1.5893},{510.,1.5481},{511.,1.5769},{512.,1.6186},{513.,1.5206},{514.,1.4885},{515.,1.5314},{516.,1.5455},{517.,1.2594},{518.,1.4403},{519.,1.3957},{520.,1.5236},{521.,1.5346},{522.,1.569},{523.,1.4789},{524.,1.5905},{525.,1.5781},{526.,1.5341},{527.,1.3417},{528.,1.5357},{529.,1.6071},{530.,1.5446},{531.,1.6292},{532.,1.5998},{533.,1.4286},{534.,1.5302},{535.,1.5535},{536.,1.6199},{537.,1.4989},{538.,1.5738},{539.,1.5352},{540.,1.4825},{541.,1.4251},{542.,1.5511},{543.,1.5256},{544.,1.5792},{545.,1.5435},{546.,1.5291},{547.,1.549},{548.,1.5049},{549.,1.552},{550.,1.5399},{551.,1.5382},{552.,1.5697},{553.,1.525},{554.,1.5549},{555.,1.5634},{556.,1.5366},{557.,1.4988},{558.,1.531},{559.,1.4483},{560.,1.474},{561.,1.5595},{562.,1.4847},{563.,1.5408},{564.,1.5106},{565.,1.5201},{566.,1.4374},{567.,1.532},{568.,1.518},{569.,1.4807},{570.,1.4816},{571.,1.4331},{572.,1.5134},{573.,1.5198},{574.,1.5119},{575.,1.4777},{576.,1.4654},{577.,1.5023},{578.,1.456},{579.,1.477},{580.,1.502},{581.,1.5089},{582.,1.532},{583.,1.5479},{584.,1.5448},{585.,1.5324},{586.,1.4953},{587.,1.5281},{588.,1.4934},{589.,1.2894},{590.,1.3709},{591.,1.4662},{592.,1.4354},{593.,1.4561},{594.,1.4491},{595.,1.4308},{596.,1.4745},{597.,1.4788},{598.,1.4607},{599.,1.4606},{600.,1.4753},{601.,1.4579},{602.,1.436},{603.,1.4664},{604.,1.4921},{605.,1.4895},{606.,1.4822},{607.,1.4911},{608.,1.4862},{609.,1.4749},{610.,1.4686},{611.,1.4611},{612.,1.4831},{613.,1.4621},{614.,1.4176},{615.,1.4697},{616.,1.431},{617.,1.4128},{618.,1.4664},{619.,1.4733},{620.,1.4739},{621.,1.4802},{622.,1.4269},{623.,1.4165},{624.,1.4118},{625.,1.4026},{626.,1.4012},{627.,1.4417},{628.,1.3631},{629.,1.4114},{630.,1.3924},{631.,1.4161},{632.,1.3638},{633.,1.4508},{634.,1.4284},{635.,1.4458},{636.,1.4128},{637.,1.461},{638.,1.4707},{639.,1.4646},{640.,1.434},{641.,1.4348},{642.,1.4376},{643.,1.4525},{644.,1.4462},{645.,1.4567},{646.,1.415},{647.,1.4086},{648.,1.3952},{649.,1.3519},{650.,1.3594},{651.,1.4447},{652.,1.3871},{653.,1.4311},{654.,1.4153},{655.,1.3499},{656.,1.1851},{657.,1.2393},{658.,1.3855},{659.,1.3905},{660.,1.3992},{661.,1.3933},{662.,1.3819},{663.,1.3844},{664.,1.3967},{665.,1.4214},{666.,1.4203},{667.,1.4102},{668.,1.415},{669.,1.4394},{670.,1.4196},{671.,1.4169},{672.,1.3972},{673.,1.4094},{674.,1.4074},{675.,1.3958},{676.,1.412},{677.,1.3991},{678.,1.4066},{679.,1.3947},{680.,1.3969},{681.,1.3915},{682.,1.3981},{683.,1.383},{684.,1.3739},{685.,1.3748},{686.,1.3438},{687.,0.96824},{688.,1.1206},{689.,1.1278},{690.,1.1821},{691.,1.2333},{692.,1.2689},{693.,1.2609},{694.,1.2464},{695.,1.2714},{696.,1.2684},{697.,1.3403},{698.,1.3192},{699.,1.2918},
{700.,1.2823},{701.,1.2659},{702.,1.2674},{703.,1.2747},{704.,1.3078},{705.,1.3214},{706.,1.3144},{707.,1.309},{708.,1.3048},{709.,1.3095},{710.,1.3175},{711.,1.3155},{712.,1.3071},{713.,1.2918},{714.,1.3029},{715.,1.2587},{716.,1.2716},{717.,1.1071},{718.,1.0296},{719.,0.92318},{720.,0.9855},{721.,1.0861},{722.,1.2407},{723.,1.1444},{724.,1.0555},{725.,1.038},{726.,1.0813},{727.,1.085},{728.,1.04},{729.,1.0466},{730.,1.1285},{731.,1.0703},{732.,1.1534},{733.,1.1962},{734.,1.2357},{735.,1.2178},{736.,1.2059},{737.,1.2039},{738.,1.2269},{739.,1.1905},{740.,1.2195},{741.,1.2148},{742.,1.2153},{743.,1.2405},{744.,1.2503},{745.,1.2497},{746.,1.247},{747.,1.2477},{748.,1.2401},{749.,1.2357},{750.,1.2341},{751.,1.2286},{752.,1.233},{753.,1.2266},{754.,1.242},{755.,1.2383},{756.,1.2232},{757.,1.2221},{758.,1.2295},{759.,1.1945},{760.,0.26604},{761.,0.15396},{762.,0.68766},{763.,0.37952},{764.,0.53878},{765.,0.68601},{766.,0.81461},{767.,0.97417},{768.,1.1138},{769.,1.1278},{770.,1.1608},{771.,1.1686},{772.,1.1778},{773.,1.1771},{774.,1.1771},{775.,1.1771},{776.,1.1798},{777.,1.1727},{778.,1.1713},{779.,1.1765},{780.,1.1636},{781.,1.1607},{782.,1.1662},{783.,1.1614},{784.,1.1536},{785.,1.1586},{786.,1.1592},{787.,1.145},{788.,1.1305},{789.,1.1257},{790.,1.091},{791.,1.1058},{792.,1.0953},{793.,1.0875},{794.,1.0972},{795.,1.0932},{796.,1.0742},{797.,1.0913},{798.,1.1121},{799.,1.0905},{800.,1.0725},{801.,1.0843},{802.,1.0856},{803.,1.0657},{804.,1.0782},{805.,1.0545},{806.,1.0974},{807.,1.0859},{808.,1.0821},{809.,1.0548},{810.,1.0559},{811.,1.0533},{812.,1.0268},{813.,1.0086},{814.,0.90356},{815.,0.89523},{816.,0.83216},{817.,0.85183},{818.,0.82259},{819.,0.90519},{820.,0.86188},{821.,0.99764},{822.,0.95157},{823.,0.67271},{824.,0.93506},{825.,0.96935},{826.,0.93381},{827.,0.98465},{828.,0.84979},{829.,0.9293},{830.,0.91601},{831.,0.92392},{832.,0.89426},{833.,0.9565},{834.,0.93412},{835.,1.0032},{836.,0.97234},{837.,1.0092},{838.,0.99901},{839.,1.0013},{840.,1.0157},{841.,1.0101},{842.,0.99703},{843.,1.0053},{844.,0.98631},{845.,1.0165},{846.,1.0187},{847.,0.9917},{848.,0.99217},{849.,0.98596},{850.,0.89372},{851.,0.97493},{852.,0.96927},{853.,0.96486},{854.,0.85112},{855.,0.913},{856.,0.97317},{857.,0.99166},{858.,0.99196},{859.,0.99171},{860.,0.98816},{861.,0.98679},{862.,0.99449},{863.,1.0005},{864.,0.97916},{865.,0.96324},{866.,0.849},{867.,0.91546},{868.,0.9592},{869.,0.94956},{870.,0.96755},{871.,0.95387},{872.,0.96686},{873.,0.95721},{874.,0.94042},{875.,0.92687},{876.,0.95277},{877.,0.95615},{878.,0.95237},{879.,0.93656},{880.,0.93957},{881.,0.90861},{882.,0.93245},{883.,0.92927},{884.,0.93305},{885.,0.94423},{886.,0.90752},{887.,0.91062},{888.,0.92228},{889.,0.93455},{890.,0.92393},{891.,0.92584},{892.,0.90881},{893.,0.87327},{894.,0.8513},{895.,0.81357},{896.,0.76253},{897.,0.66566},{898.,0.7178},{899.,0.54871},{900.,0.7426},{901.,0.59933},{902.,0.66791},{903.,0.68889},{904.,0.84457},{905.,0.81709},{906.,0.77558},{907.,0.63854},{908.,0.65217},{909.,0.70431},{910.,0.62467},{911.,0.66808},{912.,0.68893},{913.,0.62834},{914.,0.62649},{915.,0.67836},{916.,0.57646},{917.,0.73017},{918.,0.59271},{919.,0.73877},{920.,0.74414},{921.,0.78049},{922.,0.70026},{923.,0.74504},{924.,0.7215},{925.,0.7111},{926.,0.70331},{927.,0.78742},{928.,0.58968},{929.,0.55127},{930.,0.4321},{931.,0.40921},{932.,0.30086},{933.,0.24841},{934.,0.1438},{935.,0.25084},{936.,0.16142},{937.,0.16338},{938.,0.20058},{939.,0.39887},{940.,0.47181},{941.,0.37195},{942.,0.40532},{943.,0.27834},{944.,0.28579},{945.,0.36821},{946.,0.19461},{947.,0.37112},{948.,0.27423},{949.,0.49396},{950.,0.14726},{951.,0.48378},{952.,0.26891},{953.,0.34362},{954.,0.42411},{955.,0.34117},{956.,0.32821},{957.,0.27067},{958.,0.46101},{959.,0.37385},{960.,0.42066},{961.,0.4612},{962.,0.44174},{963.,0.50503},{964.,0.4586},{965.,0.50374},{966.,0.50275},{967.,0.5024},{968.,0.6521},{969.,0.68622},{970.,0.63461},{971.,0.71397},{972.,0.68765},{973.,0.60648},{974.,0.57529},{975.,0.58987},{976.,0.57191},{977.,0.63864},{978.,0.61509},{979.,0.63815},{980.,0.60468},{981.,0.71338},{982.,0.69218},{983.,0.66865},{984.,0.73732},{985.,0.68817},{986.,0.75083},{987.,0.73928},{988.,0.73462},{989.,0.74906},{990.,0.73227},{991.,0.75358},{992.,0.75102},{993.,0.73728},{994.,0.7541},{995.,0.75176},{996.,0.74884},{997.,0.73971},{998.,0.73887},{999.,0.73857},
{1000.,0.73532},{1001.,0.74442},{1002.,0.72805},{1003.,0.73442},{1004.,0.72336},{1005.,0.68174},{1006.,0.71252},{1007.,0.72753},{1008.,0.72685},{1009.,0.71972},{1010.,0.71914},{1011.,0.72278},{1012.,0.71877},{1013.,0.71761},{1014.,0.72068},{1015.,0.70817},{1016.,0.71129},{1017.,0.70337},{1018.,0.71422},{1019.,0.68878},{1020.,0.69896},{1021.,0.70175},{1022.,0.6897},{1023.,0.69508},{1024.,0.69058},{1025.,0.69753},{1026.,0.69636},{1027.,0.69305},{1028.,0.69385},{1029.,0.68628},{1030.,0.69055},{1031.,0.68736},{1032.,0.68787},{1033.,0.67613},{1034.,0.68015},{1035.,0.68234},{1036.,0.68202},{1037.,0.67497},{1038.,0.67172},{1039.,0.67636},{1040.,0.6717},{1041.,0.67176},{1042.,0.672},{1043.,0.66525},{1044.,0.66833},{1045.,0.66452},{1046.,0.64714},{1047.,0.65694},{1048.,0.66274},{1049.,0.65896},{1050.,0.65463},{1051.,0.65521},{1052.,0.65118},{1053.,0.64919},{1054.,0.64646},{1055.,0.64847},{1056.,0.64641},{1057.,0.64482},{1058.,0.63818},{1059.,0.61875},{1060.,0.63585},{1061.,0.62121},{1062.,0.63266},{1063.,0.62239},{1064.,0.63196},{1065.,0.62913},{1066.,0.61713},{1067.,0.62032},{1068.,0.61944},{1069.,0.58626},{1070.,0.60469},{1071.,0.61661},{1072.,0.61536},{1073.,0.60363},{1074.,0.62158},{1075.,0.59252},{1076.,0.61471},{1077.,0.60434},{1078.,0.60321},{1079.,0.60474},{1080.,0.59722},{1081.,0.58083},{1082.,0.5894},{1083.,0.59814},{1084.,0.57852},{1085.,0.5933},{1086.,0.5541},{1087.,0.56697},{1088.,0.59317},{1089.,0.57919},{1090.,0.55573},{1091.,0.58835},{1092.,0.58124},{1093.,0.51058},{1094.,0.53965},{1095.,0.52067},{1096.,0.50323},{1097.,0.57852},{1098.,0.50291},{1099.,0.50772},{1100.,0.48577},{1101.,0.49696},{1102.,0.46883},{1103.,0.46637},{1104.,0.46765},{1105.,0.50644},{1106.,0.39792},{1107.,0.48304},{1108.,0.41565},{1109.,0.41278},{1110.,0.47899},{1111.,0.33154},{1112.,0.41357},{1113.,0.2685},{1114.,0.29985},{1115.,0.24987},{1116.,0.20136},{1117.,0.079618},{1118.,0.21753},{1119.,0.11317},{1120.,0.14189},{1121.,0.18586},{1122.,0.081686},{1123.,0.12817},{1124.,0.1087},{1125.,0.14428},{1126.,0.051589},{1127.,0.15725},{1128.,0.099224},{1129.,0.10591},{1130.,0.070574},{1131.,0.2956},{1132.,0.23411},{1133.,0.15331},{1134.,0.04174},{1135.,0.015462},{1136.,0.12876},{1137.,0.28785},{1138.,0.20329},{1139.,0.2985},{1140.,0.25599},{1141.,0.19337},{1142.,0.22479},{1143.,0.31183},{1144.,0.11326},{1145.,0.14604},{1146.,0.15764},{1147.,0.059176},{1148.,0.27113},{1149.,0.21854},{1150.,0.12164},{1151.,0.2034},{1152.,0.24762},{1153.,0.23812},{1154.,0.14248},{1155.,0.31316},{1156.,0.2809},{1157.,0.31458},{1158.,0.31171},{1159.,0.33693},{1160.,0.28648},{1161.,0.34753},{1162.,0.35002},{1163.,0.46857},{1164.,0.40188},{1165.,0.3886},{1166.,0.37494},{1167.,0.40996},{1168.,0.41954},{1169.,0.4231},{1170.,0.45873},{1171.,0.44831},{1172.,0.45483},{1173.,0.45642},{1174.,0.33692},{1175.,0.4524},{1176.,0.47679},{1177.,0.47235},{1178.,0.36},{1179.,0.48371},{1180.,0.44069},{1181.,0.45514},{1182.,0.32318},{1183.,0.4387},{1184.,0.41985},{1185.,0.40741},{1186.,0.47715},{1187.,0.45575},{1188.,0.33504},{1189.,0.41569},{1190.,0.46239},{1191.,0.4466},{1192.,0.47336},{1193.,0.45434},{1194.,0.4689},{1195.,0.44696},{1196.,0.43131},{1197.,0.47715},{1198.,0.43392},{1199.,0.36489},{1200.,0.44825},{1201.,0.43708},{1202.,0.43717},{1203.,0.43409},{1204.,0.36247},{1205.,0.43692},{1206.,0.48086},{1207.,0.42986},{1208.,0.43346},{1209.,0.41428},{1210.,0.45336},{1211.,0.42232},{1212.,0.42489},{1213.,0.46956},{1214.,0.43407},{1215.,0.4278},{1216.,0.4664},{1217.,0.45528},{1218.,0.45934},{1219.,0.44663},{1220.,0.45805},{1221.,0.46531},{1222.,0.45139},{1223.,0.44406},{1224.,0.44808},{1225.,0.46236},{1226.,0.46819},{1227.,0.43304},{1228.,0.46658},{1229.,0.46721},{1230.,0.46003},{1231.,0.47203},{1232.,0.46633},{1233.,0.45397},{1234.,0.47016},{1235.,0.46504},{1236.,0.46908},{1237.,0.46339},{1238.,0.46797},{1239.,0.46272},{1240.,0.46077},{1241.,0.46197},{1242.,0.46247},{1243.,0.45754},{1244.,0.45528},{1245.,0.45655},{1246.,0.45945},{1247.,0.45746},{1248.,0.4586},{1249.,0.45966},{1250.,0.45705},{1251.,0.45258},{1252.,0.45097},{1253.,0.44773},{1254.,0.44363},{1255.,0.4507},{1256.,0.44023},{1257.,0.43532},{1258.,0.44496},{1259.,0.42725},{1260.,0.4311},{1261.,0.41146},{1262.,0.39567},{1263.,0.40019},{1264.,0.37148},{1265.,0.3957},{1266.,0.38527},{1267.,0.38822},{1268.,0.37051},{1269.,0.24652},{1270.,0.38744},{1271.,0.40825},{1272.,0.40879},{1273.,0.40625},{1274.,0.40614},{1275.,0.41233},{1276.,0.41693},{1277.,0.42001},{1278.,0.42763},{1279.,0.42456},{1280.,0.42204},{1281.,0.41335},{1282.,0.37305},{1283.,0.40733},{1284.,0.42078},{1285.,0.42399},{1286.,0.42714},{1287.,0.42213},{1288.,0.41989},{1289.,0.40936},{1290.,0.41285},{1291.,0.41786},{1292.,0.39618},{1293.,0.41257},{1294.,0.40421},{1295.,0.40514},{1296.,0.38957},{1297.,0.3713},{1298.,0.39183},{1299.,0.40852},
{1300.,0.35312},{1301.,0.36228},{1302.,0.39181},{1303.,0.34621},{1304.,0.30062},{1305.,0.38382},{1306.,0.38453},{1307.,0.30594},{1308.,0.34696},{1309.,0.38413},{1310.,0.30114},{1311.,0.33366},{1312.,0.33337},{1313.,0.31352},{1314.,0.28833},{1315.,0.28581},{1316.,0.32419},{1317.,0.31217},{1318.,0.33328},{1319.,0.26855},{1320.,0.25872},{1321.,0.29866},{1322.,0.30217},{1323.,0.23279},{1324.,0.26249},{1325.,0.32224},{1326.,0.28051},{1327.,0.26625},{1328.,0.2345},{1329.,0.17759},{1330.,0.22923},{1331.,0.1448},{1332.,0.14579},{1333.,0.20304},{1334.,0.16925},{1335.,0.23117},{1336.,0.18348},{1337.,0.16454},{1338.,0.17804},{1339.,0.17681},{1340.,0.16831},{1341.,0.17039},{1342.,0.17798},{1343.,0.12711},{1344.,0.075645},{1345.,0.10904},{1346.,0.058186},{1347.,0.060119},{1348.,0.0047451},{1349.,0.016159},{1350.,0.016025},{1351.,0.0046298},{1352.,0.0015164},{1353.,0.000096096},{1354.,0.00029009},{1355.,3.6034*10^-6},{1356.,0.00004807},{1357.,0.000071786},{1358.,4.1948*10^-6},{1359.,7.3439*10^-7},{1360.,2.1404*10^-6},{1361.,4.8133*10^-9},{1362.,1.8076*10^-11},{1363.,3.1563*10^-6},{1364.,1.3589*10^-6},{1365.,9.0764*10^-12},{1366.,0.000012791},{1367.,4.9764*10^-6},{1368.,1.481*10^-13},{1369.,5.1667*10^-7},{1370.,2.92*10^-7},{1371.,1.9731*10^-8},{1372.,2.7498*10^-6},{1373.,0.000044401},{1374.,0.00017917},{1375.,0.00032332},{1376.,0.00025748},{1377.,0.0001227},{1378.,0.0011089},{1379.,0.000052164},{1380.,0.000081587},{1381.,2.3716*10^-6},{1382.,2.5672*10^-6},{1383.,4.4017*10^-8},{1384.,6.1689*10^-7},{1385.,2.0899*10^-6},{1386.,2.5215*10^-6},{1387.,0.00019896},{1388.,4.0262*10^-6},{1389.,0.00058098},{1390.,0.00049328},{1391.,0.00034384},{1392.,0.000023782},{1393.,0.00011586},{1394.,0.000075526},{1395.,6.7136*10^-7},{1396.,6.3215*10^-9},{1397.,0.000049057},{1398.,0.0012704},{1399.,0.00081226},{1400.,3.2466*10^-9}};


(* ::Text:: *)
(*Single junction: *)


EQE["PERC"]={{280.,0.},{300.,0},{307.847,56.5764},{319.05,58.6109},{328.942,60.681},{338.835,62.8569},{351.347,64.6997},{363.2,66.4157},{368.718,68.6159},{373.579,70.8336},{378.44,73.0514},{383.747,75.6566},{389.047,77.9122},{394.345,80.0994},{399.644,82.3094},{406.91,84.408},{416.142,86.3333},{427.345,88.3701},{441.171,90.241},{455.641,91.5132},{470.101,92.3293},{484.555,92.8884},{499.005,93.2153},{513.453,93.4676},{527.9,93.6619},{542.345,93.7981},{556.791,93.9178},{571.235,94.0042},{585.68,94.0824},{600.122,94.0777},{614.565,94.1061},{629.008,94.1014},{643.45,94.0635},{657.892,94.0422},{672.333,93.9629},{686.774,93.8669},{701.211,93.6218},{715.653,93.5839},{730.095,93.5377},{744.537,93.4832},{758.978,93.4453},{773.418,93.2913},{787.857,93.1208},{802.295,92.9005},{816.731,92.5973},{831.171,92.4516},{845.613,92.4303},{860.054,92.3426},{874.493,92.1555},{888.931,91.9269},{903.369,91.6983},{917.804,91.3702},{932.242,91.1333},{946.679,90.8882},{961.113,90.4772},{975.545,89.9335},{989.973,89.2489},{1004.4,88.3901},{1018.81,87.15},{1033.22,85.4455},{1044.34,83.5805},{1051.51,81.1977},{1058.03,78.9336},{1064.55,76.7243},{1071.72,74.6638},{1078.9,72.4877},{1084.63,70.2969},{1088.,68.3957},{1091.9,66.4183},{1095.8,64.4865},{1099.7,62.5547},{1103.59,60.5469},{1107.49,58.4327},{1111.38,56.2425},{1115.27,54.0523},{1119.16,51.8621},{1123.06,49.5959},{1126.42,47.2629},{1130.18,44.8964},{1134.06,42.2654},{1137.94,39.6192},{1141.83,37.0185},{1145.71,34.3723},{1149.59,31.7413},{1153.47,29.0342},{1157.36,26.4336},{1161.24,23.7114},{1164.99,21.202},{1167.83,18.8115},{1171.58,16.1531},{1175.34,13.5373},{1178.05,11.3475},{1184.89,9.11075},{1197.03,8.99603},{1252.5,0.},{1266.94,0.},{2000.,0.},{3000.,0.},{4000.,0.}};
parameters["PERC"]=<|"J01"->2*10^-9,"J02"->1*10^-8,"Rs"->0.9*10^-4,"Rsh"->10000*10^-4,"BreakdownFactor"->0,"BreakdownVoltage"->-5.5,"AvalancheBreakdownExponent"->3.28|>; (* STC parameters in SI unit *)
EQE["Kaneka_HJ-IBC"]={{280.,0.},{300.,70.},{310.03,81.2009},{327.605,87.035},{347.956,89.8235},{368.306,92.5303},{388.656,94.712},{409.006,96.1438},{429.356,96.7915},{449.707,96.8256},{470.057,96.7028},{493.05,96.8587},{510.757,97.4324},{530.414,97.7332},{551.458,97.5278},{571.808,97.971},{592.158,97.8073},{612.508,97.9846},{632.859,98.3596},{653.209,98.4039},{673.559,98.3801},{694.279,98.56},{745.71,98.7653},{765.32,99.01},{785.485,99.0025},{812.311,99.0993},{832.661,99.2528},{854.399,99.0457},{873.361,99.2391},{894.082,99.6513},{914.062,99.505},{934.412,98.8778},{954.762,98.8812},{976.963,98.1653},{997.313,96.7369},{1017.66,93.6484},{1034.31,90.0875},{1047.26,85.893},{1061.14,79.8776},{1066.69,75.8527},{1078.71,69.941},{1087.96,64.5412},{1097.21,59.1414},{1106.46,53.0602},{1112.94,50.8954},{1120.34,44.944},{1126.81,39.657},{1135.14,33.4466},{1142.54,27.395},{1149.94,21.9951},{1155.49,17.6078},{1162.89,12.509},{1173.06,7.07814},{1184.16,1.7371},{1200.,0.},{4000.,0.}};
parameters["Kaneka_HJ-IBC"]=<|"J01"->1*^-10,"J02"->1*^-5,"Rs"->0.32*^-4,"Rsh"->10000*^-4|>;


EQE["Alta"]={{280.,0.},{300.,0.},{308.118,0.382079},{320.927,2.27841},{324.868,6.11999},{328.81,9.86254},{332.751,13.4862},{336.692,17.0505},{341.619,23.6451},{347.531,34.9337},{349.502,38.2608},{351.472,41.3502},{353.443,45.0339},{355.414,48.361},{357.384,51.6881},{359.355,55.0152},{364.282,59.4706},{374.463,64.8753},{380.047,67.013},{385.959,69.4478},{391.871,72.655},{410.592,78.0575},{420.446,80.8675},{431.613,84.113},{445.079,87.9124},{459.859,90.9034},{479.566,91.4687},{503.87,94.0768},{532.492,94.3749},{552.48,94.7942},{574.157,95.8167},{595.835,96.2035},{617.512,96.4373},{639.189,96.464},{660.867,96.5231},{682.544,96.485},{704.221,95.8424},{725.899,96.063},{747.576,94.9985},{777.136,94.0049},{799.127,94.226},{816.549,93.0913},{840.197,90.1377},{853.006,87.4485},{864.83,80.5524},{868.772,77.2237},{871.728,69.1059},{873.698,58.8016},{875.669,48.5805},{877.64,39.6073},{879.61,29.3862},{882.566,22.849},{885.522,18.5342},{888.478,13.9341},{892.42,9.35758},{896.361,4.72163},{906.543,0.242492},{921.98,0.185307},{950.,0.},{1200.,0.},{4000.,0.}};
parameters["Alta"]=<|"J01"->6*^-17,"J02"->1*^-8,"Rs"->1*^-4,"Rsh"->10000*^-4|>; 


(* "sample InGaP" is roughly tuned to record InGaP cell of 20.8% efficiency, ref Geisz 2013 *)
IQE["Sample InGaP"]={{280.,0.},{299.,61.9061},{300.,61.7051},{301.94,61.9384},{303.88,61.9658},{305.82,61.9978},{307.76,62.0355},{309.7,62.0795},{311.64,62.1305},{313.58,62.1888},{315.52,62.255},{317.46,62.3302},{319.4,62.4151},{321.34,62.5105},{323.28,62.617},{325.22,62.7346},{327.16,62.8645},{329.1,63.0073},{331.04,63.1636},{332.98,63.3337},{334.92,63.5185},{336.86,63.7182},{338.8,63.9328},{340.74,64.1626},{342.68,64.4076},{344.62,64.6685},{346.56,64.9478},{348.5,65.2427},{350.44,65.5532},{352.38,65.8788},{354.32,66.2193},{356.26,66.5773},{358.2,66.9553},{360.14,67.3479},{362.08,67.7546},{364.02,68.1749},{365.96,68.6083},{367.9,69.0599},{369.84,69.5325},{371.78,70.0183},{373.72,70.5171},{375.66,71.0288},{377.6,71.5538},{379.54,72.0968},{381.48,72.6668},{383.42,73.2544},{385.36,73.8623},{387.3,74.4943},{389.24,75.1566},{391.18,75.8584},{393.12,76.6261},{395.06,77.4756},{397.,78.4557},{398.94,79.6926},{400.88,81.8095},{402.82,83.4783},{404.76,83.7659},{406.7,84.0514},{408.64,84.3324},{410.58,84.609},{412.52,84.8811},{414.46,85.1486},{416.4,85.4114},{418.34,85.669},{420.28,85.9215},{422.22,86.1689},{424.16,86.4113},{426.1,86.6484},{428.04,86.8802},{429.98,87.1064},{431.92,87.3243},{433.86,87.5347},{435.8,87.7396},{437.74,87.939},{439.68,88.1326},{441.62,88.3203},{443.56,88.502},{445.5,88.6754},{447.44,88.8389},{449.38,88.9969},{451.32,89.1492},{453.26,89.2957},{455.2,89.4362},{457.14,89.5706},{459.08,89.6989},{461.02,89.8177},{462.96,89.9308},{464.9,90.0386},{466.84,90.141},{468.78,90.2378},{470.72,90.329},{472.66,90.4144},{474.6,90.4942},{476.54,90.5699},{478.48,90.6408},{480.42,90.7071},{482.36,90.7685},{484.3,90.825},{486.24,90.8765},{488.18,90.9229},{490.12,90.9656},{492.06,91.0088},{494.,91.0481},{495.94,91.0833},{497.88,91.1143},{499.82,91.1412},{501.76,91.1638},{503.7,91.1821},{505.64,91.1962},{507.58,91.2157},{509.52,91.2319},{511.46,91.2446},{513.4,91.2538},{515.34,91.2595},{517.28,91.2616},{519.22,91.2601},{521.16,91.2549},{523.1,91.2514},{525.04,91.2493},{526.98,91.2441},{528.92,91.236},{530.86,91.2248},{532.8,91.2105},{534.74,91.1931},{536.68,91.1725},{538.62,91.1488},{540.56,91.1021},{542.5,91.0573},{544.44,91.0172},{546.38,90.9788},{548.32,90.9402},{550.26,90.9002},{552.2,90.8581},{554.14,90.8133},{556.08,90.7658},{558.02,90.7167},{559.96,90.6651},{561.9,90.6103},{563.84,90.5525},{565.78,90.4916},{567.72,90.4276},{569.66,90.3604},{571.6,90.2901},{573.54,90.2166},{575.48,90.1362},{577.42,90.0471},{579.36,89.9544},{581.3,89.8579},{583.24,89.7578},{585.18,89.6538},{587.12,89.5461},{589.06,89.4346},{591.,89.3193},{592.94,89.2001},{594.88,89.0529},{596.82,88.8937},{598.76,88.7291},{600.7,88.559},{602.64,88.3834},{604.58,88.2022},{606.52,88.0155},{608.46,87.8232},{610.4,87.6253},{612.34,87.4217},{614.28,87.1386},{616.22,86.8309},{618.16,86.5127},{620.1,86.1843},{622.04,85.8455},{623.98,85.4964},{625.92,85.1371},{627.86,84.7675},{629.8,84.3877},{631.74,83.9977},{633.68,83.4083},{635.62,82.6442},{637.56,81.8491},{639.5,81.0238},{641.44,80.1688},{643.38,79.2849},{645.32,78.373},{647.26,77.434},{649.2,76.4691},{651.14,75.4792},{653.08,74.4658},{655.02,71.7189},{656.96,68.4572},{658.9,64.6821},{660.84,60.3074},{662.78,55.2319},{664.72,49.3365},{666.66,42.4811},{668.6,34.5006},{670.54,25.2004},{672.48,14.3511},{674.42,1.6931},{676.36,1.57406},{678.3,1.4456},{680.24,1.30491},{682.18,1.14743},{684.12,0.964876},{686.06,0.738679},{688.,0.399914},{700.,0.},{800.,0.},{2000,0},{3000,0},{4000,0}};
parameters["Sample InGaP"]=<|"J01"->3*^-23,"J02"->2.67*^-11,"Rs"->0.1*^-4,"Rsh"->10000*^-4|>; 


EQE["perovskite_Yang2015"]={{280.,0.},{300.,0.},{312.405,2.51373},{324.621,3.68077},{332.663,13.8167},{328.704,8.36418},{336.838,20.7158},{340.524,26.3729},{344.027,32.1344},{348.427,39.1312},{351.701,46.1005},{355.539,53.0176},{359.604,59.6712},{363.776,65.7473},{368.227,70.5182},{374.085,76.0015},{381.106,80.2279},{397.802,84.0935},{419.652,86.1526},{441.519,87.3851},{463.393,88.2941},{485.258,89.6884},{507.133,90.5255},{529.01,91.2908},{550.899,91.481},{572.794,91.3478},{594.69,91.1966},{616.586,91.0274},{638.497,90.1574},{660.393,89.9882},{682.298,89.3877},{704.211,88.4099},{726.126,87.3422},{748.012,87.6582},{769.92,86.896},{780.953,82.6993},{787.04,77.0471},{790.701,71.8146},{793.546,67.1119},{796.874,61.9572},{799.08,56.0734},{803.865,49.1973},{805.644,43.3544},{808.177,37.6964},{811.121,32.7819},{813.6,27.4721},{818.168,20.3984},{820.486,15.2142},{825.903,9.87526},{833.723,3.83047},{838.369,0.49402},{859.268,0.411662},{893.107,0.166541},{900.,0.},{1200.,0.},{4000.,0.}};
(* ref: Yang et al., Science, 2015 *)
EQE["perovskite_Yang2017"]={{280.,0.},{300.704,24.2321},{304.641,28.5377},{309.777,34.1741},{314.935,38.9916},{320.042,45.691},{324.35,49.3534},{327.752,53.8945},{332.034,58.5276},{337.197,63.1383},{343.225,68.4099},{350.414,74.1673},{361.143,79.4442},{383.438,84.451},{402.286,84.7715},{421.753,84.4503},{440.305,83.9597},{459.796,84.1196},{475.144,85.3392},{488.978,85.463},{505.351,85.4546},{524.94,86.0294},{542.697,86.2249},{558.414,87.0358},{573.973,87.5891},{596.447,88.634},{616.839,89.0198},{635.972,89.3779},{652.071,90.1903},{675.687,90.4514},{692.07,90.443},{704.968,90.1453},{724.363,90.1534},{734.942,90.148},{752.817,90.5653},{769.365,88.6777},{777.433,83.7544},{782.878,78.062},{787.468,71.4182},{790.902,64.0376},{794.89,57.8684},{797.724,50.9685},{800.236,45.0456},{803.361,38.2467},{807.967,30.981},{809.885,25.3062},{814.5,17.7255},{819.034,13.0978},{822.684,8.58944},{834.682,1.82847},{865.87,0.016751},{896.591,0.},{1000.,0.},{2000.,0.},{3000.,0.},{4000.,0.}};
(* ref: Yang et al., Science, 2017, 1cm^2 square cell *)
parameters["perovskite_Miyano2016"]=<|"J01"->1.8*^-14,"J02"->8.8*^-8,"Rs"->3.6*^-4,"Rsh"->2|>; (* STC parameters in SI unit: J01, J02, Rs, Rsh *)
(* ref:  Miyano et al., "Lead halide perovskite photovoltaic as a model p-i-n diode", 2016. *)
parameters["perovskite_Yang2015"]=<|"J01"->2*^-16,"J02"->1*^-7,"Rs"->3*^-4,"Rsh"->1.5|>;
parameters["perovskite_pin_Sun2015"]=<|"t0"->450*10^-9,"Jf0"->2.7*10^-12,"Jb0"->4*10^-12,"Vbi"->0.78,"Sf"->2,"Sb"->0.192|>; (* STC parameters in SI unit *)
parameters["perovskite_nip_Sun2015"]=<|"t0"->310*10^-9,"Jf0"->1.6*10^-16,"Jb0"->4.8*10^-16,"Vbi"->1.,"Sf"->100,"Sb"->0.054|>;
parameters["perovskite_nip_Yang2015"]=<|"t0"->450*10^-9,"Jf0"->1*10^-16,"Jb0"->1*10^-16,"Vbi"->1.,"Sf"->8,"Sb"->0.8|>; (*fitting is approx. *)
parameters["perovskite_nip_Yang2017a"]=<|"t0"->450*10^-9,"Jf0"->1*10^-17,"Jb0"->1*10^-17,"Vbi"->1.05,"Sf"->15,"Sb"->0.8|>; (* 1cm2 cell *)
parameters["perovskite_nip_Yang2017b"]=<|"t0"->480*10^-9,"Jf0"->1*10^-17,"Jb0"->1*10^-17,"Vbi"->1.02,"Sf"->2,"Sb"->0.8|>; (* small cell *)
parameters["perovskite_MIT2018"]=<|"t0"->480*10^-9,"Jf0"->1*10^-18,"Jb0"->1*10^-18,"Vbi"->1.06,"Sf"->1.5,"Sb"->0.8|>; (* hypothetical fitting *)


(* ::Text:: *)
(*2T:*)


(* experimental *)
EQE["InGS Essig2015_top"]={{280.,0.},{313.008,10.9114},{334.772,14.086},{344.89,17.2915},{350.443,21.549},{358.745,26.9235},{367.519,32.9906},{374.964,40.1442},{382.996,43.9424},{388.057,49.5135},{402.582,56.0832},{413.448,59.9903},{424.697,64.1474},{437.276,68.5632},{455.125,72.5206},{478.883,76.3015},{502.849,78.5148},{527.775,79.0361},{552.675,78.6406},{576.826,76.3873},{597.819,73.275},{611.295,69.2528},{619.424,62.9406},{629.061,56.6131},{640.852,50.1191},{644.372,37.0776},{644.542,43.1935},{648.488,22.2867},{652.817,14.9545},{654.958,10.4955},{657.094,5.86492},{700.,0.},{1000.,0.},{2000.,0.},{4000.,0.}};
EQE["InGS Essig2015_mid"]={{280.,0.},{450.,0.},{455.383,0.183375},{480.294,0.174653},{505.207,0.259461},{530.124,0.47677},{555.061,1.38724},{580.027,3.36656},{599.343,5.78797},{611.872,8.41367},{621.07,13.4579},{629.156,19.2116},{638.773,25.746},{644.259,33.0195},{646.874,45.6505},{649.404,55.2093},{654.097,61.0806},{656.471,65.0237},{660.041,72.0025},{670.246,73.1194},{679.58,76.1973},{688.542,78.2315},{694.482,79.9736},{704.394,78.1913},{710.076,75.3463},{718.064,74.3617},{730.372,73.5185},{742.82,75.5794},{748.966,77.0134},{760.072,77.2896},{767.752,76.3153},{781.25,73.9209},{792.548,72.1987},{808.914,70.97},{817.405,70.2207},{837.707,67.3538},{851.508,63.3713},{862.415,60.0405},{865.664,54.7134},{872.205,45.5716},{872.321,49.7667},{873.137,38.3693},{877.119,18.6484},{882.029,9.02492},{883.542,5.27121},{889.824,0.423441},{915.099,0.},{1000,0.},{2000,0.},{4000,0.}};
EQE["InGS Essig2015_bot"]={{280.,0.},{600.,0.},{641.086,0.274238},{666.017,0.966993},{690.939,1.36802},{715.011,2.5188},{740.86,4.94704},{765.835,7.22982},{790.812,9.62171},{812.421,13.0352},{830.913,16.3444},{845.464,20.4486},{862.598,25.8054},{869.731,33.5184},{872.205,45.5716},{873.137,38.3693},{875.882,55.6872},{878.413,65.2889},{880.94,74.7334},{896.023,81.0012},{921.922,82.6081},{946.824,82.2876},{971.741,82.4816},{996.617,81.2289},{1017.46,77.4935},{1029.46,73.1238},{1035.57,70.3209},{1040.15,66.7893},{1052.64,59.7122},{1060.4,53.8507},{1068.76,46.0221},{1080.34,37.971},{1089.25,32.5636},{1099.66,26.8584},{1109.33,21.6537},{1119.4,17.2061},{1132.83,11.7979},{1140.27,7.71532},{1156.1,3.60393},{1171.31,0.847877},{1193.66,0.376941},{1218.56,0.0252743},{2000,0.},{4000,0.}};
EQE["InGS Cariou2016_top"]={{280,20},{300,23.4249},{310,24.4218},{320,26.3628},{330,29.334},{340,33.4784},{350,38.951},{360,44.4511},{370,50.6832},{380,57.7959},{390,65.5332},{400,72.4028},{410,77.9061},{420,80.3835},{430,81.8296},{440,82.4017},{450,82.4861},{460,82.3218},{470,81.8606},{480,81.1943},{490,80.4376},{500,79.4523},{510,77.9926},{520,76.83},{530,75.9355},{540,74.8874},{550,73.5125},{560,72.086},{570,70.2323},{580,68.3845},{590,66.593},{600,64.7556},{610,62.661},{620,60.0978},{630,56.8641},{640,52.5505},{650,46.4501},{660,36.6732},{670,10.6368},{680,-8.52652*10^-15},{690,-6.96629*10^-21},{700,1.9611*10^-14},{710,-1.7053*10^-14},{720,-4.64696*10^-14},{730,2.5581*10^-15},{740,2.21828*10^-19},{750,2.55801*10^-15},{760,-2.04196*10^-19},{770,-8.52651*10^-15},{780,9.80561*10^-15},{790,1.96116*10^-14},{800,-2.81346*10^-14},{810,2.32736*10^-18},{820,1.70529*10^-14},{830,9.81167*10^-15},{840,1.14439*10^-17},{850,3.16665*10^-18},{860,-1.2773*10^-15},{870,-6.22078*10^-18},{880,-1.96227*10^-14},{890,1.10592*10^-14},{900,-4.08719*10^-17},{910,2.80961*10^-14},{920,-1.70732*10^-14},{930,-8.56296*10^-15},{940,-3.91784*10^-14},{950,3.66126*10^-14},{960,9.80549*10^-15},{970,1.96222*10^-14},{980,4.60186*10^-17},{990,8.67954*10^-15},{1000,2.85057*10^-17},{1010,1.83034*10^-14},{1020,-2.81111*10^-14},{1030,-3.54156*10^-14},{1040,-9.80549*10^-15},{1050,-9.7712*10^-15},{1060,9.79048*10^-15},{1070,-1.71006*10^-17},{1080,-1.10827*10^-14},{1090,1.96373*10^-14},{1100,8.51427*10^-15},{1110,-1.4482*10^-14},{1120,-1.69896*10^-14},{1130,-2.56423*10^-15},{1140,8.57615*10^-15},{1150,2.55671*10^-14},{1160,1.704*10^-14},{1170,2.54929*10^-17},{1180,-1.956*10^-14},{1190,-3.92342*10^-14},{1200,-2.82053*10^-17},{2000.,0.},{4000.,0.}};
EQE["InGS Cariou2016_mid"]={{280.,0.},{300,1.22645*10^-19},{310,8.77009*10^-18},{320,1.4735*10^-16},{330,1.67864*10^-15},{340,2.2851*10^-14},{350,4.45385*10^-13},{360,1.25069*10^-11},{370,4.30244*10^-10},{380,1.47739*10^-8},{390,4.12542*10^-7},{400,8.70479*10^-6},{410,0.000120455},{420,0.000925292},{430,0.00592312},{440,0.030321},{450,0.104076},{460,0.270875},{470,0.565349},{480,1.01049},{490,1.59981},{500,2.31487},{510,4.03875},{520,5.14734},{530,6.3728},{540,7.6987},{550,9.0692},{560,12.9028},{570,14.3884},{580,15.9554},{590,17.6623},{600,19.6026},{610,21.8668},{620,24.5329},{630,27.7833},{640,31.9048},{650,37.5179},{660,46.3529},{670,69.6883},{680,77.4643},{690,76.1317},{700,75.6058},{710,75.1259},{720,74.4754},{730,73.7675},{740,72.9207},{750,71.6127},{760,69.8621},{770,68.0466},{780,66.3086},{790,64.3334},{800,63.1227},{810,59.4389},{820,56.7186},{830,54.7511},{840,53.051},{850,51.307},{860,48.5905},{870,43.625},{880,5.90979},{890,0.521373},{900,0.0680194},{910,0.0274963},{920,0.0123005},{930,0.0051908},{940,0.00232783},{950,0.00105525},{960,-3.05756*10^-14},{970,9.53978*10^-15},{980,2.09387*10^-14},{990,-3.12584*10^-14},{1000,1.03749*10^-14},{1010,-8.04143*10^-16},{1020,3.04447*10^-14},{1030,1.92637*10^-14},{1040,-9.59437*10^-15},{1050,-1.89725*10^-17},{1060,3.13539*10^-14},{1070,1.22893*10^-17},{1080,2.08148*10^-14},{1090,4.01099*10^-14},{1100,-8.72138*10^-15},{1110,5.40936*10^-17},{1120,-9.55684*10^-15},{1130,6.25863*10^-17},{1140,1.81219*10^-18},{1150,9.57287*10^-15},{1160,1.76459*10^-15},{1170,1.92386*10^-14},{1180,2.96296*10^-14},{1190,-1.92272*10^-14},{1200,1.91889*10^-14},{2000.,0.},{4000.,0.}};
EQE["InGS Cariou2016_bot"]={{280.,0.},{300,0.},{310,0.},{320,0.},{330,0.},{340,0.},{350,0.},{360,0.},{370,0.},{380,0.},{390,0.},{400,0.},{410,0.},{420,0.},{430,0.},{440,1.03251*10^-14},{450,5.31432*10^-11},{460,9.35689*10^-9},{470,2.59181*10^-7},{480,3.54799*10^-6},{490,0.0000250248},{500,0.000117711},{510,0.000535583},{520,0.00154362},{530,0.00383867},{540,0.00811298},{550,0.0151593},{560,0.0392352},{570,0.0689388},{580,0.112548},{590,0.16715},{600,0.241615},{610,0.34858},{620,0.502659},{630,0.761289},{640,1.12343},{650,1.60729},{660,2.34606},{670,4.1677},{680,5.84716},{690,7.10737},{700,8.15263},{710,9.32719},{720,10.5936},{730,12.0116},{740,13.6001},{750,15.2867},{760,17.012},{770,18.8909},{780,21.0027},{790,23.2948},{800,24.2705},{810,27.4781},{820,29.8687},{830,32.0912},{840,34.0668},{850,35.5911},{860,37.6608},{870,41.8473},{880,77.5993},{890,83.8076},{900,85.618},{910,86.1296},{920,85.5346},{930,84.5161},{940,84.0013},{950,84.2608},{960,85.1524},{970,86.1639},{980,86.7654},{990,86.5712},{1000,85.6272},{1010,84.2324},{1020,82.6468},{1030,80.9145},{1040,78.9076},{1050,76.0256},{1060,71.3443},{1070,66.059},{1080,61.0007},{1090,54.8603},{1100,47.957},{1110,41.9434},{1120,35.2784},{1130,29.5257},{1140,22.3704},{1150,16.7507},{1160,11.3199},{1170,6.39657},{1180,2.00973},{1190,1.13138},{1200,0.695861},{2000.,0.},{4000.,0.}};
EQE["PS Bush2017_top"]={{280.,0.},{300.,0.},{312.697,38.8138},{317.358,42.5636},{336.852,44.7633},{343.671,42.1713},{352.871,40.1425},{358.465,38.8246},{366.456,43.0241},{376.263,46.0398},{387.705,48.6432},{391.943,53.4674},{392.79,58.0543},{394.485,61.8375},{402.961,66.1141},{415.674,70.004},{425.845,73.0516},{434.744,76.4701},{443.643,80.1487},{452.543,83.3544},{462.713,87.3997},{475.427,90.6772},{497.039,92.2277},{519.923,89.3333},{538.993,86.4246},{561.877,83.2737},{588.575,80.6427},{616.544,78.8181},{644.513,78.2701},{672.482,77.1547},{700.451,76.1941},{722.064,75.0601},{732.234,70.7898},{736.048,66.2919},{738.591,62.746},{741.134,59.5548},{743.676,48.9162},{746.219,45.9378},{747.067,41.2567},{749.609,35.2993},{751.304,29.8382},{753.847,23.2424},{756.39,20.6896},{757.661,16.2923},{760.204,11.257},{762.746,7.71118},{769.103,4.00075},{781.816,0.835603},{800.,0.},{4000.,0.}};
EQE["PS Bush2017_bot"]={{280.,0.},{500.,0.},{511.73,0.4095},{537.722,0.546012},{565.691,1.39084},{593.66,3.07392},{621.629,5.45338},{649.598,8.56793},{677.567,11.5406},{705.537,13.9072},{724.606,16.2491},{732.234,20.1874},{736.896,24.1369},{740.286,29.9538},{742.829,35.8651},{743.676,40.5466},{750.457,53.7409},{748.762,49.3429},{752.576,59.132},{755.118,66.0126},{753.847,61.8275},{757.661,71.1595},{760.204,75.3764},{762.746,79.4199},{767.832,83.9605},{774.188,87.5085},{788.173,91.1823},{812.328,92.9209},{840.297,93.0435},{868.266,92.3022},{896.236,90.2325},{924.205,87.3374},{952.174,85.861},{980.143,87.0927},{1008.11,89.0337},{1029.72,87.5923},{1041.17,84.3559},{1048.79,80.8112},{1055.15,76.7935},{1060.24,73.1064},{1065.32,69.1001},{1070.41,65.945},{1075.49,62.3998},{1080.58,58.7836},{1085.66,54.9547},{1090.75,51.835},{1095.83,48.0061},{1100.92,43.8225},{1106.,40.7737},{1111.09,37.1576},{1116.18,33.3286},{1121.26,29.9253},{1126.35,26.8765},{1131.43,23.4732},{1137.79,19.4081},{1144.14,15.8868},{1149.23,12.909},{1155.59,9.57687},{1163.21,6.55238},{1172.11,3.33905},{1187.37,0.594162},{1200.,0.},{4000.,0.}};
EQE["PS Sahli2018_top"]={{280.,0.},{300.,0.},{350.,0.},{358.492,8.50842},{358.537,11.591},{359.333,16.2149},{359.367,18.5269},{359.445,23.9215},{361.665,26.2334},{361.698,28.5454},{364.074,32.45},{365.269,34.884},{368.156,39.7199},{372.122,42.096},{376.523,45.5383},{381.975,49.0448},{384.11,52.3255},{387.87,54.6994},{391.014,57.8302},{397.102,61.8761},{401.79,65.3441},{407.632,68.3785},{415.662,71.5949},{423.814,74.03},{431.955,75.6837},{441.261,77.7901},{454.052,80.3076},{465.673,82.0576},{477.305,84.6104},{493.572,86.9705},{509.846,89.7828},{523.398,91.4604},{538.248,93.0312},{552.794,92.9912},{564.392,93.2561},{579.455,92.5417},{594.054,91.8269},{607.251,90.3434},{621.143,88.8589},{635.909,87.6689},{649.885,85.6948},{664.27,83.9039},{678.16,82.2663},{692.052,80.7571},{704.487,79.3121},{718.377,77.6745},{734.024,76.1332},{742.67,73.2433},{747.263,70.7386},{751.435,68.3303},{753.718,65.8257},{758.018,63.0581},{760.392,60.724},{761.078,57.8068},{761.809,54.9637},{763.228,52.2969},{764.778,49.5834},{766.37,42.1308},{766.423,45.7627},{767.749,36.8039},{767.788,39.4673},{769.157,33.414},{770.551,29.0557},{774.873,25.6659},{777.717,20.8232},{779.139,18.4019},{782.018,15.9806},{783.405,11.138},{786.284,8.71671},{787.706,6.2954},{794.953,3.63196},{810.943,0.968523},{820.,0.},{1200.,0.},{4000.,0.}};
EQE["PS Sahli2018_bot"]={{280.,0.},{550.,0.},{564.691,1.93705},{585.113,3.38983},{601.162,4.72155},{616.487,6.41646},{636.193,8.71671},{652.264,11.6223},{671.236,13.5593},{684.382,15.7385},{703.358,17.9177},{723.783,19.6126},{736.921,21.1864},{745.697,23.4867},{754.49,26.8765},{756.,30.5085},{757.507,33.8983},{759.024,38.0145},{761.984,41.1622},{762.044,45.2785},{764.714,48.197},{765.813,51.2315},{769.35,55.2292},{771.138,58.6008},{771.647,61.722},{775.02,65.8257},{775.93,69.1947},{778.411,71.124},{779.172,73.3809},{779.411,76.128},{780.017,78.6925},{781.596,80.5645},{783.821,83.2617},{786.463,86.0514},{788.905,88.6199},{790.693,91.1224},{793.347,93.4625},{797.74,94.9153},{809.093,96.5555},{823.015,97.1656},{836.931,97.294},{850.241,97.8208},{870.642,97.8208},{883.757,97.8208},{908.529,97.8208},{923.098,97.5787},{939.127,97.5787},{955.2,97.3904},{969.114,97.3583},{981.385,97.5787},{996.937,97.0693},{1010.84,96.4913},{1025.08,95.8838},{1040.96,94.372},{1053.68,92.2938},{1061.77,90.2618},{1072.17,87.9499},{1076.78,86.2801},{1080.8,83.0691},{1088.11,80.2048},{1091.83,77.8892},{1097.22,75.5552},{1103.51,72.6653},{1109.,69.3418},{1114.2,66.8083},{1117.06,65.0551},{1121.36,62.5973},{1125.11,60.399},{1127.39,57.7531},{1130.59,54.5935},{1135.41,51.5044},{1140.44,48.9195},{1145.04,46.386},{1146.9,43.9584},{1149.18,41.3575},{1152.62,38.7565},{1156.43,35.3657},{1159.48,32.3987},{1162.91,29.0752},{1167.13,26.683},{1169.8,24.5958},{1173.25,22.3416},{1175.54,20.0297},{1177.81,17.2296},{1182.23,14.481},{1185.59,12.1209},{1188.01,9.85706},{1191.45,7.11161},{1197.15,4.60048},{1198.56,0.968523},{1200.,0.},{4000.,0.}};
(* sample GS2T and InS2T EQE are simulated *)
EQE["sample GS2T_top"]={{280.,0.},{300,26.7282},{310,27.9705},{320,30.011},{330,32.4775},{340,35.6967},{350,40.6213},{360,46.6619},{370,54.892},{380,64.7776},{390,74.5381},{400,81.0453},{410,85.2692},{420,86.2277},{430,86.6259},{440,87.5011},{450,88.4091},{460,89.1281},{470,89.4929},{480,89.3762},{490,88.9112},{500,88.1598},{510,87.1346},{520,85.8622},{530,84.3777},{540,82.8484},{550,81.3084},{560,79.1457},{570,76.8873},{580,74.7053},{590,72.868},{600,71.0434},{610,69.0998},{620,67.0453},{630,64.4778},{640,62.1201},{650,60.2205},{660,58.6144},{670,57.1217},{680,54.5854},{690,52.0583},{700,50.2924},{710,48.4891},{720,46.6774},{730,44.8094},{740,42.8703},{750,40.8855},{760,38.9044},{770,36.9091},{780,34.9009},{790,32.8837},{800,31.9863},{810,29.2998},{820,27.4459},{830,25.962},{840,24.7096},{850,23.659},{860,22.1687},{870,19.4176},{880,2.16832},{890,0.184594},{900,0.0236719},{910,0.00951211},{920,0.00427669},{930,0.00181938},{940,0.000816902},{950,0.000366957},{960,8.73968*10^-15},{970,1.02611*10^-16},{980,-9.59003*10^-15},{990,2.08346*10^-14},{1000,8.80819*10^-17},{1010,-3.05477*10^-14},{1020,2.03656*10^-17},{1030,-7.34068*10^-17},{1040,6.9933*10^-17},{1050,1.92028*10^-14},{1060,-2.08407*10^-14},{1070,-3.03113*10^-14},{1080,3.91869*10^-14},{1090,2.87602*10^-14},{1100,5.05546*10^-14},{1110,4.95929*10^-14},{1120,-3.14088*10^-14},{1130,-4.97685*10^-14},{1140,-1.39615*10^-16},{1150,-8.74348*10^-15},{1160,-2.17056*10^-14},{1170,3.05851*10^-14},{1180,-2.09414*10^-14},{1190,1.30353*10^-14},{1200,-6.00794*10^-14},{4000.,0.}};
EQE["sample GS2T_bot"]={{280.,0.},{300,1.86884*10^-12},{310,1.7563*10^-11},{320,6.08044*10^-11},{330,1.38408*10^-10},{340,2.57755*10^-10},{350,4.53446*10^-10},{360,7.95217*10^-10},{370,1.35555*10^-9},{380,1.79611*10^-9},{390,2.51137*10^-9},{400,2.49136*10^-8},{410,2.62932*10^-7},{420,5.7952*10^-7},{430,0.0000261852},{440,0.00292609},{450,0.0361802},{460,0.163498},{470,0.41767},{480,0.874158},{490,1.50794},{500,2.32123},{510,3.29765},{520,4.44875},{530,5.75359},{540,7.09155},{550,8.43343},{560,11.2783},{570,13.2242},{580,15.1588},{590,16.8426},{600,18.5186},{610,20.303},{620,22.199},{630,24.5832},{640,26.8712},{650,28.8819},{660,30.8328},{670,33.2569},{680,36.0304},{690,38.5122},{700,40.2916},{710,42.0966},{720,43.8825},{730,45.6865},{740,47.5173},{750,49.3562},{760,51.1657},{770,52.9864},{780,54.8292},{790,56.703},{800,57.5446},{810,60.1049},{820,61.8975},{830,63.36},{840,64.5865},{850,65.5982},{860,67.0008},{870,69.567},{880,85.6277},{890,87.2027},{900,87.0379},{910,86.6988},{920,86.3295},{930,85.9168},{940,85.5285},{950,85.1242},{960,84.7142},{970,84.2836},{980,83.8372},{990,83.3089},{1000,82.6748},{1010,81.8826},{1020,80.8012},{1030,79.2415},{1040,77.0875},{1050,73.9568},{1060,69.2299},{1070,64.2454},{1080,59.8107},{1090,54.4989},{1100,48.3719},{1110,42.902},{1120,36.4354},{1130,30.6167},{1140,23.1471},{1150,17.2206},{1160,11.5289},{1170,6.4487},{1180,2.00757},{1190,1.12318},{1200,0.688426},{1300.,0.},{4000.,0.}};
EQE["sample InS2T_top"]={{280.,0.},{300,23.4249},{310,24.4218},{320,26.3628},{330,29.334},{340,33.4784},{350,38.951},{360,44.4511},{370,50.6832},{380,57.7959},{390,65.5332},{400,72.4029},{410,77.9073},{420,80.3914},{430,81.8675},{440,82.535},{450,82.8441},{460,83.0886},{470,83.3186},{480,83.4802},{490,83.6279},{500,83.8122},{510,85.435},{520,85.5674},{530,85.7024},{540,85.8158},{550,85.8904},{560,85.8952},{570,85.8459},{580,85.7295},{590,85.5254},{600,85.2633},{610,84.88},{620,84.1656},{630,83.0251},{640,81.3481},{650,78.3902},{660,70.9197},{670,28.7791},{680,1.96357*10^-14},{690,8.53202*10^-15},{700,-2.93873*10^-14},{1200,3.78855*10^-17},{4000.,0.}};
EQE["sample InS2T_bot"]={{280.,0.},{300,0.},{400,0.},{410,6.19504*10^-14},{420,2.20647*10^-11},{430,2.89247*10^-9},{440,1.45421*10^-7},{450,3.24493*10^-6},{460,0.0000373137},{470,0.000251979},{480,0.00111414},{490,0.00357786},{500,0.0090688},{510,0.0248104},{520,0.0455741},{530,0.0764523},{540,0.120021},{550,0.179328},{560,0.321942},{570,0.441509},{580,0.599558},{590,0.812315},{600,1.10653},{610,1.52696},{620,2.14976},{630,3.1234},{640,4.76935},{650,7.92136},{660,15.4985},{670,56.0106},{680,86.4495},{690,87.7509},{700,84.8685},{710,84.2435},{720,86.6303},{730,87.8489},{740,86.1099},{750,84.1842},{760,84.4817},{770,86.4604},{780,87.6944},{790,86.8495},{800,85.002},{810,83.987},{820,84.5686},{830,86.1386},{840,87.3721},{850,87.2935},{860,86.0473},{870,84.5958},{880,83.8597},{890,84.1849},{900,85.3032},{910,86.5457},{920,87.2079},{930,86.9269},{940,85.8915},{950,84.5999},{960,83.5836},{970,83.1521},{980,83.3545},{990,83.9257},{1000,84.486},{1010,84.5933},{1020,83.835},{1030,81.9536},{1040,78.9997},{1050,74.8802},{1060,69.313},{1070,63.8391},{1080,59.2798},{1090,54.1525},{1100,48.3741},{1110,43.2558},{1120,37.029},{1130,31.295},{1140,23.7165},{1150,17.6214},{1160,11.7452},{1170,6.52774},{1180,2.01802},{1190,1.12163},{1200,0.684039},{1300.,0.},{4000.,0.}};


(* ::Text:: *)
(*4T / voltage matched / areal matched:*)


(* experimental *)
EQE["InS_Essig2016_top"]={{280,26},{300,26.1502},{310,28.7576},{320,32.877},{330,38.4285},{340,44.9327},{350,52.2187},{360,58.6464},{370,64.7509},{380,69.94},{390,73.7676},{400,76.1382},{410,77.7763},{420,78.3272},{430,78.9144},{440,79.4614},{450,79.9409},{460,80.3411},{470,80.6606},{480,80.8872},{490,81.0396},{500,81.1377},{510,82.2032},{520,82.2039},{530,82.1527},{540,82.046},{550,81.8952},{560,81.7002},{570,81.4736},{580,81.1303},{590,80.7065},{600,80.1608},{610,79.4645},{620,78.5716},{630,77.0705},{640,74.7809},{650,70.8272},{660,62.1239},{670,23.8443},{680,-1.6349*10^-14},{690,2.29801*10^-14},{700,2.27531*10^-15},{710,3.70622*10^-14},{720,-2.5528*10^-14},{730,-4.33066*10^-16},{740,9.02205*10^-15},{750,2.66796*10^-14},{760,-7.99173*10^-15},{770,-1.20595*10^-14},{780,-1.74365*10^-14},{790,-6.11388*10^-15},{800,1.85314*10^-14},{810,1.88704*10^-14},{820,-8.29872*10^-15},{830,1.71647*10^-14},{840,-2.39837*10^-17},{850,2.80167*10^-14},{860,-1.5451*10^-16},{870,-1.08223*10^-14},{880,1.93865*10^-16},{890,-2.44871*10^-14},{900,3.72589*10^-14},{910,2.75336*10^-16},{920,-2.66406*10^-14},{930,-1.61003*10^-16},{940,5.90957*10^-16},{950,-1.92964*10^-14},{960,-9.85022*10^-16},{970,1.90785*10^-14},{980,2.39472*10^-14},{990,8.40218*10^-15},{1000,5.14194*10^-14},{1010,2.31931*10^-14},{1020,-3.55979*10^-14},{1030,2.93511*10^-14},{1040,-2.01282*10^-14},{1050,-9.6446*10^-15},{1060,-3.50913*10^-14},{1070,6.85102*10^-15},{1080,8.06362*10^-15},{1090,1.93525*10^-14},{1100,4.08407*10^-18},{1110,-1.19275*10^-15},{1120,1.67382*10^-14},{1130,2.02846*10^-14},{1140,-9.27258*10^-15},{1150,1.17097*10^-15},{1160,6.47159*10^-14},{1170,3.31979*10^-14},{1180,1.77851*10^-14},{1190,2.70235*10^-14},{1200,5.03191*10^-16},{2000.,0.},{4000.,0.}};
EQE["InS_Essig2016_bot"]={{280,0.},{300,0.},{310,0.},{320,0.},{330,0.},{340,0.},{350,0.},{360,0.},{370,0.},{380,0.},{390,0.},{400,0.},{410,0.},{420,7.77156*10^-14},{430,1.85407*10^-11},{440,1.37926*10^-9},{450,4.30367*10^-8},{460,6.63063*10^-7},{470,5.9549*10^-6},{480,0.0000353721},{490,0.000152044},{500,0.000510567},{510,0.00166442},{520,0.00415415},{530,0.00957572},{540,0.0207849},{550,0.0415237},{560,0.657149},{570,0.889481},{580,1.21195},{590,1.66262},{600,2.48283},{610,3.42577},{620,4.5069},{630,6.09893},{640,8.69124},{650,13.2536},{660,22.9258},{670,65.6432},{680,89.8781},{690,88.6689},{700,90.6586},{710,89.821},{720,88.0384},{730,89.6822},{740,91.508},{750,90.2803},{760,89.157},{770,90.4422},{780,91.0464},{790,88.4272},{800,85.7949},{810,86.0498},{820,88.8057},{830,90.6388},{840,89.2446},{850,86.5785},{860,85.758},{870,87.2308},{880,88.8839},{890,88.237},{900,85.2041},{910,82.2641},{920,81.6852},{930,83.8783},{940,87.4459},{950,89.4398},{960,87.6681},{970,82.8107},{980,77.6493},{990,74.4811},{1000,74.199},{1010,76.602},{1020,80.5433},{1030,83.8025},{1040,83.9212},{1050,79.7965},{1060,72.5607},{1070,65.3815},{1080,59.9494},{1090,55.788},{1100,52.5894},{1110,51.5409},{1120,48.4933},{1130,44.5137},{1140,36.2088},{1150,27.5775},{1160,18.3653},{1170,10.0022},{1180,2.97419},{1190,1.57621},{1200,0.956691},{2000.,0.},{4000.,0.}};
EQE["PS Werner2016_top"]={{280.,0.},{323.983,41.6159},{328.694,47.5565},{332.976,52.7556},{337.259,57.0601},{341.542,62.0036},{347.966,66.607},{354.39,70.9264},{360.814,75.1322},{368.308,79.4378},{384.368,83.2737},{407.923,86.2563},{431.478,86.5122},{455.032,87.4807},{478.587,88.5268},{502.141,89.6192},{525.696,90.4019},{549.251,89.8212},{572.805,87.273},{594.218,83.4864},{612.42,79.6701},{629.55,76.0972},{647.752,72.4276},{667.024,68.4957},{688.437,64.8795},{711.991,61.9285},{735.546,59.7366},{750.535,55.6104},{754.818,50.4284},{758.03,47.2342},{763.383,39.9081},{767.666,33.9876},{770.878,29.0041},{773.019,25.3409},{775.161,21.422},{777.302,17.5032},{779.8,12.6756},{783.726,9.32543},{790.15,4.68379},{806.21,1.16863},{829.764,0.21613},{853.319,0.146696},{876.874,0.154724},{1000.,0.},{4000.,0.}};
EQE["PS Werner2016_bot"]={{280.,0.},{403.64,0.},{427.195,0.171875},{450.749,0.474258},{474.304,0.699179},{497.859,0.707207},{521.413,1.08705},{544.968,2.53587},{568.522,5.44097},{591.006,9.07229},{611.349,12.8454},{630.621,16.6958},{650.964,20.5617},{673.448,24.3774},{697.002,27.4374},{720.557,29.3355},{741.167,31.3798},{751.606,35.1751},{754.818,38.9111},{759.101,42.9742},{763.383,48.4715},{768.522,54.2759},{772.377,60.0032},{776.231,65.6964},{780.514,71.6965},{786.938,76.4704},{801.927,80.519},{825.482,81.627},{849.036,79.9928},{872.591,77.4911},{896.146,74.3696},{919.7,71.4031},{943.255,69.0718},{966.809,67.0968},{990.364,65.6331},{1013.92,63.7975},{1035.33,60.7632},{1050.32,57.1327},{1062.1,52.9331},{1072.81,49.2587},{1081.37,45.2142},{1089.94,41.1271},{1098.5,37.2531},{1107.07,32.9956},{1115.63,28.866},{1123.13,24.9489},{1130.62,20.6911},{1139.19,16.1354},{1147.75,12.2614},{1156.32,8.21691},{1168.09,4.39265},{1177.73,2.38746},{1200.,0.},{4000.,0.}};
EQE["InS_Essig2017_top"]={{280.,0.},{300.,0.},{352.311,32.8998},{356.421,36.4361},{359.41,40.3664},{363.894,46.1587},{362.96,42.6201},{368.377,50.2607},{371.367,53.7054},{375.85,57.5716},{379.773,61.3094},{383.696,64.9374},{389.114,68.7989},{393.785,72.1314},{400.323,75.9449},{408.73,79.4491},{419.939,82.5902},{435.818,85.6606},{455.434,88.1817},{475.984,90.8551},{496.534,93.4037},{517.084,94.3407},{537.633,94.5031},{558.183,94.0033},{578.733,93.0914},{599.906,91.8934},{617.965,89.8474},{631.042,86.7325},{639.449,83.4344},{646.921,79.8614},{653.46,75.9105},{657.944,72.6055},{661.867,69.2799},{664.669,65.936},{667.471,61.8362},{670.273,57.5532},{671.675,53.9402},{674.01,50.5295},{673.076,47.9658},{675.504,42.8221},{677.372,37.8653},{679.147,33.1036},{680.548,30.3895},{681.482,27.0456},{682.884,19.9798},{684.752,16.2351},{685.841,12.7079},{688.581,8.89676},{691.944,4.76861},{696.428,2.23333},{700.,0.},{1200.,0.},{4000.,0.}};
EQE["InS_Essig2017_bot"]={{280.,0.},{390.,0.},{398.455,1.04998},{425.543,1.39353},{561.92,1.70273},{593.145,3.06223},{614.021,4.87488},{630.108,7.75616},{639.449,11.3075},{647.388,14.6832},{652.526,17.305},{656.449,20.3918},{661.68,24.2625},{665.603,27.9591},{667.471,31.5118},{669.339,35.2552},{671.768,38.9859},{673.636,43.0991},{675.878,50.0301},{672.142,46.3305},{676.999,55.5864},{678.68,59.9306},{680.548,65.0365},{682.603,70.7447},{684.285,75.1449},{686.153,80.1392},{689.702,85.7661},{694.56,90.2053},{709.713,94.0311},{729.681,92.1181},{749.982,94.8526},{769.286,92.913},{786.1,91.7844},{802.38,95.8416},{822.996,94.2907},{845.414,93.5393},{866.057,93.5761},{886.773,92.382},{908.569,92.6722},{928.828,91.0173},{947.229,88.9141},{969.18,89.6058},{990.104,89.4259},{1006.54,86.6795},{1019.89,83.2184},{1035.31,80.1912},{1054.18,77.3823},{1069.13,73.6889},{1078.47,70.1169},{1085.01,66.7631},{1090.61,63.8027},{1094.35,60.8988},{1100.42,57.4616},{1106.49,52.972},{1111.91,48.7373},{1115.83,45.0996},{1121.25,41.5115},{1125.64,38.2422},{1131.44,34.185},{1137.32,29.9911},{1143.67,25.0733},{1149.27,21.1171},{1154.75,17.7271},{1159.73,14.4486},{1165.34,11.4162},{1170.01,7.64622},{1181.22,3.1113},{1198.96,1.66838},{1200.,0.},{4000.,0.}};
EQE["GS_Essig2017_top"]={{280.,0.},{320.,0.},{352.51,29.0346},{355.906,32.9243},{360.537,36.7493},{363.685,40.7217},{367.76,45.3163},{370.723,48.8626},{374.428,52.133},{378.873,55.9824},{382.948,59.4283},{387.763,62.5461},{392.949,66.1379},{398.506,69.0096},{404.988,72.1661},{413.323,75.2907},{422.584,78.4905},{431.845,81.745},{442.031,85.0086},{456.849,88.1857},{476.296,90.6483},{496.67,92.8611},{517.044,93.7686},{537.418,94.4398},{557.791,94.8377},{578.165,95.2603},{598.539,95.5214},{618.913,95.7576},{639.286,95.9565},{659.66,95.9938},{680.034,96.317},{692.999,96.1761},{730.042,95.1484},{750.416,95.223},{770.79,94.328},{791.163,92.9854},{811.537,90.9218},{830.059,88.6855},{843.95,85.5328},{852.285,82.7751},{857.577,79.0765},{862.472,75.3112},{864.787,71.5849},{867.472,67.4689},{869.417,63.2093},{870.343,58.8591},{872.658,54.7578},{872.195,50.6015},{873.585,47.1624},{874.511,43.6663},{874.974,39.6475},{876.363,35.0058},{875.9,31.4505},{877.289,28.7156},{877.752,25.0235},{879.141,22.1518},{880.067,19.0523},{881.456,12.0669},{882.537,8.65973},{886.364,5.12327},{897.56,1.29073},{917.11,0.397062},{937.484,0.272749},{1080.1,0.272749},{1100.47,0.272749},{1195.86,0.272749},{1200.,0.},{4000.,0.}};
EQE["GS_Essig2017_bot"]={{280.,0.},{500.,0.},{505.402,0.546238},{526.675,0.682982},{550.383,0.648796},{577.636,0.663447},{598.909,0.628285},{620.236,0.585308},{640.676,0.580424},{657.808,0.546238},{736.525,2.42647},{759.148,3.10531},{779.433,4.21554},{800.218,5.84888},{821.261,8.0159},{836.541,10.4875},{846.728,13.6489},{855.526,16.9214},{860.619,19.767},{864.324,22.873},{867.102,26.5515},{868.028,30.061},{870.436,37.7316},{869.88,33.6452},{871.918,45.1694},{871.424,41.4885},{873.399,56.3338},{874.14,51.7707},{872.658,48.9537},{875.834,65.7909},{875.437,60.618},{877.844,71.52},{879.758,78.4427},{877.289,75.2086},{881.549,83.2199},{884.697,87.1884},{888.402,91.1052},{902.293,94.5938},{922.482,93.7648},{943.246,93.9578},{961.562,93.5389},{979.713,89.6857},{997.679,91.5188},{1011.57,91.8211},{1021.76,88.2254},{1029.17,85.0021},{1043.06,82.3584},{1058.8,80.3691},{1067.14,77.1274},{1072.69,73.342},{1078.62,69.3237},{1084.73,66.5644},{1091.21,62.9837},{1099.55,59.6198},{1106.96,56.2809},{1113.44,52.6762},{1116.53,50.1345},{1122.7,46.221},{1127.33,42.2728},{1131.22,38.7773},{1136.41,34.5409},{1140.3,30.7179},{1143.07,27.6216},{1149.37,24.11},{1153.26,20.4914},{1158.82,16.6495},{1165.3,12.7683},{1171.32,8.75773},{1180.12,3.69136},{1193.08,1.50345},{1200.,0.},{4000.,0.}};
EQE["InGS_Essig2017_top"]={{280.,0.},{320.,0.},{335.568,15.7009},{341.418,20.1165},{345.414,23.4662},{349.409,27.1897},{353.405,30.6688},{357.4,34.2054},{361.395,36.5516},{365.391,42.5437},{364.392,39.1796},{371.384,45.8119},{376.378,49.6456},{381.372,53.096},{385.368,56.6038},{389.363,59.8385},{395.356,63.4757},{401.349,66.7823},{408.341,70.1521},{418.329,73.637},{431.314,76.5583},{446.297,79.5945},{463.42,82.6046},{487.499,84.8534},{510.223,86.5067},{528.602,86.8403},{553.506,86.1042},{576.718,85.1841},{599.834,84.0504},{620.096,81.2507},{630.085,77.7314},{637.076,74.0568},{641.072,71.1527},{647.564,68.0283},{659.051,64.5635},{664.794,60.5717},{663.796,56.9632},{664.045,53.7532},{667.042,28.9724},{664.901,50.1878},{664.933,38.8729},{664.045,35.6334},{666.043,32.7965},{664.844,46.4943},{665.244,42.86},{673.035,18.7364},{674.034,15.2573},{674.034,25.6083},{674.034,22.158},{676.031,11.7303},{677.03,8.32786},{679.028,4.76251},{688.303,1.20948},{706.996,0.420836},{762.931,0.420836},{780.,0.},{1200.,0.},{4000.,0.}};
EQE["InGS_Essig2017_mid"]={{280.,0.},{500.,0.},{512.221,0.420836},{534.195,0.420836},{556.17,0.556759},{578.145,1.65459},{600.119,3.26475},{617.1,5.76886},{628.087,8.49462},{633.081,10.9444},{637.076,13.6184},{641.272,16.3844},{646.066,19.4264},{650.86,23.2621},{656.054,28.9436},{664.045,53.7532},{664.045,35.795},{664.901,50.1878},{664.545,39.194},{664.844,46.4943},{665.244,42.86},{670.538,63.6195},{670.038,60.8401},{672.436,71.1297},{674.533,77.6509},{674.034,74.8331},{676.431,82.6538},{674.034,80.0086},{674.034,67.7024},{678.429,87.0243},{682.424,90.8426},{692.013,94.1878},{709.992,95.4933},{731.967,95.8906},{753.941,94.4268},{775.916,95.0541},{796.892,95.2016},{812.873,92.3148},{823.86,89.6005},{834.848,86.8901},{845.835,84.609},{851.828,81.6187},{856.822,78.4559},{859.319,75.3219},{861.417,71.6818},{863.814,67.4149},{864.813,63.907},{865.812,61.5148},{865.312,58.4892},{866.811,55.9318},{867.81,52.9298},{867.81,49.5881},{869.807,45.4757},{869.807,42.2551},{871.805,37.9028},{873.137,33.7741},{873.803,31.1672},{873.303,28.3973},{875.8,25.0907},{875.8,21.9663},{877.798,18.4201},{877.299,15.3435},{879.396,11.3009},{881.394,7.32151},{885.789,3.98618},{901.77,1.19455},{923.745,0.546303},{945.719,0.420836},{967.694,0.420836},{986.672,0.420836},{1000.,0.},{4000.,0.}};
EQE["InGS_Essig2017_bot"]={{280.,0.},{580.,0.},{591.379,0.622106},{635.079,0.650859},{662.27,0.625301},{686.242,0.753091},{713.766,1.43038},{741.733,2.56771},{764.5,3.75616},{785.405,5.1938},{807.879,6.87192},{823.86,8.77065},{833.849,11.2894},{842.838,13.9429},{848.832,16.5101},{853.027,19.0649},{858.82,22.6673},{861.816,27.4623},{865.812,37.2678},{864.813,32.8745},{862.815,30.9678},{867.477,43.0324},{869.807,52.0343},{868.808,47.5152},{865.812,45.9193},{865.812,40.253},{871.805,61.6015},{871.139,57.4392},{867.81,55.3502},{873.232,68.8154},{871.805,64.9586},{875.515,77.3584},{874.801,72.9617},{877.227,82.2302},{880.795,88.3007},{879.796,84.9081},{893.78,90.9625},{915.754,91.0727},{932.734,91.3772},{950.114,93.0279},{971.689,92.2458},{986.672,91.5754},{994.064,88.5654},{1004.05,85.6031},{1012.97,84.609},{1022.63,86.6354},{1030.62,82.8409},{1033.62,79.6316},{1038.61,76.7499},{1051.6,74.969},{1066.58,73.5238},{1068.58,70.9572},{1072.57,67.4903},{1076.57,63.2631},{1080.76,59.5689},{1089.55,56.1614},{1095.15,53.7225},{1103.54,50.3664},{1107.93,46.6056},{1111.19,43.3946},{1114.52,40.0471},{1116.19,37.5669},{1119.02,34.9981},{1123.23,31.4269},{1127.51,27.9929},{1132.7,24.5732},{1138.5,21.5957},{1145.2,17.8932},{1150.68,14.1608},{1156.28,10.7504},{1159.47,8.14302},{1165.18,4.94852},{1176.88,1.75872},{1191.44,0.919218},{1200.,0.},{4000.,0.}};


(* simulated 4T GS EQE *)
EQE["GS_sample_top"]={{280,26},{300,26.0776},{310,28.6789},{320,32.7865},{330,38.2931},{340,44.7148},{350,51.987},{360,58.6093},{370,65.0488},{380,70.1757},{390,73.0848},{400,74.4091},{410,75.4308},{420,75.3523},{430,76.4115},{440,77.9713},{450,78.9913},{460,79.7577},{470,80.311},{480,80.6748},{490,80.908},{500,81.0738},{510,82.1602},{520,82.2693},{530,82.3361},{540,82.3646},{550,82.3726},{560,82.3616},{570,82.3426},{580,82.3268},{590,82.3425},{600,82.3623},{610,82.3827},{620,82.3904},{630,82.4057},{640,82.4312},{650,82.4563},{660,82.4765},{670,82.4923},{680,82.5051},{690,82.5073},{700,82.5013},{710,82.4876},{720,82.4629},{730,82.4113},{740,82.3318},{750,82.2199},{760,82.0645},{770,81.8518},{780,81.5952},{790,81.2073},{800,81.0158},{810,80.2539},{820,79.5831},{830,78.8141},{840,78.041},{850,77.3799},{860,76.0691},{870,73.5185},{880,17.2453},{890,1.67887},{900,0.2077},{910,0.0881833},{920,0.0404373},{930,0.0160091},{940,0.0081151},{950,0.00353348},{960,-1.66316*10^-14},{970,2.53932*10^-16},{980,1.57343*10^-14},{990,2.70136*10^-14},{1000,-1.03758*10^-14},{1010,3.69996*10^-15},{1020,-4.23292*10^-14},{1030,2.70222*10^-14},{1040,-2.92406*10^-16},{1050,-8.83769*10^-16},{1060,-5.8708*10^-15},{1070,-1.88274*10^-14},{1080,-8.3994*10^-15},{1090,-9.13221*10^-15},{1100,1.45629*10^-14},{1110,8.70196*10^-15},{1120,1.77741*10^-14},{1130,-3.2965*10^-16},{1140,-3.06599*10^-15},{1150,-6.94264*10^-15},{1160,-9.88058*10^-15},{1170,-3.67359*10^-14},{1180,-8.34201*10^-15},{1190,8.16421*10^-15},{1200,-1.06212*10^-14},{2000.,0.},{4000.,0.}};
EQE["GS_sample_bot"]={{280,0.},{300,0.},{310,0.},{320,0.},{330,0.},{340,0.},{350,0.},{360,0.},{370,0.},{380,0.},{390,0.},{400,0.},{410,0.},{420,0.},{430,0.},{440,0.},{450,0.},{460,0.},{470,0.},{480,0.},{490,0.},{500,1.11022*10^-14},{510,2.22045*10^-13},{520,5.09592*10^-12},{530,7.79599*10^-11},{540,7.44871*10^-10},{550,4.89832*10^-9},{560,3.03857*10^-7},{570,1.43922*10^-6},{580,5.56551*10^-6},{590,0.00001583},{600,0.0000437532},{610,0.000106266},{620,0.000235465},{630,0.000596657},{640,0.00133652},{650,0.00248015},{660,0.00407112},{670,0.00623722},{680,0.0125109},{690,0.0239908},{700,0.0371259},{710,0.057138},{720,0.0866945},{730,0.130476},{740,0.194696},{750,0.286231},{760,0.410929},{770,0.58076},{780,0.81213},{790,1.12448},{800,1.29403},{810,1.98292},{820,2.64626},{830,3.33153},{840,4.0441},{850,4.75051},{860,5.9032},{870,8.67507},{880,70.0397},{890,87.3534},{900,84.818},{910,89.1305},{920,84.7898},{930,80.8275},{940,89.4391},{950,81.4939},{960,75.9348},{970,86.6954},{980,84.6766},{990,73.5764},{1000,79.033},{1010,87.7763},{1020,78.0047},{1030,72.6651},{1040,79.8558},{1050,80.9061},{1060,70.2063},{1070,66.4296},{1080,69.5455},{1090,64.7213},{1100,53.8028},{1110,50.3834},{1120,50.0192},{1130,43.9962},{1140,30.5111},{1150,21.9082},{1160,16.8241},{1170,11.4848},{1180,3.56177},{1190,1.64954},{1200,0.923879},{2000.,0.},{4000.,0.}};


(* ::Text:: *)
(**sample EQEs are simulated. *)


(* ::Chapter:: *)
(*Main definitions*)


(* ::Text:: *)
(*Overall convention: *)
(*Device model full output will be in the format of {IV curve, Isc, Voc, FF, Pmpp, Impp, Vmpp, ...}. *)


Begin["`Private`"];


(* ::Section::Closed:: *)
(*Constants and auxiliary functions*)


q=1.6*10^-19;
k=1.381*10^-23;
c=3*10^8;
h=6.626*10^-34;


defaultSiPar=<|"J01"->2*10^-9,"J02"->1*10^-8,"Rs"->0.9*10^-4,"Rsh"->10000*10^-4,"BreakdownFactor"->0,"BreakdownVoltage"->-5.5,"AvalancheBreakdownExponent"->3.28|>;
defaultGaAsPar=<|"J01"->6*^-17,"J02"->1*^-8,"Rs"->1*^-4,"Rsh"->10000*^-4|>;
defaultInGaPPar=<|"J01"->3*^-23,"J02"->2.67*^-11,"Rs"->0.1*^-4,"Rsh"->10000*^-4|>;
defaultPerovskitePar1=<|"J01"->2*^-16,"J02"->1*^-7,"Rs"->3*^-4,"Rsh"->1.5|>;
defaultPerovskitePar2=<|"t0"->480*10^-9,"Jf0"->1*10^-17,"Jb0"->1*10^-17,"Vbi"->1.02,"Sf"->2,"Sb"->0.8|>;


TemperatureCoeff[spec_,device_,opt:OptionsPattern[]]:=Module[{Tprobe,outputs,effList,fit,x,sTC={}},

Tprobe=Range[-10,80,5]+273.15;
outputs=device[spec,#,opt]&/@Tprobe;

(* Tc for short circuit current *)
fit=Fit[Transpose[{Tprobe,outputs[[All,2]]}],{1,x},x];
AppendTo[sTC,fit[[2,1]]/outputs[[8,2]]];

(* Tc for open circuit voltage *)
fit=Fit[Transpose[{Tprobe,outputs[[All,3]]}],{1,x},x];
AppendTo[sTC,fit[[2,1]]/outputs[[8,3]]];

(* Tc for MPP power *)
fit=Fit[Transpose[{Tprobe,outputs[[All,5]]}],{1,x},x];
AppendTo[sTC,fit[[2,1]]/outputs[[8,5]]];

Return@sTC
];


(* ::Text:: *)
(*Calculate raw Jsc without temperature correction or luminescent coupling: *)


CalcJsc[spec_,QE_,cellArea_:1.,metalCoverage_:0.]:=Module[{wavelength,wRange,specInterp,qeInterp,\[Phi]\[Lambda]},
	wavelength=First/@spec;
	wRange=Range[First[wavelength],Last[wavelength]]; (* in step of 1 nm *)
	specInterp=Interpolation[spec,InterpolationOrder->1];
	qeInterp=Interpolation[QE,InterpolationOrder->1];
	\[Phi]\[Lambda]=(specInterp[wRange]*wRange)/(h*c)*10^-9;
	
	(* return Jsc in A/m2 *)
	Return[Total[q*qeInterp[wRange]*0.01*\[Phi]\[Lambda]]*cellArea*(1-metalCoverage)];
];


(* ::Section::Closed:: *)
(*Si cell*)


(* ::Text:: *)
(*A simple two diode model for a Si solar cell, taking into account temperature effects. *)
(*Default QE and J0 values represent a typical PERC cell. *)
(*QE can be EQE or IQE. If IQE is used, input spectrum should be corrected for reflectance and transmittance. *)
(*All units are in SI except for spectrum, which is usually in units nm for wavelength and W/m^2/nm for spectral irradiance. *)
(*Input spec can simply be the photo-generation current in SI unit. Often it is more convenient to specify photogeneration current instead of worrying about spectrum, since Si cell is usually insensitive to spectral effects. Note that this current should not be temperature corrected (correction will be done internally). *)


SiCell[spec_,T_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,IV,voltage,current,step,vmax,Jmpp,Vmpp,V,J,P,Jsc=0,Voc,t,FF,Pmpp,n1,n2,a,Vbr,m,samplePts},
Tstc=273.15+25;
Eg[0]=1.1557*q; (* Ref: Y.P. Varshni, Physica 1967 *)
Eg[Tstc]=Eg[0]-7.021*10^-4*q*Tstc^2/(Tstc+1108);
Eg[T]=Eg[0]-7.021*10^-4*q*T^2/(T+1108);
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultSiPar~Join~OptionValue[DeviceParameters];

(* mannually adjustable parameters *)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.0005; (* i.e. 0.05%/K, in proportion per K *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)
a=cellParameterList["BreakdownFactor"];
Vbr=cellParameterList["BreakdownVoltage"];
m=cellParameterList["AvalancheBreakdownExponent"];

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling from the front *)
If[Jsc<0.1,
	{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}={Null,0,0,0,0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh-a*(t+#*Rs)/Rsh*(1-(t+#*Rs)/Vbr)^-m,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh-a*(#+t*Rs)/Rsh*(1-(#+t*Rs)/Vbr)^-m,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Voc=t/.(voltage@0);
step=Abs[Voc/5];
samplePts=OptionValue@SamplePoints;
Switch[samplePts,
	"Default", (* dense spacing near Voc in steps of Voc/30 and even spacing in other regions in steps of Voc/5 all the way till -1V*)
		V=Join[Range[1.1*Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,-1,-step]];,
	_Integer, (* log spacing for positive voltage range *)
		V=(1.1*Voc*Reverse[11-N[10^Range[Log10@11,0,-Log10@11/samplePts]]]/10) ~Join~ Range[0-step,-1,-step];,
	_List, (* explicit specification of probing points *)
		V=samplePts;
];

(* calculate IV curve from sampled points and refine search to cover the MPP to accuracy of 0.5% of Voc *)
IV={};
While[Abs[step]>=Voc*0.005,
	J={};
	Do[
	AppendTo[J,t/.(current@j)],{j,V}
	];

	P=J*V;
	IV=Join[IV,Transpose[{V,J,P}]];
	
	(* iteratively pick the point with highest power and compare points one step size around it, and shrink step size at each iteration *)
	step=step/2;
	vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
	V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);
IV=IV[[All,{1,2}]];

Label[end];
Return@{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp};

]


SiCell[spec_,T_,probe_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,wavelength,\[Phi]\[Lambda],Tstc,IV,wRange,voltage,V,J,Jsc=0,t,specInterp,qeInterp,n1,n2,a,Vbr,m,P,current},
Tstc=273.15+25;
Eg[0]=1.1557*q; (* Ref: Y.P. Varshni, Physica 1967 *)
Eg[Tstc]=Eg[0]-7.021*10^-4*q*Tstc^2/(Tstc+1108);
Eg[T]=Eg[0]-7.021*10^-4*q*T^2/(T+1108);
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultSiPar~Join~OptionValue[DeviceParameters];

(* mannually adjustable parameters *)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* differentiate front and back QE if applicable *)
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.0005; (* i.e. 0.05%/K, in proportion per K *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)
a=cellParameterList["BreakdownFactor"];
Vbr=cellParameterList["BreakdownVoltage"];
m=cellParameterList["AvalancheBreakdownExponent"];

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{P,J,V}={0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh-a*(t+#*Rs)/Rsh*(1-(t+#*Rs)/Vbr)^-m,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh-a*(#+t*Rs)/Rsh*(1-(#+t*Rs)/Vbr)^-m,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Switch[probe,{"J",_},
	J=probe[[2]];
	Which[J<=Jsc,
		V=t/.(voltage@J);,
		J<=3*Jsc,
		V=t/.FindRoot[J==Jsc-J01*(Exp[(q*(t+J*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+J*Rs))/(n2*k*T)]-1)-(t+J*Rs)/Rsh-a*(t+J*Rs)/Rsh*(1-(t+J*Rs)/Vbr)^-m,{t,Vbr*0.9},PrecisionGoal->3,AccuracyGoal->3]/._Complex->Vbr;,
		True,
		V=Vbr;
	];
	(* reverse part treated as a simple interpolation, deprecated *)
	(*If[J<=Jsc,
		V=t/.(voltage@J);
		,
		V=-t/.(voltage@0);
		J=t/.(current@V);
		V=(V-0)*(probe[[2]]-Jsc)/(J-Jsc);
		J=t/.(current@V);
	];*)
	P=J*V;
,{"V",_},
	V=probe[[2]];
	J=t/.(current@V);
	P=J*V;
];

Label[end];
Return@{P,J,V};

]


(* ::Section::Closed:: *)
(*GaAs cell*)


(* ::Text:: *)
(*A simple two diode model for a GaAs solar cell, taking into account temperature effects. *)
(*Default QE and J0 values represent a state of the art Alta ELO GaAs cell. *)


GaAsCell[spec_,T_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,IV,voltage,current,Jmpp,Vmpp,V,J,P,vmax,step,Jsc=0,Voc,t,FF,Pmpp,n1,n2,\[Eta]$internal},
Tstc=273.15+25;
Eg[0]=1.5216*q; (* Ref: Y.P. Varshni, Physica 1967 *)
Eg[Tstc]=Eg[0]-8.871*10^-4*q*Tstc^2/(Tstc+572);
Eg[T]=Eg[0]-8.871*10^-4*q*T^2/(T+572);
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultGaAsPar~Join~OptionValue[DeviceParameters];

(*adjustable parameters*)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
\[Eta]$internal=0.17; (* internal recycling efficiency, depends on optics from cell structure *)
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.0008; (* in proportion per K *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}={Null,0,0,0,0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Voc=t/.(voltage@0);
step=Abs[Voc/5];
V=Join[Range[1.1*Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,-1,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
AppendTo[J,t/.(current@j)],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);
IV=IV[[All,{1,2}]];

Label[end];
Return@{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp};

]


GaAsCell[spec_,T_,probe_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,voltage,V,J,Jsc=0,t,n1,n2,\[Eta]$internal,P,current},
Tstc=273.15+25;
Eg[0]=1.5216*q; (* Ref: Y.P. Varshni, Physica 1967 *)
Eg[Tstc]=Eg[0]-8.871*10^-4*q*Tstc^2/(Tstc+572);
Eg[T]=Eg[0]-8.871*10^-4*q*T^2/(T+572);
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultGaAsPar~Join~OptionValue[DeviceParameters];

(*adjustable parameters*)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
\[Eta]$internal=0.17;
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.0008; (* i.e. 0.05%/K, in proportion per K, same for below *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{P,J,V}={0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Switch[probe[[1]],"J",
	If[probe[[2]]<=Jsc,
		J=probe[[2]];
		V=t/.(voltage@J);,
		V=-t/.(voltage@0);
		J=t/.(current@V);
		V=(V-0)*(probe[[2]]-Jsc)/(J-Jsc);
		J=t/.(current@V);
	];
	P=J*V;
,"V",
	V=probe[[2]];
	J=t/.(current@V);
	P=J*V;
];

Label[end];
(* output light emission in terms of current density in unit DeviceArea, simplified from ref: Geisz 2015 *)
If[OptionValue[OutputCoupling],
Return[{P,J,V,If[V>=0,J01/cellArea*Exp[(q*Min[V,t/.(voltage@0)])/(k*T)-1],0]}];
,
Return[{P,J,V}];];

]


(* ::Section::Closed:: *)
(*InGaP cell*)


InGaPCell[spec_,T_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,IV,voltage,current,step,vmax,Jmpp,Vmpp,V,J,P,Jsc=0,Voc,t,FF,Pmpp,n1,n2,\[Eta]$internal},
Tstc=273.15+25;
(* Ref for T dependence of Eg: Hooft et al., 1992 *)
Eg[0]=1.937*q; 
Eg[Tstc]=Eg[0]-6.12*10^-4*q*Tstc^2/(Tstc+204);
Eg[T]=Eg[0]-6.12*10^-4*q*T^2/(T+204);
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultInGaPPar~Join~OptionValue[DeviceParameters];

(*adjustable parameters*)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
\[Eta]$internal=0.05; (*internal photon recycling efficiency*)
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.0008; (* taken to be the same as GaAs, but could be 0.07%/K according to Braun, 2013 *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}={Null,0,0,0,0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Voc=t/.(voltage@0);
step=Abs[Voc/5];
V=Join[Range[1.1*Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,-1,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
AppendTo[J,t/.(current@j)],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);
IV=IV[[All,{1,2}]];

Label[end];
{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}

]


InGaPCell[spec_,T_,probe_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,voltage,V,J,Jsc=0,t,n1,n2,\[Eta]$internal,P,current},
Tstc=273.15+25;
(* Ref for T dependence of Eg: Hooft et al., 1992 *)
Eg[0]=1.937*q; 
Eg[Tstc]=Eg[0]-6.12*10^-4*q*Tstc^2/(Tstc+204);
Eg[T]=Eg[0]-6.12*10^-4*q*T^2/(T+204);
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultInGaPPar~Join~OptionValue[DeviceParameters];

(*adjustable parameters*)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
\[Eta]$internal=0.05;
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.0008;
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{P,J,V}={0,0,0};
	Goto[end]
];

current=FindRoot[t==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;
voltage=FindRoot[#==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;

Switch[probe[[1]],"J",
	If[probe[[2]]<=Jsc,
	J=probe[[2]];
	V=t/.(voltage@J);
	,
	V=-t/.(voltage@0);
	J=t/.(current@V);
	V=(V-0)*(probe[[2]]-Jsc)/(J-Jsc);
	J=t/.(current@V);
	];
	P=J*V;
,"V",
	V=probe[[2]];
	J=t/.(current@V);
	P=J*V;
];

Label[end];
If[OptionValue[OutputCoupling],
Return[{P,J,V,If[V>=0,J01/cellArea*Exp[(q*Min[V,t/.(voltage@0)])/(k*T)-1],0]}];,
Return[{P,J,V}];];

]


(* ::Section::Closed:: *)
(*CdTe cell*)


(* ::Text:: *)
(*a simple one diode model for a CdTe solar cell, taking into account temperature effects using temperature coefficients. *)


simpleCdTeCell0[spec_,T_]:=Module[{QE,sJ0,Rs,Rsh,jscTc,vocTc,ffTc,wavelength,\[Phi]\[Lambda],Tstc,IV,wRange,voltage,Jtest,step,t,x0,x1,Jmpp,Vmpp,V,J,Jsc,Voc,FF,Pmpp,specInterp,qeInterp,tempCoeff,corr},
Tstc=273.15+25;

QE={{300,0.346471},{301,0.352353},{302,0.358235},{303,0.364118},{304,0.37},{305,0.375882},{306,0.381765},{307,0.387647},{308,0.393529},{309,0.399412},{310,0.405294},{311,0.411176},{312,0.417059},{313,0.422941},{314,0.428824},{315,0.434706},{316,0.440588},{317,0.446471},{318,0.452353},{319,0.458235},{320,0.464118},{321,0.47},{322,0.48},{323,0.49},{324,0.5},{325,0.51},{326,0.52},{327,0.53},{328,0.54},{329,0.55},{330,0.56},{331,0.57},{332,0.58},{333,0.59},{334,0.6},{335,0.61},{336,0.62},{337,0.63},{338,0.64},{339,0.65},{340,0.656667},{341,0.663333},{342,0.67},{343,0.676667},{344,0.683333},{345,0.69},{346,0.696667},{347,0.703333},{348,0.71},{349,0.712857},{350,0.715714},{351,0.718571},{352,0.721429},{353,0.724286},{354,0.727143},{355,0.73},{356,0.732857},{357,0.735714},{358,0.738571},{359,0.741429},{360,0.744286},{361,0.747143},{362,0.75},{363,0.755},{364,0.76},{365,0.765},{366,0.77},{367,0.775},{368,0.78},{369,0.785},{370,0.79},{371,0.791},{372,0.792},{373,0.793},{374,0.794},{375,0.795},{376,0.796},{377,0.797},{378,0.798},{379,0.799},{380,0.8},{381,0.801},{382,0.802},{383,0.803},{384,0.804},{385,0.805},{386,0.806},{387,0.807},{388,0.808},{389,0.809},{390,0.81},{391,0.811},{392,0.812},{393,0.813},{394,0.814},{395,0.815},{396,0.816},{397,0.817},{398,0.818},{399,0.819},{400,0.82},{401,0.821},{402,0.822},{403,0.823},{404,0.824},{405,0.825},{406,0.826},{407,0.827},{408,0.828},{409,0.829},{410,0.83},{411,0.83037},{412,0.83074},{413,0.83111},{414,0.83148},{415,0.83185},{416,0.83222},{417,0.83259},{418,0.83296},{419,0.83333},{420,0.8337},{421,0.834237},{422,0.834773},{423,0.83531},{424,0.835846},{425,0.836382},{426,0.836919},{427,0.837455},{428,0.837992},{429,0.838528},{430,0.839065},{431,0.841111},{432,0.843157},{433,0.845204},{434,0.84725},{435,0.849296},{436,0.851343},{437,0.853389},{438,0.855435},{439,0.857482},{440,0.859528},{441,0.859723},{442,0.859919},{443,0.860114},{444,0.86031},{445,0.860505},{446,0.860701},{447,0.860896},{448,0.861091},{449,0.861287},{450,0.861482},{451,0.862832},{452,0.864182},{453,0.865533},{454,0.866883},{455,0.868233},{456,0.869583},{457,0.870933},{458,0.872283},{459,0.873633},{460,0.874983},{461,0.87519},{462,0.875396},{463,0.875603},{464,0.875809},{465,0.876016},{466,0.876222},{467,0.876428},{468,0.876635},{469,0.876841},{470,0.877048},{471,0.877873},{472,0.878699},{473,0.879525},{474,0.880351},{475,0.881176},{476,0.882002},{477,0.882828},{478,0.883654},{479,0.884479},{480,0.885305},{481,0.885749},{482,0.886192},{483,0.886636},{484,0.887079},{485,0.887523},{486,0.887966},{487,0.88841},{488,0.888853},{489,0.889297},{490,0.88974},{491,0.890693},{492,0.891646},{493,0.8926},{494,0.893553},{495,0.894506},{496,0.895459},{497,0.896412},{498,0.897365},{499,0.898319},{500,0.899272},{501,0.898665},{502,0.898057},{503,0.89745},{504,0.896843},{505,0.896236},{506,0.895629},{507,0.895022},{508,0.894415},{509,0.893807},{510,0.8932},{511,0.893611},{512,0.894023},{513,0.894434},{514,0.894845},{515,0.895256},{516,0.895667},{517,0.896078},{518,0.896489},{519,0.8969},{520,0.897312},{521,0.89669},{522,0.896068},{523,0.895447},{524,0.894825},{525,0.894203},{526,0.893582},{527,0.89296},{528,0.892338},{529,0.891716},{530,0.891095},{531,0.891864},{532,0.892633},{533,0.893402},{534,0.894171},{535,0.894941},{536,0.89571},{537,0.896479},{538,0.897248},{539,0.898017},{540,0.898786},{541,0.898317},{542,0.897847},{543,0.897377},{544,0.896908},{545,0.896438},{546,0.895968},{547,0.895498},{548,0.895029},{549,0.894559},{550,0.894089},{551,0.894383},{552,0.894677},{553,0.894971},{554,0.895265},{555,0.895559},{556,0.895853},{557,0.896147},{558,0.896441},{559,0.896735},{560,0.897029},{561,0.897382},{562,0.897735},{563,0.898088},{564,0.898441},{565,0.898795},{566,0.899148},{567,0.899501},{568,0.899854},{569,0.900207},{570,0.90056},{571,0.900549},{572,0.900539},{573,0.900528},{574,0.900517},{575,0.900507},{576,0.900496},{577,0.900485},{578,0.900475},{579,0.900464},{580,0.900454},{581,0.900641},{582,0.900828},{583,0.901015},{584,0.901203},{585,0.90139},{586,0.901577},{587,0.901764},{588,0.901952},{589,0.902139},{590,0.902326},{591,0.902592},{592,0.902857},{593,0.903122},{594,0.903387},{595,0.903653},{596,0.903918},{597,0.904183},{598,0.904448},{599,0.904714},{600,0.904979},{601,0.904671},{602,0.904363},{603,0.904055},{604,0.903746},{605,0.903438},{606,0.90313},{607,0.902822},{608,0.902514},{609,0.902206},{610,0.901898},{611,0.901952},{612,0.902006},{613,0.902059},{614,0.902113},{615,0.902167},{616,0.902221},{617,0.902275},{618,0.902329},{619,0.902383},{620,0.902437},{621,0.90276},{622,0.903083},{623,0.903406},{624,0.903729},{625,0.904052},{626,0.904375},{627,0.904698},{628,0.905021},{629,0.905344},{630,0.905667},{631,0.905085},{632,0.904503},{633,0.903922},{634,0.90334},{635,0.902758},{636,0.902177},{637,0.901595},{638,0.901014},{639,0.900432},{640,0.89985},{641,0.899341},{642,0.898832},{643,0.898322},{644,0.897813},{645,0.897304},{646,0.896794},{647,0.896285},{648,0.895776},{649,0.895266},{650,0.894757},{651,0.894782},{652,0.894807},{653,0.894832},{654,0.894857},{655,0.894882},{656,0.894907},{657,0.894932},{658,0.894957},{659,0.894982},{660,0.895007},{661,0.895116},{662,0.895225},{663,0.895334},{664,0.895443},{665,0.895552},{666,0.895661},{667,0.89577},{668,0.895879},{669,0.895988},{670,0.896097},{671,0.895905},{672,0.895713},{673,0.895521},{674,0.895329},{675,0.895137},{676,0.894944},{677,0.894752},{678,0.89456},{679,0.894368},{680,0.894176},{681,0.893397},{682,0.892617},{683,0.891838},{684,0.891059},{685,0.890279},{686,0.8895},{687,0.88872},{688,0.887941},{689,0.887162},{690,0.886382},{691,0.885507},{692,0.884632},{693,0.883757},{694,0.882882},{695,0.882007},{696,0.881132},{697,0.880257},{698,0.879382},{699,0.878507},{700,0.877632},{701,0.877392},{702,0.877152},{703,0.876912},{704,0.876672},{705,0.876432},{706,0.876192},{707,0.875952},{708,0.875712},{709,0.875473},{710,0.875233},{711,0.875158},{712,0.875084},{713,0.875009},{714,0.874935},{715,0.874861},{716,0.874786},{717,0.874712},{718,0.874637},{719,0.874563},{720,0.874489},{721,0.873726},{722,0.872963},{723,0.8722},{724,0.871437},{725,0.870674},{726,0.869911},{727,0.869148},{728,0.868385},{729,0.867622},{730,0.866859},{731,0.866804},{732,0.866749},{733,0.866694},{734,0.866638},{735,0.866583},{736,0.866528},{737,0.866473},{738,0.866418},{739,0.866363},{740,0.866308},{741,0.86618},{742,0.866052},{743,0.865924},{744,0.865796},{745,0.865668},{746,0.86554},{747,0.865412},{748,0.865284},{749,0.865156},{750,0.865029},{751,0.864297},{752,0.863566},{753,0.862835},{754,0.862104},{755,0.861373},{756,0.860642},{757,0.859911},{758,0.85918},{759,0.858449},{760,0.857717},{761,0.857602},{762,0.857488},{763,0.857373},{764,0.857258},{765,0.857143},{766,0.857028},{767,0.856913},{768,0.856798},{769,0.856683},{770,0.856568},{771,0.856416},{772,0.856264},{773,0.856112},{774,0.855961},{775,0.855809},{776,0.855657},{777,0.855505},{778,0.855353},{779,0.855201},{780,0.855049},{781,0.854479},{782,0.85391},{783,0.853341},{784,0.852772},{785,0.852202},{786,0.851633},{787,0.851064},{788,0.850494},{789,0.849925},{790,0.849356},{791,0.84855},{792,0.847743},{793,0.846937},{794,0.846131},{795,0.845325},{796,0.844519},{797,0.843713},{798,0.842907},{799,0.8421},{800,0.841294},{801,0.84128},{802,0.841265},{803,0.841251},{804,0.841236},{805,0.841222},{806,0.841207},{807,0.841193},{808,0.841178},{809,0.841164},{810,0.84115},{811,0.837715},{812,0.834281},{813,0.830847},{814,0.827413},{815,0.823979},{816,0.820545},{817,0.817111},{818,0.813677},{819,0.810243},{820,0.806809},{821,0.803375},{822,0.799941},{823,0.796506},{824,0.793072},{825,0.789638},{826,0.786204},{827,0.78277},{828,0.779336},{829,0.775902},{830,0.772468},{831,0.768085},{832,0.763701},{833,0.759318},{834,0.754935},{835,0.750551},{836,0.746168},{837,0.741785},{838,0.737401},{839,0.733018},{840,0.728635},{841,0.720998},{842,0.713361},{843,0.705724},{844,0.698087},{845,0.69045},{846,0.682813},{847,0.675176},{848,0.667539},{849,0.659902},{850,0.652265},{851,0.642942},{852,0.633618},{853,0.624294},{854,0.614971},{855,0.605647},{856,0.596324},{857,0.587},{858,0.577677},{859,0.568353},{860,0.55903},{861,0.548122},{862,0.537214},{863,0.526306},{864,0.515398},{865,0.50449},{866,0.493582},{867,0.482674},{868,0.471766},{869,0.460858},{870,0.44995},{871,0.435747},{872,0.421545},{873,0.407343},{874,0.39314},{875,0.378938},{876,0.364736},{877,0.350534},{878,0.336331},{879,0.322129},{880,0.307927},{881,0.293724},{882,0.279522},{883,0.26532},{884,0.251118},{885,0.236915},{886,0.222713},{887,0.208511},{888,0.194308},{889,0.180106},{890,0.165904},{891,0.156439},{892,0.146974},{893,0.137509},{894,0.128044},{895,0.118579},{896,0.109114},{897,0.0996486},{898,0.0901835},{899,0.0807185},{900,0.0712535},{901,0.0668276},{902,0.0624016},{903,0.0579757},{904,0.0535498},{905,0.0491239},{906,0.044698},{907,0.0402721},{908,0.0358462},{909,0.0314203},{910,0.0269944},{911,0.025389},{912,0.0237837},{913,0.0221784},{914,0.020573},{915,0.0189677},{916,0.0173624},{917,0.015757},{918,0.0141517},{919,0.0125464},{920,0.010941},{921,0.0104602},{922,0.00997933},{923,0.00949848},{924,0.00901763},{925,0.00853678},{926,0.00805592},{927,0.00757507},{928,0.00709422},{929,0.00661336},{930,0.00613251},{931,0.00593373},{932,0.00573496},{933,0.00553618},{934,0.0053374},{935,0.00513863},{936,0.00493985},{937,0.00474107},{938,0.00454229},{939,0.00434352},{940,0.00414474},{941,0.00394596},{942,0.00374719},{943,0.00354841},{944,0.00334963},{945,0.00315086},{946,0.00295208},{947,0.0027533},{948,0.00255452},{949,0.00235575},{950,0.00215697},{1000,0.},{1100,0.},{1200,0.}};

tempCoeff={{0,1.02615},{1,1.02673},{2,1.02731},{3,1.02789},{4,1.02847},{5,1.02905},{6,1.02958},{7,1.02985},{8,1.03043},{9,1.03038},{10,1.02959},{11,1.02917},{12,1.02841},{13,1.0261},{14,1.0238},{15,1.02153},{16,1.01964},{17,1.01801},{18,1.0158},{19,1.01325},{20,1.01108},{21,1.00906},{22,1.00681},{23,1.00452},{24,1.00203},{25,0.999695},{26,0.998109},{27,0.996069},{28,0.993395},{29,0.991238},{30,0.989217},{31,0.986902},{32,0.984585},{33,0.982241},{34,0.979801},{35,0.977375},{36,0.974571},{37,0.971588},{38,0.969374},{39,0.967171},{40,0.964096},{41,0.960804},{42,0.957856},{43,0.955679},{44,0.952289},{45,0.949259},{46,0.946711},{47,0.944402},{48,0.941405},{49,0.937919},{50,0.93539},{51,0.932885},{52,0.929667},{53,0.926233},{54,0.923164},{55,0.920248},{56,0.916969},{57,0.913879},{58,0.910545},{59,0.907449},{60,0.904107},{61,0.90063},{62,0.897512},{63,0.894479},{64,0.89112},{65,0.88719},{66,0.884177},{67,0.880899},{68,0.876325},{69,0.872614},{70,0.869441},{71,0.86576},{72,0.862082},{73,0.858447},{74,0.853872},{75,0.849714},{76,0.846215},{77,0.842715},{78,0.839216},{79,0.835717},{80,0.832218}};

sJ0=2*10^-9;
Rs=0;
Rsh=10000*10^-2;
(*jscTc=0.0005; (* i.e. 0.05%/K, in proportion per K, same for below *)
vocTc=-0.0035;
ffTc=-0.0015;*)

wavelength=First/@spec;
wRange=Range[First[wavelength],Last[wavelength]]; (* in step of 1 nm *)
specInterp=Interpolation[spec,InterpolationOrder->1];
qeInterp=Interpolation[QE,InterpolationOrder->1];
\[Phi]\[Lambda]=(specInterp[wRange]*wRange)/(h*c)*10^-9;
Jsc=Total[q*qeInterp[wRange]*\[Phi]\[Lambda]]; (* in A/m2 *)
J=Range[Jsc,0,-Jsc/100];

voltage=FindRoot[#==Jsc-sJ0*(Exp[(q*(t+#*Rs))/(k*Tstc)]-1)-(t+#*Rs)/Rsh,{t,(k*Tstc)/q Log[(Jsc-#)/sJ0+1]}]&;
V=t/.(voltage/@J);
Voc=t/.(voltage@0);
IV=Transpose[{V,J}];

x0=0;
step=0.001*Jsc;
For[Jtest=Jsc-step,Jtest>=0,Jtest=Jtest-step,
x1=Jtest*(t/.voltage@Jtest);
If[x1<x0 && x1>0,Break[],x0=x1];
];
Jmpp=Jtest+step;
Vmpp=t/.voltage@Jmpp;
Pmpp=x0;
FF=Pmpp/(Jsc*Voc);

(* correct for elevated temperature *)
corr = Interpolation[tempCoeff,InterpolationOrder->1];

Pmpp=Jsc*Voc*FF*corr[T-273.15];

{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}

]



(* ::Section:: *)
(*Perovskite cell*)


(* ::Subsection::Closed:: *)
(*5 parameter (2 diode) model*)


(* ::Text:: *)
(*A simple 2 diode model for p-i-n type perovskite solar cell, planar structure, free of hysteresis. *)
(*Ref: Miyano et al., "Lead halide perovskite photovoltaic as a model p-i-n diode", 2016. *)
(*Bandgap temperature dependence based on measured blue shift in ref: Foley et al., 2015 and Milot et al., 2015. *)


TwoDiodePerovskiteCell[spec_,T_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,IV,voltage,current,step,vmax,Jmpp,Vmpp,V,J,P,Jsc=0,Voc,t,FF,Pmpp,n1,n2,\[Eta]$internal},
Tstc=273.15+25;
Eg[Tstc]=1.55*q;
Eg[T]=Eg[Tstc]+(T-Tstc)*0.00045*q;
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultPerovskitePar1~Join~OptionValue[DeviceParameters];

(* mannually adjustable parameters *)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.; (* assumes no temperature dependence *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)
\[Eta]$internal=0; (* internal recycling efficiency, depends on optics from cell structure *)

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}={Null,0,0,0,0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Voc=t/.(voltage@0);
step=Abs[Voc/5];
V=Join[Range[1.1*Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,-1,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
AppendTo[J,t/.(current@j)],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);
IV=IV[[All,{1,2}]];

Label[end];
{IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp}

]


TwoDiodePerovskiteCell[spec_,T_,probe_,opt:OptionsPattern[]]:=Module[{Eg,cellArea,cellParameterList,QE,QEfront,QErear,J01,J02,Rs,Rsh,jscTc,Tstc,IV,voltage,V,J,Jsc=0,t,n1,n2,\[Eta]$internal,P,current},
Tstc=273.15+25;
Eg[Tstc]=1.55*q;
Eg[T]=Eg[Tstc]+(T-Tstc)*0.00045*q;
cellArea=OptionValue[DeviceArea];
cellParameterList=defaultPerovskitePar1~Join~OptionValue[DeviceParameters];

(* mannually adjustable parameters *)
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

J01=cellParameterList["J01"]*cellArea*(T/Tstc)^3*Exp[-Eg[T]/(k*T)+Eg[Tstc]/(k*Tstc)]; (* temperature corrected J01 value, Ref: P. Singh, SolMat, 2012 *)
J02=cellParameterList["J02"]*cellArea*(T/Tstc)^1.5*Exp[-Eg[T]/(2*k*T)+Eg[Tstc]/(2*k*Tstc)]; (* scales with ni whereas J01 scales with ni^2 *)
Rs=cellParameterList["Rs"]/cellArea;
Rsh=cellParameterList["Rsh"]/cellArea;
jscTc=0.; (* assumes no temperature dependence *)
n1=1; (* ideality factor 1 *)
n2=2; (* ideality factor 2 *)
\[Eta]$internal=0; (* internal recycling efficiency, depends on optics from cell structure *)

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling]*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{P,J,V}={0,0,0};
	Goto[end]
];

voltage=FindRoot[#==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(t+#*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(t+#*Rs))/(n2*k*T)]-1)-(t+#*Rs)/Rsh,{t,(k*T)/q Log[(Jsc-#)/J01+1]},PrecisionGoal->3,AccuracyGoal->3]&;
current=FindRoot[t==Jsc-(1-\[Eta]$internal)*J01*(Exp[(q*(#+t*Rs))/(n1*k*T)]-1)-J02*(Exp[(q*(#+t*Rs))/(n2*k*T)]-1)-(#+t*Rs)/Rsh,{t,Jsc-J01*(Exp[(q*#)/(k*T)]-1)},PrecisionGoal->3,AccuracyGoal->3]&;

Switch[probe[[1]],"J",
	J=probe[[2]];
	If[probe[[2]]<= Jsc,
		V=t/.(voltage@J);
	,
		V=-t/.(voltage@0);
		J=t/.(current@V);
		V=(V-0)*(probe[[2]]-Jsc)/(J-Jsc);
		J=t/.(current@V);
	];
	P=J*V;
,"V",
	V=probe[[2]];
	J=t/.(current@V);
	P=J*V;
];

Label[end];
(* output light emission in terms of current density in unit DeviceArea, simplified from ref: Geisz 2015 *)
If[OptionValue[OutputCoupling],
Return[{P,J,V,If[V>=0,J01/cellArea*Exp[(q*Min[V,t/.(voltage@0)])/(k*T)-1],0]}];
,
Return[{P,J,V}];];

]


(* ::Subsection::Closed:: *)
(*Physics based model*)


(* ::Text:: *)
(*A physics-based model, ref: Sun et al., IEEE JPV, 2015. *)
(*temperature dependence of Jf0 and Jb0 is similar to classical semiconductors, dependence of Vbi similar to CIGS, with delta Ec = 0, dependence of Sf and Sb also similar to CIGS, depend on both the band offset (0 in this case?) and carrier recombination (e.g. thermionic emission), not considered at the moment. *)
(*Note: *)
(*current at V=0 may not be equal to J_absorption. *)
(*internal photon recycling and output coupling model not verified. *)


PerovskiteCell[spec_,T_,opt:OptionsPattern[]]:=Module[{cellArea,cellParameterList,Eg,QE,QEfront,QErear,jscTc,\[Lambda]ave,diffusionCoeff,t0,\[Beta]f,\[Beta]b,sVbi,v$prime,v,m,\[Alpha]f,\[Alpha]b,A,B,sJf0,sJb0,Tstc,IV,voltage,current,step,V,J,P,vmax,Jsc=0,Jsc2,Voc,t,Jmpp,Vmpp,Pmpp,FF},

(* main model specific definitions *)
Tstc=273.15+25;
Eg[Tstc]=1.55*q;
Eg[T]=Eg[Tstc]+(T-Tstc)*0.00045*q;
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

cellArea=OptionValue[DeviceArea];
cellParameterList=defaultPerovskitePar2~Join~OptionValue[DeviceParameters];
jscTc=0.; (* assumes no temperature dependence *)

\[Lambda]ave=100*10^-9;
diffusionCoeff=0.05*10^-4;
t0=cellParameterList["t0"];
\[Beta]f=diffusionCoeff/(t0*cellParameterList["Sf"]);
\[Beta]b=diffusionCoeff/(t0*cellParameterList["Sb"]);
sVbi=cellParameterList["Vbi"];
sVbi=Eg[T]/q+T/Tstc*(sVbi-Eg[T]/q)-(k*T)/q Log[(T/Tstc)^3];
v$prime=q*(v-sVbi)/(k*T);
m=t0/\[Lambda]ave;
\[Alpha]f=1/((Exp[v$prime]-1)/v$prime+\[Beta]f);
\[Alpha]b=1/((Exp[v$prime]-1)/v$prime+\[Beta]b);
A=\[Alpha]f*((1-Exp[v$prime-m])/(v$prime-m)-\[Beta]f);
B=\[Alpha]b*((1-Exp[v$prime+m])/(v$prime+m)-\[Beta]b);
sJf0=cellParameterList["Jf0"]*Exp[-Eg[T]/(k*T)+Eg[298.15]/(k*298.15)]*cellArea;
sJb0=cellParameterList["Jb0"]*Exp[-Eg[T]/(k*T)+Eg[298.15]/(k*298.15)]*cellArea;

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=(Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling])*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{IV,Jsc2,Voc,FF,Pmpp,Jmpp,Vmpp}={Null,0,0,0,0,0,0};
	Goto[end]
];

voltage=FindRoot[
(#==-Jsc*(A-B*Exp[-m])-
(\[Alpha]f*sJf0+\[Alpha]b*sJb0)*(Exp[(q*v)/(k*T)]-1))/.v->t,
{t,0.9},PrecisionGoal->3,AccuracyGoal->3]&;
current[x_]:=(-Jsc*(A-B*Exp[-m])-
(\[Alpha]f*sJf0+\[Alpha]b*sJb0)*(Exp[(q*v)/(k*T)]-1))/.v->x;

Voc=t/.(voltage@0);
step=Abs[Voc/5];
V=Join[Range[1.1*Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,-1,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
AppendTo[J,current[j]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Jsc2=current[0]; (* Jsc may be different from optical absorption for this model *)
IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc2*Voc);
IV=IV[[All,{1,2}]];

Label[end];
{IV,Jsc2,Voc,FF,Pmpp,Jmpp,Vmpp}

];


PerovskiteCell[spec_,T_,probe_,opt:OptionsPattern[]]:=Module[{cellArea,cellParameterList,Eg,QE,QEfront,QErear,jscTc,\[Lambda]ave,diffusionCoeff,t0,\[Beta]f,\[Beta]b,sVbi,v$prime,v,m,\[Alpha]f,\[Alpha]b,A,B,sJf0,sJb0,Tstc,IV,voltage,current,step,V,J,P,vmax,Jsc=0,Jsc2,Voc,t,Jmpp,Vmpp,Pmpp,FF},

(* main model specific definitions *)
Tstc=273.15+25;
Eg[Tstc]=1.55*q;
Eg[T]=Eg[Tstc]+(T-Tstc)*0.00045*q;
QE=OptionValue[DeviceQE];
If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
	QEfront=First@QE;
	QErear=Last@QE;
];

cellArea=OptionValue[DeviceArea];
cellParameterList=defaultPerovskitePar2~Join~OptionValue[DeviceParameters];
jscTc=0.; (* assumes no temperature dependence *)
\[Lambda]ave=100*10^-9;
diffusionCoeff=0.05*10^-4;
t0=cellParameterList["t0"];
\[Beta]f=diffusionCoeff/(t0*cellParameterList["Sf"]);
\[Beta]b=diffusionCoeff/(t0*cellParameterList["Sb"]);
sVbi=cellParameterList["Vbi"];
sVbi=Eg[T]/q+T/Tstc*(sVbi-Eg[T]/q)-(k*T)/q Log[(T/Tstc)^3];
v$prime=q*(v-sVbi)/(k*T);
m=t0/\[Lambda]ave;
\[Alpha]f=1/((Exp[v$prime]-1)/v$prime+\[Beta]f);
\[Alpha]b=1/((Exp[v$prime]-1)/v$prime+\[Beta]b);
A=\[Alpha]f*((1-Exp[v$prime-m])/(v$prime-m)-\[Beta]f);
B=\[Alpha]b*((1-Exp[v$prime+m])/(v$prime+m)-\[Beta]b);
sJf0=cellParameterList["Jf0"]*Exp[-Eg[T]/(k*T)+Eg[298.15]/(k*298.15)]*cellArea;
sJb0=cellParameterList["Jb0"]*Exp[-Eg[T]/(k*T)+Eg[298.15]/(k*298.15)]*cellArea;

Switch[spec,
	_?NumericQ, (* directly specifying the current *)
		Jsc=spec;,
	{_?NumericQ,_?NumericQ}, (* bifacial: directly specifying the front and back current *)
		Jsc=Plus@@spec,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		Jsc=First@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];,
	{{_?NumericQ},{_?NumericQ}}, (* bifacial: directly specifying the front and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=spec[[1,1]]/1000*CalcJsc[specAM15G,QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=Total@Flatten@spec/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];,
	_List?(ArrayQ@#&&ArrayDepth@#==2&), (* specify spectral irradiance *)
		Jsc=CalcJsc[spec,QE,cellArea,OptionValue@MetalCoverage];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_List?(ArrayQ@#&&ArrayDepth@#==2&)}, (* bifacial: specifying the front and back spectral irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+CalcJsc[spec[[2]],QE,cellArea,OptionValue@MetalCoverage];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),_?NumericQ}, (* bifacial: specifying the front spectral irradiance and back current *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2]];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2]];
		];,
	{_List?(ArrayQ@#&&ArrayDepth@#==2&),{_?NumericQ}}, (* bifacial: specifying the front spectral irradiance and back irradiance *)
		If[MatchQ[QE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}],
			Jsc=CalcJsc[spec[[1]],QEfront,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QErear,cellArea,OptionValue@MetalCoverage];
			,
			Jsc=CalcJsc[spec[[1]],QE,cellArea,OptionValue@MetalCoverage]+spec[[2,1]]/1000*CalcJsc[specAM15G,QE,cellArea,OptionValue@MetalCoverage];
		];
];
Jsc=(Jsc+jscTc*(T-Tstc)*Jsc+OptionValue[LuminescentCoupling])*cellArea*(1-OptionValue@MetalCoverage); (* correct for elevated temperature and luminescent coupling *)
If[Jsc<0.1,
	{P,J,V}={0,0,0};
	Goto[end]
];

voltage=FindRoot[
(#==-Jsc*(A-B*Exp[-m])-
(\[Alpha]f*sJf0+\[Alpha]b*sJb0)*(Exp[(q*v)/(k*T)]-1))/.v->t,
{t,0.9},PrecisionGoal->3,AccuracyGoal->3]&;
current[x_]:=(-Jsc*(A-B*Exp[-m])-
(\[Alpha]f*sJf0+\[Alpha]b*sJb0)*(Exp[(q*v)/(k*T)]-1))/.v->x;

Jsc2=current[0];
Switch[probe[[1]],"J",
	J=probe[[2]];
	If[probe[[2]]<= Jsc2,
		V=t/.(voltage@J);
		,
		V=-t/.(voltage@0);
		J=current[V];
		V=(V-0)*(probe[[2]]-Jsc2)/(J-Jsc2);
		J=current[V];
	];
	P=J*V;
,"V",
	V=probe[[2]];
	J=current[V];
	P=J*V;
];

Label[end];
If[OptionValue[OutputCoupling],
Return[{P,J,V,If[V>=0,(sJf0+sJb0)/cellArea*Exp[(q*Min[V,t/.(voltage@0)])/(k*T)-1],0]}];
,
Return[{P,J,V}];]

];


(* ::Section::Closed:: *)
(*Si Module*)


(* ::Text:: *)
(*Assumes exactly identical cells. *)


SiModule[spec_,T_,opt:OptionsPattern[]]:=Module[{devicePar=OptionValue@DeviceParameters,deviceQE=OptionValue@DeviceQE,cellArea=OptionValue@DeviceArea,moduleArea=OptionValue@ModuleArea,metalFraction=OptionValue@MetalCoverage,nSeries=OptionValue@SeriesCells,nPar=OptionValue@ParallelCells,cellIV,modIV,IVP,interp,maxJ,mpp,x,Isc,Voc,FF,\[Eta]cell,\[Eta]mod},

cellIV=First@SiCell[spec,T,DeviceParameters->devicePar,DeviceQE->deviceQE,DeviceArea->cellArea,MetalCoverage->metalFraction]; 

modIV={First@#,Last@#*nPar}&/@({First@#*nSeries,Last@#}&/@cellIV);

IVP=Append[#,Times@@#]&/@modIV;
mpp=First[IVP~Extract~Position[#,Max@#]&@Part[IVP\[Transpose],3]];

(*interp=Interpolation[Reverse/@modIV,InterpolationOrder\[Rule]1];
maxJ=modIV[[-1,2]];
mpp=NMaximize[{interp[x]*x,{0<=x<maxJ}},x,AccuracyGoal->5,PrecisionGoal->5];
mpp={x/.#[[2,1]],interp[x/.#[[2,1]]],First@#}&@mpp;*)

Isc=Interpolation[DeleteDuplicatesBy[Round[modIV,0.0001],First],InterpolationOrder->1][0];
Voc=Interpolation[DeleteDuplicatesBy[Round[Reverse/@modIV,0.0001],First],InterpolationOrder->1][0];
FF=Last@mpp/(Isc*Voc);
\[Eta]cell=Last@mpp/(cellArea*nSeries*nPar)/1000;
\[Eta]mod=Last@mpp/moduleArea;

Return[{modIV,Isc,Voc,FF}~Join~RotateRight@mpp~Join~{\[Eta]cell,\[Eta]mod}]
(*mpp is originally in the format of {Impp,Vmpp,Pmpp}*)

];


(* ::Section::Closed:: *)
(*2T current matched tandem modules*)


(* ::Subsection::Closed:: *)
(*General 2J-2T*)


(* ::Text:: *)
(*General dual junction 2T tandem model, does not include InGaP/GaAs/Si. *)


TwoTer2J[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topCell,botCell,topQE,botQE,botQErear,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step,rearSpec},
\[Eta]12=OptionValue[CouplingEfficiency];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

JscTop=topCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=botCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
	Do[
		topOutput=topCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
		coupling=\[Eta]12*topOutput[[4]];
		JscBot=botCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
	,3];
];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
	V={};

	Do[
		topOutput=topCell[rawJscTop,T,{"J",j},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
		coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
		AppendTo[V,topOutput[[3]]+botCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
	,
	{j,J}];

	P=J*V;
	IV=Join[IV,Transpose[{V,J,P}]];
	step=step/2;
	jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
	J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

(*correct for tandem Jsc by inching towards its exact value*)
V=IV[[1,1]];
While[V>0,
	Jsc=Jsc*1.001;
	topOutput=topCell[rawJscTop,T,{"J",Jsc},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
	coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
	V=topOutput[[3]]+botCell[rawJscBot,T,{"J",Jsc},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]];
	AppendTo[IV,{V,Jsc,V*Jsc}]
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]



TwoTer2J[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,topCell,botCell,topQE,botQE,botQErear,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step,rearSpec},
\[Eta]12=OptionValue[CouplingEfficiency];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[ArrayDepth@botQE==3, (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

JscTop=topCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=botCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
	Do[
		topOutput=topCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
		coupling=\[Eta]12*topOutput[[4]];
		JscBot=botCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
	,3];
];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
	V={};

	Do[
		topOutput=topCell[rawJscTop,T,{"J",j},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
		coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
		AppendTo[V,topOutput[[3]]+botCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
	,
	{j,J}
	];

	P=J*V;
	step=step/2;
	Pmpp=Max[P];
	jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
	J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*GaAs/Si (to be deprecated) *)


TwoTer$GaAsSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=GaAsCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=GaAsCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
	topOutput=GaAsCell[rawJscTop,T,{"J",j},OutputCoupling->True,DeviceParameters->topCellParameters];
	coupling=\[Eta]12*topOutput[[4]];
	AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

(*correct for tandem Jsc by inching towards its exact value*)
V=IV[[1,1]];
While[V>0,
Jsc=Jsc*1.001;
topOutput=GaAsCell[rawJscTop,T,{"J",Jsc},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
V=topOutput[[3]]+SiCell[rawJscBot,T,{"J",Jsc},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]];
AppendTo[IV,{V,Jsc,V*Jsc}]
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


TwoTer$GaAsSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=GaAsCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=GaAsCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
	topOutput=GaAsCell[rawJscTop,T,{"J",j},OutputCoupling->True,DeviceParameters->topCellParameters];
	coupling=\[Eta]12*topOutput[[4]];
	AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,{j,J}];

P=J*V;
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*InGaP/Si (to be deprecated) *)


TwoTer$InGaPSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=InGaPCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=InGaPCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=InGaPCell[rawJscTop,T,{"J",j},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

(*correct for tandem Jsc by inching towards its exact value*)
V=IV[[1,1]];
While[V>0,
Jsc=Jsc*1.001;
topOutput=InGaPCell[rawJscTop,T,{"J",Jsc},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
V=topOutput[[3]]+SiCell[rawJscBot,T,{"J",Jsc},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]];
AppendTo[IV,{V,Jsc,V*Jsc}]
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


TwoTer$InGaPSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=InGaPCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=InGaPCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=InGaPCell[rawJscTop,T,{"J",j},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}
];

P=J*V;
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*InGaP/GaAs/Si*)


(* ::Text:: *)
(*coupling from InGaP to Si is neglected, only consider coupling for adjacent cells. *)


TwoTer$InGapGaAsSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,\[Eta]23,topQE,midQE,botQE,coupling,topOutput,midOutput,topCellParameters,midCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscMid,JscBot,rawJscTop,rawJscMid,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency][[1]];
\[Eta]23=OptionValue[CouplingEfficiency][[2]];
topQE=OptionValue[SubQE][[1]];
midQE=OptionValue[SubQE][[2]];
botQE=OptionValue[SubQE][[3]];
topCellParameters=OptionValue[SubCells][[1]];
midCellParameters=OptionValue[SubCells][[2]];
botCellParameters=OptionValue[SubCells][[3]];

rawJscTop=CalcJsc[spec,topQE];
rawJscMid=CalcJsc[spec,midQE];
rawJscBot=CalcJsc[spec,botQE];
JscTop=InGaPCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscMid=GaAsCell[rawJscMid,T,{"V",0},DeviceParameters->midCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

Jsc=Min[JscTop,JscMid,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};
Do[
topOutput=InGaPCell[rawJscTop,T,{"J",j},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
midOutput=GaAsCell[rawJscMid,T,{"J",j},LuminescentCoupling->coupling,OutputCoupling->True,DeviceParameters->midCellParameters];
coupling=\[Eta]23*midOutput[[4]];
AppendTo[V,topOutput[[3]]+midOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]],{j,J}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

(*correct for tandem Jsc by inching towards its exact value*)
V=IV[[1,1]];
While[V>0,
Jsc=Jsc*1.01;
topOutput=InGaPCell[rawJscTop,T,{"J",Jsc},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
midOutput=GaAsCell[rawJscMid,T,{"J",Jsc},LuminescentCoupling->coupling,OutputCoupling->True,DeviceParameters->midCellParameters];
coupling=\[Eta]23*midOutput[[4]];
V=topOutput[[3]]+midOutput[[3]]+SiCell[rawJscBot,T,{"J",Jsc},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]];
AppendTo[IV,{V,Jsc,V*Jsc}];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscMid,JscBot}
]


TwoTer$InGapGaAsSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,\[Eta]23,topQE,midQE,botQE,coupling,topOutput,midOutput,topCellParameters,midCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscMid,JscBot,rawJscTop,rawJscMid,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency][[1]];
\[Eta]23=OptionValue[CouplingEfficiency][[2]];
topQE=OptionValue[SubQE][[1]];
midQE=OptionValue[SubQE][[2]];
botQE=OptionValue[SubQE][[3]];
topCellParameters=OptionValue[SubCells][[1]];
midCellParameters=OptionValue[SubCells][[2]];
botCellParameters=OptionValue[SubCells][[3]];

rawJscTop=CalcJsc[spec,topQE];
rawJscMid=CalcJsc[spec,midQE];
rawJscBot=CalcJsc[spec,botQE];
JscTop=InGaPCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscMid=GaAsCell[rawJscMid,T,{"V",0},DeviceParameters->midCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

Jsc=Min[JscTop,JscMid,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=InGaPCell[rawJscTop,T,{"J",j},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
midOutput=GaAsCell[rawJscMid,T,{"J",j},LuminescentCoupling->coupling,OutputCoupling->True,DeviceParameters->midCellParameters];
coupling=\[Eta]23*midOutput[[4]];
AppendTo[V,topOutput[[3]]+midOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}
];

P=J*V;
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

Return[Pmpp]
]


(* ::Subsection:: *)
(*perovskite/Si (to be deprecated) *)


(* ::Subsubsection::Closed:: *)
(*version 1: 5 parameter model perovskite*)


TwoTer$2DiodePerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=TwoDiodePerovskiteCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
,
3];
];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"J",j},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

(*correct for tandem Jsc by inching towards its exact value*)
V=IV[[1,1]];
While[V>0,
Jsc=Jsc*1.001;
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"J",Jsc},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
V=topOutput[[3]]+SiCell[rawJscBot,T,{"J",Jsc},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]];
AppendTo[IV,{V,Jsc,V*Jsc}]
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


TwoTer$2DiodePerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=TwoDiodePerovskiteCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
,
3];
];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"J",j},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}
];

P=J*V;
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

Return[Pmpp]
]


(* ::Subsubsection::Closed:: *)
(*version 2: physics-based model perovskite*)


TwoTer$PerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=PerovskiteCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=PerovskiteCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
,3];
];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=PerovskiteCell[rawJscTop,T,{"J",j},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

(*correct for tandem Jsc by inching towards its exact value*)
V=IV[[1,1]];
While[V>0,
Jsc=Jsc*1.001;
topOutput=PerovskiteCell[rawJscTop,T,{"J",Jsc},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
V=topOutput[[3]]+SiCell[rawJscBot,T,{"J",Jsc},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]];
AppendTo[IV,{V,Jsc,V*Jsc}]
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]



TwoTer$PerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,topCellParameters,botCellParameters,coupling,topOutput,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,J,V,P,JscTop,JscBot,rawJscTop,rawJscBot,jmax,step},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];
JscTop=PerovskiteCell[rawJscTop,T,{"V",0},DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceParameters->botCellParameters][[2]];

(* when LC is present, and bottom cell Jsc is smaller than top cell Jsc, JscBot needs to be corrected for LC. *)
(* only 3 iterations are performed *)
If[JscTop>JscBot&&\[Eta]12>0,
Do[
topOutput=PerovskiteCell[rawJscTop,T,{"J",JscBot},OutputCoupling->True,DeviceParameters->topCellParameters];
coupling=\[Eta]12*topOutput[[4]];
JscBot=SiCell[rawJscBot,T,{"V",0},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[2]];
,3];
];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=PerovskiteCell[rawJscTop,T,{"J",j},OutputCoupling->(\[Eta]12>0),DeviceParameters->topCellParameters];
coupling=If[\[Eta]12>0,\[Eta]12*topOutput[[4]],0];
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},LuminescentCoupling->coupling,DeviceParameters->botCellParameters][[3]]]
,
{j,J}
];

P=J*V;
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J=DeleteCases[{jmax-step,jmax,jmax+step},_?(#>Jsc&)];
];

Return[Pmpp]
]


(* ::Section:: *)
(*4T tandem modules*)


(* ::Subsection::Closed:: *)
(*General 2J-4T*)


(* ::Text:: *)
(*Dual junction 4T tandem. *)


FourTer2J[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topCell,botCell,topQE,botQE,botQErear,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,rearSpec},
\[Eta]12=OptionValue[CouplingEfficiency];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[Depth@botQE-1==3, (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

{IV[1],Jsc[1],Voc[1],FF[1],Pmpp[1],Jmpp[1],Vmpp[1]}=topCell[rawJscTop,T,DeviceQE->topQE,DeviceParameters->topCellParameters];

coupling=\[Eta]12*topCell[rawJscTop,T,{"V",Vmpp[1]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True][[4]];

{IV[2],Jsc[2],Voc[2],FF[2],Pmpp[2],Jmpp[2],Vmpp[2]}=botCell[rawJscBot,T,LuminescentCoupling->coupling,DeviceQE->botQE,DeviceParameters->botCellParameters];

Pmpp["total"]=Pmpp[1]+Pmpp[2];

{{IV[1],IV[2]},{Jsc[1],Jsc[2]},{Voc[1],Voc[2]},{FF[1],FF[2]},Pmpp["total"],{Jmpp[1],Jmpp[2]},{Vmpp[1],Vmpp[2]}}

]


(* ::Subsection::Closed:: *)
(*GaAs/Si (to be deprecated) *)


FourTer$GaAsSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

{IV[1],Jsc[1],Voc[1],FF[1],Pmpp[1],Jmpp[1],Vmpp[1]}=GaAsCell[rawJscTop,T,DeviceQE->topQE,DeviceParameters->topCellParameters];

coupling=\[Eta]12*GaAsCell[rawJscTop,T,{"V",Vmpp[1]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True][[4]];

{IV[2],Jsc[2],Voc[2],FF[2],Pmpp[2],Jmpp[2],Vmpp[2]}=SiCell[rawJscBot,T,LuminescentCoupling->coupling,DeviceQE->botQE,DeviceParameters->botCellParameters];

Pmpp["total"]=Pmpp[1]+Pmpp[2];

{{IV[1],IV[2]},{Jsc[1],Jsc[2]},{Voc[1],Voc[2]},{FF[1],FF[2]},Pmpp["total"],{Jmpp[1],Jmpp[2]},{Vmpp[1],Vmpp[2]}}

]


(* ::Subsection::Closed:: *)
(*InGaP/Si (to be deprecated) *)


FourTer$InGaPSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

{IV[1],Jsc[1],Voc[1],FF[1],Pmpp[1],Jmpp[1],Vmpp[1]}=InGaPCell[rawJscTop,T,DeviceQE->topQE,DeviceParameters->topCellParameters];

coupling=\[Eta]12*InGaPCell[rawJscTop,T,{"V",Vmpp[1]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True][[4]];

{IV[2],Jsc[2],Voc[2],FF[2],Pmpp[2],Jmpp[2],Vmpp[2]}=SiCell[rawJscBot,T,LuminescentCoupling->coupling,DeviceQE->botQE,DeviceParameters->botCellParameters];

Pmpp["total"]=Pmpp[1]+Pmpp[2];

{{IV[1],IV[2]},{Jsc[1],Jsc[2]},{Voc[1],Voc[2]},{FF[1],FF[2]},Pmpp["total"],{Jmpp[1],Jmpp[2]},{Vmpp[1],Vmpp[2]}}

]


(* ::Subsection::Closed:: *)
(*perovskite/Si (to be deprecated) *)


(* ::Subsubsection::Closed:: *)
(*version 1: 5 parameter model perovskite*)


FourTer$2DiodePerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

{IV[1],Jsc[1],Voc[1],FF[1],Pmpp[1],Jmpp[1],Vmpp[1]}=TwoDiodePerovskiteCell[rawJscTop,T,DeviceQE->topQE,DeviceParameters->topCellParameters];

coupling=If[\[Eta]12>0,\[Eta]12*TwoDiodePerovskiteCell[rawJscTop,T,{"V",Vmpp[1]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True][[4]],0];

{IV[2],Jsc[2],Voc[2],FF[2],Pmpp[2],Jmpp[2],Vmpp[2]}=SiCell[rawJscBot,T,LuminescentCoupling->coupling,DeviceQE->botQE,DeviceParameters->botCellParameters];

Pmpp["total"]=Pmpp[1]+Pmpp[2];

{{IV[1],IV[2]},{Jsc[1],Jsc[2]},{Voc[1],Voc[2]},{FF[1],FF[2]},Pmpp["total"],{Jmpp[1],Jmpp[2]},{Vmpp[1],Vmpp[2]}}

]


(* ::Subsubsection::Closed:: *)
(*version 2: physics-based model perovskite*)


FourTer$PerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling},
\[Eta]12=OptionValue[CouplingEfficiency];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

{IV[1],Jsc[1],Voc[1],FF[1],Pmpp[1],Jmpp[1],Vmpp[1]}=PerovskiteCell[rawJscTop,T,DeviceQE->topQE,DeviceParameters->topCellParameters];

coupling=If[\[Eta]12>0,\[Eta]12*PerovskiteCell[rawJscTop,T,{"V",Vmpp[1]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True][[4]],0];

{IV[2],Jsc[2],Voc[2],FF[2],Pmpp[2],Jmpp[2],Vmpp[2]}=SiCell[rawJscBot,T,LuminescentCoupling->coupling,DeviceQE->botQE,DeviceParameters->botCellParameters];

Pmpp["total"]=Pmpp[1]+Pmpp[2];

{{IV[1],IV[2]},{Jsc[1],Jsc[2]},{Voc[1],Voc[2]},{FF[1],FF[2]},Pmpp["total"],{Jmpp[1],Jmpp[2]},{Vmpp[1],Vmpp[2]}}

]


(* ::Section:: *)
(*Mechanically voltage matched modules*)


(* ::Subsection::Closed:: *)
(*General 2J-VMatch*)


VMatch2J[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,topCell,botCell,stringNum,topQE,botQE,botQErear,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc,rearSpec},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

sVocTop=topCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=botCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[topCell[rawJscTop,T,{"V",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[2]],botCell[rawJscBot,T,{"V",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[2]]];
If[a>b,
x2=botCell[rawJscBot,T,{"J",-maxJsc},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=topCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
jDiff=topOutput[[2]]+botCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
a=x2;,
x2=topCell[rawJscTop,T,{"J",-maxJsc},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=topCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
jDiff=topOutput[[2]]+botCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=topCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
jDiff=topOutput[[2]]+botCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=topCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+botCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


VMatch2J[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,topCell,botCell,stringNum,topQE,botQE,botQErear,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc,rearSpec},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

sVocTop=topCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=botCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=topCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+botCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*GaAs/Si (to be deprecated) *)


VMatch$GaAsSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; 
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=GaAsCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[GaAsCell[rawJscTop,T,{"V",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[2]],SiCell[rawJscBot,T,{"V",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[2]]];
If[a>b,
x2=SiCell[rawJscBot,T,{"J",-maxJsc},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=GaAsCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
a=x2;,
x2=GaAsCell[rawJscTop,T,{"J",-maxJsc},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=GaAsCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=GaAsCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=GaAsCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


VMatch$GaAsSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=GaAsCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=GaAsCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*InGaP/Si (to be deprecated) *)


VMatch$InGaPSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=InGaPCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[InGaPCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]]][[2]],SiCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]]][[2]]];
If[a>b,
x2=SiCell[rawJscBot,T,{"J",-maxJsc},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]]][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=InGaPCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]],OutputCoupling->True];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]],LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
a=x2;,
x2=InGaPCell[rawJscTop,T,{"J",-maxJsc},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]]][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=InGaPCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]],OutputCoupling->True];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]],LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=InGaPCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]],OutputCoupling->True];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]],LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=InGaPCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]],OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]],LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


VMatch$InGaPSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=InGaPCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=InGaPCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,DeviceArea->1/stringNum[[1]],OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,DeviceArea->1/stringNum[[2]],LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*perovskite/Si (to be deprecated) *)


(* ::Subsubsection::Closed:: *)
(*version 1: 5 parameter model perovskite*)


VMatch$2DiodePerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=TwoDiodePerovskiteCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[TwoDiodePerovskiteCell[rawJscTop,T,{"V",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[2]],SiCell[rawJscBot,T,{"V",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[2]]];

If[a>b,
x2=SiCell[rawJscBot,T,{"J",-maxJsc},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
a=x2;,
x2=TwoDiodePerovskiteCell[rawJscTop,T,{"J",-maxJsc},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


VMatch$2DiodePerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=TwoDiodePerovskiteCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];

While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsubsection::Closed:: *)
(*version 2: physics-based model perovskite*)


VMatch$PerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=PerovskiteCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[PerovskiteCell[rawJscTop,T,{"V",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[2]],SiCell[rawJscBot,T,{"V",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE][[2]]];

If[a>b,
x2=SiCell[rawJscBot,T,{"J",-maxJsc},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=PerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
a=x2;,
x2=PerovskiteCell[rawJscTop,T,{"J",-maxJsc},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=PerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=PerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=PerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


VMatch$PerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE,1/stringNum[[1]]]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE,1/stringNum[[2]]];

sVocTop=PerovskiteCell[rawJscTop,T,{"J",0},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];

While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=PerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceArea->1/stringNum[[1]],DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceArea->1/stringNum[[2]],DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]],{j,V}];
P=J*V;
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Section:: *)
(*3T voltage matched modules*)


(* ::Text:: *)
(*Approximate model for voltage matched module connected from 3T monolithic tandem cells. For connection scheme see Gee et al.,  1988. *)


(* ::Subsection::Closed:: *)
(*General 2J-3T*)


ThreeTer2J[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topCell,botCell,topQE,botQE,botQErear,rearSpec,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

sVocTop=topCell[rawJscTop,T,{"J",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=botCell[rawJscBot,T,{"J",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[topCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]]/stringNum[[1]]*stringNum[[2]],botCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]]];
If[a>b,
x2=botCell[rawJscBot,T,{"J",-maxJsc},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=topCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+botCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
a=x2;,
x2=topCell[rawJscTop,T,{"J",-maxJsc},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=topCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+botCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=topCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+botCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=topCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+botCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}]; (*current is always normalized to per unit DeviceArea*)
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


ThreeTer2J[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topCell,botCell,topQE,botQE,botQErear,rearSpec,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; (* raw photogeneration current calculated via EQE *)
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

sVocTop=topCell[rawJscTop,T,{"J",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=botCell[rawJscBot,T,{"J",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=topCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+botCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*GaAs/Si (to be deprecated) *)


ThreeTer$GaAsSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];

sVocTop=GaAsCell[spec,T,{"J",0},DeviceQE->topQE][[3]]*stringNum[[1]];
sVocBot=SiCell[spec,T,{"J",0},DeviceQE->botQE][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[GaAsCell[spec,T,{"V",0},DeviceQE->topQE][[2]]/stringNum[[1]]*stringNum[[2]],SiCell[spec,T,{"V",0},DeviceQE->botQE][[2]]];
If[a>b,
x2=SiCell[spec,T,{"J",-maxJsc},DeviceQE->botQE][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=GaAsCell[spec,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[spec,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
a=x2;,
x2=GaAsCell[spec,T,{"J",-maxJsc},DeviceQE->topQE][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=GaAsCell[spec,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[spec,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=GaAsCell[spec,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[spec,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=GaAsCell[spec,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[spec,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}]; (*current is always normalized to per unit DeviceArea*)
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


ThreeTer$GaAsSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];

sVocTop=GaAsCell[spec,T,{"J",0},DeviceQE->topQE][[3]]*stringNum[[1]];
sVocBot=SiCell[spec,T,{"J",0},DeviceQE->botQE][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=GaAsCell[spec,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[spec,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*InGaP/Si (to be deprecated) *)


ThreeTer$InGaPSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];

sVocTop=InGaPCell[spec,T,{"J",0},DeviceQE->topQE][[3]]*stringNum[[1]];
sVocBot=SiCell[spec,T,{"J",0},DeviceQE->botQE][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[InGaPCell[spec,T,{"V",0},DeviceQE->topQE][[2]]/stringNum[[1]]*stringNum[[2]],SiCell[spec,T,{"V",0},DeviceQE->botQE][[2]]];
If[a>b,
x2=SiCell[spec,T,{"J",-maxJsc},DeviceQE->botQE][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=InGaPCell[spec,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[spec,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
a=x2;,
x2=InGaPCell[spec,T,{"J",-maxJsc},DeviceQE->topQE][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=InGaPCell[spec,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[spec,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=4&&n<=15,
x2=(a+b)/2;
topOutput=InGaPCell[spec,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[spec,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->\[Eta]12*topOutput[[4]]][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=InGaPCell[spec,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[spec,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


ThreeTer$InGaPSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,stringNum,topQE,botQE,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];

sVocTop=InGaPCell[spec,T,{"J",0},DeviceQE->topQE][[3]]*stringNum[[1]];
sVocBot=SiCell[spec,T,{"J",0},DeviceQE->botQE][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=InGaPCell[spec,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,OutputCoupling->True];(* from single cell output *)
coupling=\[Eta]12*topOutput[[4]];
AppendTo[J,topOutput[[2]]+SiCell[spec,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*perovskite/Si (to be deprecated) *)


(* ::Subsubsection::Closed:: *)
(*version 1: 5 parameter model perovskite*)


ThreeTer$2DiodePerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

sVocTop=TwoDiodePerovskiteCell[rawJscTop,T,{"J",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[TwoDiodePerovskiteCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]]/stringNum[[1]]*stringNum[[2]],SiCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]]];

If[a>b,
x2=SiCell[rawJscBot,T,{"J",-maxJsc},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
a=x2;,
x2=TwoDiodePerovskiteCell[rawJscTop,T,{"J",-maxJsc},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=4&&n<=15,
x2=(a+b)/2;
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];


IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


ThreeTer$2DiodePerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

sVocTop=TwoDiodePerovskiteCell[rawJscTop,T,{"J",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];

While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=TwoDiodePerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Subsubsection::Closed:: *)
(*version 2: physics-based model perovskite*)


ThreeTer$PerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

sVocTop=PerovskiteCell[rawJscTop,T,{"J",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];

(* small algorithm to determine the correct tandem Voc considering PR & LC *)
(* to avoid FindRoot to blow up at probe points too far beyond Voc, the first probe point x2 need to be determined sufficiently close to the lower voltage of the sub-cells.
This is obtained by calculating the voltage at negative Jsc, Jsc here is the higher of the two sub-cells. This point will definitely be an upper bound. *)
a=sVocTop;
b=sVocBot;
maxJsc=Max[PerovskiteCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]]/stringNum[[1]]*stringNum[[2]],SiCell[rawJscBot,T,{"V",0},DeviceQE->botQE][[2]]];

If[a>b,
x2=SiCell[rawJscBot,T,{"J",-maxJsc},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
x2=Min[x2,a];
topOutput=PerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
a=x2;,
x2=PerovskiteCell[rawJscTop,T,{"J",-maxJsc},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
x2=Min[x2,b];
topOutput=PerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
b=x2;
];

n=1;
While[Abs[jDiff]>=2&&n<=15,
x2=(a+b)/2;
topOutput=PerovskiteCell[rawJscTop,T,{"V",x2/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
jDiff=topOutput[[2]]/stringNum[[1]]*stringNum[[2]]+SiCell[rawJscBot,T,{"V",x2/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
If[(jDiff>0&&a>b)||(jDiff<0&&a<b),b=x2;,a=x2;];
n++;];
Voc=x2;

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];
IV={};
While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=PerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
vmax=Extract[V,First@Position[P,n_/;n==Max[P]]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,First],First]];
P=IV[[All,3]];
Jsc=Last[IV[[All,2]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,sVocTop,sVocBot}
]


ThreeTer$PerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,stringNum,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,J,V,P,sVocTop,sVocBot,a,b,jDiff,x2,n,vmax,step,maxJsc},

(* tandem specific physical parameters *)
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
stringNum=OptionValue[StringNumber];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]];
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

sVocTop=PerovskiteCell[rawJscTop,T,{"J",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[3]]*stringNum[[1]];
sVocBot=SiCell[rawJscBot,T,{"J",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[3]]*stringNum[[2]];
Voc=Min[sVocTop,sVocBot];

(* algorithm to generate IV curve and determine mpp efficiently and robustly *)
(* this is done by first seeding some initial points on the IV curve, determine maximum among them, then perturb at that point with perturbation step smaller than (half of) previous gaps between the points.  *)
step=Abs[Voc/5];
V=Join[Range[Voc,0.9*Voc,-Voc/30],Range[0.8*Voc,0,-step]];

While[Abs[step]>=Voc*0.005,
J={};
Do[
topOutput=PerovskiteCell[rawJscTop,T,{"V",j/stringNum[[1]]},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];(* from single cell output *)
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]],0];
AppendTo[J,topOutput[[2]]+SiCell[rawJscBot,T,{"V",j/stringNum[[2]]},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]]*stringNum[[1]]/stringNum[[2]]],{j,V}];
P=J*V;
step=step/2;
Pmpp=Max[P];
vmax=Extract[V,First@Position[P,n_/;n==Pmpp]];
V=DeleteCases[{vmax-step,vmax,vmax+step},_?(#>Voc&)];
];

Return[Pmpp]
]


(* ::Section:: *)
(*Areal matched modules*)


(* ::Text:: *)
(*For areal matched modules, photocurrent generation for different device areas are taken care of by modifying sub-cell QEs. *)


(* ::Subsection::Closed:: *)
(*General 2J-AMatched*)


(* ::Text:: *)
(*General dual junction model for areal matched tandem with top cell current LARGER than bottom cell current when area is the same (does not work for InGaP/Si, as top cell current is larger than Si, does not make sense for Si to be smaller than top cells). *)


AMatch2J[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,DeviceArea$Ratio,topCell,botCell,topQE,botQE,botQErear,rawJscTop,rawJscBot,rearSpec,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
DeviceArea$Ratio=OptionValue[AreaRatio];

topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];
botQE=botQE\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); 
(* linearly DeviceArea weighted effective SubQE for bottom cell (front side) = weighted Si SubQE under top cell + weighted Si unshaded SubQE *)

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

JscTop=topCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=botCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

If[JscTop>JscBot&&calcPRLC,
Do[
topOutput=topCell[rawJscTop,T,{"J",JscBot},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
JscBot=botCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=topCell[rawJscTop,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]]*DeviceArea$Ratio,0];
AppendTo[V,topOutput[[3]]+botCell[rawJscBot,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J={jmax-step,jmax,jmax+step};

];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


AMatch2J[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,DeviceArea$Ratio,topCell,botCell,topQE,botQE,botQErear,rawJscTop,rawJscBot,rearSpec,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
DeviceArea$Ratio=OptionValue[AreaRatio];

topCell=OptionValue[MaterialSystem][[1]];
botCell=OptionValue[MaterialSystem][[2]];
topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]];
If[MatchQ[botQE,{_List?(ArrayDepth@#==2&),_List?(ArrayDepth@#==2&)}], (* bottom QE for front and rear can be specified differently, if not will be assumed the same *)
	botQErear=Last@botQE;
	botQE=First@botQE;
,
	botQErear=botQE;
];
botQE=botQE\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); 
(* linearly DeviceArea weighted effective SubQE for bottom cell (front side) = weighted Si SubQE under top cell + weighted Si unshaded SubQE *)

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

(* add in rear illumination, assuming all will be absorbed by bottom cell *)
rearSpec=OptionValue@RearIllumination;
Switch[rearSpec,
	_?NumericQ, (* directly specifying the current *)
		rawJscBot+=rearSpec;,
	{_?NumericQ}, (* directly specifying the irradiance level *)
		rawJscBot+=First@rearSpec/1000*CalcJsc[specAM15G,botQErear];,
	{__List},
		rawJscBot+=CalcJsc[rearSpec,botQErear];
];

JscTop=topCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=botCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=topCell[rawJscTop,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]]*DeviceArea$Ratio,0];
AppendTo[V,topOutput[[3]]+botCell[rawJscBot,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J={jmax-step,jmax,jmax+step};
];

Return[Pmpp]
]


(* ::Subsection::Closed:: *)
(*GaAs/Si (to be deprecated) *)


AMatch$GaAsSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,DeviceArea$Ratio,topQE,botQE,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
DeviceArea$Ratio=OptionValue[AreaRatio];
topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); 
(* linearly DeviceArea weighted effective SubQE for bottom cell = weighted Si SubQE under top cell + weighted Si unshaded SubQE *)

JscTop=GaAsCell[spec,T,{"V",0},DeviceQE->topQE][[2]];
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE][[2]];

If[JscTop>JscBot,
Do[
topOutput=GaAsCell[spec,T,{"J",JscBot},DeviceQE->topQE,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,LuminescentCoupling->coupling][[2]];
,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=GaAsCell[spec,T,{"J",j},DeviceQE->topQE,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
AppendTo[V,topOutput[[3]]+SiCell[spec,T,{"J",j},DeviceQE->botQE,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J={jmax-step,jmax,jmax+step};

];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


(* ::Subsection::Closed:: *)
(*InGaP/Si*)


(* ::Text:: *)
(*This configuration with top cell larger than bottom cell doesn't make sense. Tandem efficiency always improves when bottom DeviceArea approaches top DeviceArea. *)


AMatch$InGaPSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,DeviceArea$Ratio,topQE,botQE,rawJscTop,rawJscBot,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
DeviceArea$Ratio=OptionValue[AreaRatio];
topQE=OptionValue[SubQE][[1]];
botQE=OptionValue[SubQE][[2]]\[Transpose]/{1,DeviceArea$Ratio}//Transpose;

topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];
rawJscTop=CalcJsc[spec,topQE]; 
rawJscBot=CalcJsc[spec,botQE];

JscTop=InGaPCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

If[JscTop>JscBot,

Do[
topOutput=InGaPCell[rawJscTop,T,{"J",JscBot},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
JscBot=SiCell[rawJscBot,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
,3];

];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=InGaPCell[rawJscTop,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
AppendTo[V,topOutput[[3]]+SiCell[rawJscBot,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J={jmax-step,jmax,jmax+step};

];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


(* ::Subsection::Closed:: *)
(*perovskite/Si (to be deprecated) *)


(* ::Subsubsection::Closed:: *)
(*version 1: 5 parameter model perovskite*)


AMatch$2DiodePerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,DeviceArea$Ratio,topQE,botQE,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
DeviceArea$Ratio=OptionValue[AreaRatio];

topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); (* linearly DeviceArea weighted effective SubQE for bottom cell *)
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

JscTop=TwoDiodePerovskiteCell[rawJscTop,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

If[JscTop>JscBot&&calcPRLC,
Do[
topOutput=TwoDiodePerovskiteCell[spec,T,{"J",JscBot},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=TwoDiodePerovskiteCell[spec,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]]*DeviceArea$Ratio,0];
AppendTo[V,topOutput[[3]]+SiCell[spec,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J={jmax-step,jmax,jmax+step};

];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


AMatch$2DiodePerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,DeviceArea$Ratio,topQE,botQE,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
DeviceArea$Ratio=OptionValue[AreaRatio];

topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); (* linearly DeviceArea weighted effective SubQE for bottom cell *)
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

JscTop=TwoDiodePerovskiteCell[spec,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=TwoDiodePerovskiteCell[spec,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]]*DeviceArea$Ratio,0];
AppendTo[V,topOutput[[3]]+SiCell[spec,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J={jmax-step,jmax,jmax+step};
];

Return[Pmpp]
]


(* ::Subsubsection::Closed:: *)
(*version 2: physics-based model perovskite*)


AMatch$PerovskiteSi[spec_,T_,opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,DeviceArea$Ratio,topQE,botQE,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
DeviceArea$Ratio=OptionValue[AreaRatio];

topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); (* linearly DeviceArea weighted effective SubQE for bottom cell *)
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

JscTop=PerovskiteCell[spec,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

If[JscTop>JscBot&&calcPRLC,
Do[
topOutput=PerovskiteCell[spec,T,{"J",JscBot},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->True];
coupling=\[Eta]12*topOutput[[4]]*DeviceArea$Ratio;
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[2]];
,3];
];
Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=PerovskiteCell[spec,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]]*DeviceArea$Ratio,0];
AppendTo[V,topOutput[[3]]+SiCell[spec,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
jmax=Extract[J,First@Position[P,n_/;n==Max[P]]];
J={jmax-step,jmax,jmax+step};

];

IV=Reverse[SortBy[DeleteDuplicatesBy[IV,#[[2]]&],#[[2]]&]];
P=IV[[All,3]];
Voc=Last[IV[[All,1]]];
{{Vmpp,Jmpp,Pmpp}}=Extract[IV,Position[P,n_/;n==Max[P]]];
FF=Pmpp/(Jsc*Voc);

{IV[[All,{1,2}]],Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,JscTop,JscBot}
]


AMatch$PerovskiteSi[spec_,T_,"mpp",opt:OptionsPattern[]]:=Module[{\[Eta]12,calcPRLC=False,DeviceArea$Ratio,topQE,botQE,topCellParameters,botCellParameters,IV,Jsc,Voc,FF,Pmpp,Jmpp,Vmpp,coupling,topOutput,step,J,V,P,JscTop,JscBot,jmax},
\[Eta]12=OptionValue[CouplingEfficiency];
If[\[Eta]12>0,calcPRLC=True];
DeviceArea$Ratio=OptionValue[AreaRatio];

topQE=OptionValue[SubQE][[1]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE=OptionValue[SubQE][[2]]\[Transpose]*{1,DeviceArea$Ratio}//Transpose;
botQE[[All,2]]+=Interpolation[OptionValue[SubQE][[3]],InterpolationOrder->1][botQE[[All,1]]]*(1-DeviceArea$Ratio); (* linearly DeviceArea weighted effective SubQE for bottom cell *)
topCellParameters=OptionValue[SubCells][[1]];
botCellParameters=OptionValue[SubCells][[2]];

JscTop=PerovskiteCell[spec,T,{"V",0},DeviceQE->topQE,DeviceParameters->topCellParameters][[2]];
JscBot=SiCell[spec,T,{"V",0},DeviceQE->botQE,DeviceParameters->botCellParameters][[2]];

Jsc=Min[JscTop,JscBot];

step=Abs[Jsc/5];
J=Range[Jsc,0,-step];
IV={};
While[Abs[step]>=Jsc*0.01,
V={};

Do[
topOutput=PerovskiteCell[spec,T,{"J",j},DeviceQE->topQE,DeviceParameters->topCellParameters,OutputCoupling->calcPRLC];
coupling=If[calcPRLC,\[Eta]12*topOutput[[4]]*DeviceArea$Ratio,0];
AppendTo[V,topOutput[[3]]+SiCell[spec,T,{"J",j},DeviceQE->botQE,DeviceParameters->botCellParameters,LuminescentCoupling->coupling][[3]]]
,
{j,J}];

P=J*V;
IV=Join[IV,Transpose[{V,J,P}]];
step=step/2;
Pmpp=Max[P];
jmax=Extract[J,First@Position[P,n_/;n==Pmpp]];
J={jmax-step,jmax,jmax+step};
];

Return[Pmpp]
]


(* ::Chapter:: *)
(*End*)


(* ::Text:: *)
(*Protect Symbols. *)


(*Protect[SiCell,GaAsCell,InGaPCell,TwoDiodePerovskiteCell,PerovskiteCell];
Protect[TwoTer2J,TwoTer$GaAsSi,TwoTer$InGaPSi,TwoTer$InGapGaAsSi,TwoTer$2DiodePerovskiteSi,TwoTer$PerovskiteSi,
FourTer2J,FourTer$GaAsSi,FourTer$InGaPSi,FourTer$2DiodePerovskiteSi,FourTer$PerovskiteSi,
VMatch2J,VMatch$GaAsSi,VMatch$InGaPSi,VMatch$2DiodePerovskiteSi,VMatch$PerovskiteSi,
ThreeTer2J,ThreeTer$GaAsSi,ThreeTer$InGaPSi,ThreeTer$2DiodePerovskiteSi,ThreeTer$PerovskiteSi,
AMatch2J,AMatch$GaAsSi,AMatch$InGaPSi,AMatch$2DiodePerovskiteSi,AMatch$PerovskiteSi];*)


End[]; 

EndPackage[]; 
