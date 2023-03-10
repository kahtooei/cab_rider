import 'package:cab_rider/config/firebase_options.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleDirectionsAPI {
  Future<String> getDirections(LatLng startPosition, LatLng endPosition) async {
    String _url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=${DefaultFirebaseOptions.android.apiKey}";

    var client = http.Client();
    var response = await client.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      // return response.body;
      return sampleDirectionResult;
    } else {
      return '';
    }
  }
}

const String sampleDirectionResult = """
{
  "geocoded_waypoints":
    [
      {
        "geocoder_status": "OK",
        "place_id": "ChIJ8f21C60Lag0R_q11auhbf8Y",
        "types": ["locality", "political"]
      },
      {
        "geocoder_status": "OK",
        "place_id": "ChIJgTwKgJcpQg0RaSKMYcHeNsQ",
        "types": ["locality", "political"]
      }
    ],
  "routes":
    [
      {
        "bounds":
          {
            "northeast": { "lat": 40.4165207, "lng": -3.7026134 },
            "southwest": { "lat": 39.862808, "lng": -4.029406799999999 }
          },
        "copyrights": "Map data ©2022 Inst. Geogr. Nacional",
        "legs":
          [
            {
              "distance": { "text": "74.3 km", "value": 74327 },
              "duration": { "text": "57 mins", "value": 3446 },
              "end_address": "Madrid, Spain",
              "end_location": { "lat": 40.4165207, "lng": -3.705076 },
              "start_address": "Toledo, Spain",
              "start_location": { "lat": 39.862808, "lng": -4.0273727 },
              "steps":
                [
                  {
                    "distance": { "text": "0.6 km", "value": 615 },
                    "duration": { "text": "2 mins", "value": 106 },
                    "end_location":
                      { "lat": 39.8681019, "lng": -4.029378299999999 },
                    "html_instructions": "Head <b>northwest</b> on <b>Av. de la Reconquista</b> toward <b>C. de la Diputación</b>",
                    "polyline":
                      {
                        "points": "quhrF`rqWCBQJUJm@PQFg@Ni@JeBh@}@XaD|@{@Vk@Ns@RUFoA^u@R_AXwA`@WHMBG@C?E?GAC?IC"
                      },
                    "start_location": { "lat": 39.862808, "lng": -4.0273727 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.2 km", "value": 174 },
                    "duration": { "text": "1 min", "value": 24 },
                    "end_location": { "lat": 39.8675297, "lng": -4.0275807 },
                    "html_instructions": "At the roundabout, take the <b>1st</b> exit onto <b>C. Duque de Lerma</b>",
                    "maneuver": "roundabout-right",
                    "polyline":
                      {
                        "points": "svirFr~qW?AAEAEACACACCCACF_@H[FQNi@j@cB`@qAHW"
                      },
                    "start_location":
                      { "lat": 39.8681019, "lng": -4.029378299999999 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.6 km", "value": 594 },
                    "duration": { "text": "2 mins", "value": 91 },
                    "end_location": { "lat": 39.8688577, "lng": -4.021535 },
                    "html_instructions": "At the roundabout, take the <b>3rd</b> exit onto <b>Av. Gral. Villalba</b><div style='font-size:0.9em'>Go through 1 roundabout</div>",
                    "maneuver": "roundabout-right",
                    "polyline":
                      {
                        "points": "asirFjsqW@?@??A@?@A@A@?DI@C@C@A@C@C@CDS?A@O?G@G?GAKAA?AAAAA?CAAA?AAAAAAA?AAA?A?AAA?A?A?C@A?A?A@A@A??@A@CBQMIIEEACISCIIWEQEMI[Oi@?CYy@@E?K?A?A?AAA?A?AA??A?AAAAA?AA??AA??AA?A??AA?A?A?A?UcAOi@Mi@Mk@I]AMCOAQAQCWCeA?A?k@EuCCaCA{@?O"
                      },
                    "start_location": { "lat": 39.8675297, "lng": -4.0275807 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.2 km", "value": 198 },
                    "duration": { "text": "1 min", "value": 29 },
                    "end_location": { "lat": 39.8700417, "lng": -4.0208568 },
                    "html_instructions": "At the roundabout, take the <b>3rd</b> exit onto <b>Av. de Madrid</b>",
                    "maneuver": "roundabout-right",
                    "polyline":
                      {
                        "points": "k{irFrmpW@A@A@A@A@A?A@A@A?A@A?A@A?C?A@A?C?C?C?A?CAC?AAC?AAAACAAA??AAAAAC?AAA?A?A?A?AAA@A?A?A?]W_@U{@a@o@YGACAKBE@A@A@EDCFAH?F?H"
                      },
                    "start_location": { "lat": 39.8688577, "lng": -4.021535 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.4 km", "value": 415 },
                    "duration": { "text": "1 min", "value": 57 },
                    "end_location": { "lat": 39.8737356, "lng": -4.0207605 },
                    "html_instructions": "Turn <b>right</b> to stay on <b>Av. de Madrid</b>",
                    "maneuver": "turn-right",
                    "polyline":
                      {
                        "points": "wbjrFjipWEFCBABC@E@E@G?M?a@Aq@CsBCK?s@As@CcCE{@?{AEo@AGAOECAMA"
                      },
                    "start_location": { "lat": 39.8700417, "lng": -4.0208568 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "1.1 km", "value": 1065 },
                    "duration": { "text": "1 min", "value": 67 },
                    "end_location": { "lat": 39.8830007, "lng": -4.0190202 },
                    "html_instructions": "At the roundabout, take the <b>2nd</b> exit onto the <b>A-42</b> ramp to <b>Madrid</b>",
                    "maneuver": "roundabout-right",
                    "polyline":
                      {
                        "points": "{yjrFvhpW?C?CAC?AACAAACAAAACAAAAACAC?A?AAA@C?A?A?A@A?C@A?A@C@A@ABA@AB?@ABE?A?KDGDG@I@KBo@AWAoCEQEW?[A[AgAAu@CiBEi@EKCyAMiAM[G_@I[Mk@S_@Qa@QICWKQGKEICICYGIAIAKAQCUCO?Q?OAS?]?I?G?g@@EAG?GAG?IAIAGCKAYI[KCAo@WmAe@q@SMCiAS_@B"
                      },
                    "start_location": { "lat": 39.8737356, "lng": -4.0207605 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "19.2 km", "value": 19159 },
                    "duration": { "text": "11 mins", "value": 650 },
                    "end_location":
                      { "lat": 40.0333486, "lng": -3.925665899999999 },
                    "html_instructions": "Merge onto <b>A-42</b>",
                    "maneuver": "merge",
                    "polyline":
                      {
                        "points": "wslrFz}oWKA]C[CS?UA[@u@@kBFaBFsBBS@c@?A?iA?mCAG?Y?eACS?I?{@ESCK?QCKASAGAMAIC_@Ea@GUE_AQSEOC[GICSEOEMC[I]I]I[I_@KGACACAYGMCUG[I_@Ka@KuBg@]IC?i@Ok@Mu@OiAUKAMCA?C?eAQc@G]E{@MWCUEg@IAA[GSEOCwA[s@Qu@So@Oc@Ke@KKC_@Io@Qu@Q]ISGMC]I[GoBe@_Cm@kAYyA]i@QaBc@CA_A[gDuAGCy@]mAe@eCcAa@QQGw@]u@Y{Am@aAe@i@WKG_@S}@i@UOi@_@UOIEa@Ye@Ye@WOIu@]o@WSKMCSKEAsBu@YK[McC}@iE_BYMwDwAOGKESGsHsCgE}AWKg@QeC_AqIaDgC}@gC_AoBu@oAe@{Ak@qCeAeBq@cE{AmCcAkAc@QGQG[MmAe@qAg@MEqAg@_A]a@MeA]}@SICsAYw@M}B]cCa@UEKA}@OaGaAwASg@KOE[Ge@MICe@MGCs@UMEGA[M[KyAe@GCQEoAc@c@OwAc@_DeAYKUGeA]eAYICa@KA?s@Mg@Ia@Iq@ImBYaB_@UGEC}@Yg@QMGMEg@Uk@Wo@YECMIQIo@a@{@g@SOKGg@[mCmBaAs@SM{@o@]UmAu@q@[e@U{@e@SMKIQKGCGESKoDgCgGmEwCuBKI{AcAYQEA_@Sm@WgAc@IEEAw@W_Be@oBm@yAa@EAe@OaAYo@Su@Wc@Uq@_@EAe@Yg@[iDwBWQOKOK]UuBqA_@U}@m@gAs@[QaBiAq@e@WOECOIGGs@e@a@Yi@_@_@Y[WYUYWYWe@a@eB}Ae@_@c@[]WYQm@_@UOc@W_@SCA[QKGMGk@Y}@c@q@]yAs@UMIE_@UWO]S]WcAq@k@c@a@]QKc@][WUQ]Yo@g@}AkAiCgBcC_BgCcBa@WSKg@]g@[MKKE_Am@OKiAq@uBoAm@]qAy@w@g@y@i@gAu@w@i@iCkB}B}AYSCAEE_@U}AeA_@U}@m@eAq@w@i@IGIG_BcAwA}@yBwAuGiEmUgOaMeIq@c@e@[ECKG_C}AmCeBmCeBcC_BiBkAmAy@wBuAwGkEkBmAQK_BeASMgAs@yDgCy@i@s@c@ECIGs@e@iCaBoAw@i@_@OKIEYQqAw@kBcAOIm@YKG[OSKICoB}@y@[uAg@u@YyAe@y@U]KgAYs@SwAY{@QICc@GOCwAU{@MwAQ{@IwAOa@C_AG{@Ee@AYA]A]A]?_@A]?y@?M?c@?}@@G?s@@M?Q@Y@K?W@e@@}@DSBM?O@aCPcAHmAJQ@[BWBy@Fu@FC?[BC@]B[@a@BYB]@c@By@BW@u@BcA?]?]?_@A]A]Ca@A[C]E[C]E_@E]G]G[G_@I]I]I[K_@KYKYK_@M[OYK]Q[O[QYO[SYQYQ[SYSYUWS[WWUYWUUWYWWWYWYUYUYU]UYU]S[U]S]Q]S]S_@Q_@Q]Qa@Q_@O_@Oa@Q_@Wq@GQMa@Qe@]cAM_@K_@Qg@M_@K]?CQi@IY[iAK_@Og@W}@EKACIYEK?CSq@k@mBi@iBK_@Oe@Og@e@aBi@kB[eAi@iBeAqDi@eBMc@}@uCm@oBSq@Ww@Wu@Us@M]Wq@[}@a@iAa@_AeAcCSe@c@_Ac@aA_AoB}@kBg@}@c@}@c@w@Ua@S[S]S]e@y@U]e@u@W_@QWk@{@_AsAk@u@OUW[W]MOIKOS[_@_AkAGGEEa@e@UWY[UWCEQQWY_@a@e@e@WWA?ACSQYYq@o@USWWYYYUEEcB{Au@m@wBgBOMgA{@AAm@g@m@e@k@c@eAy@o@i@YU[UYU}@s@m@e@]W}BiBkByA"
                      },
                    "start_location": { "lat": 39.8830007, "lng": -4.0190202 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "47.1 km", "value": 47071 },
                    "duration": { "text": "30 mins", "value": 1825 },
                    "end_location": { "lat": 40.3957623, "lng": -3.7039499 },
                    "html_instructions": "Keep <b>left</b> to stay on <b>A-42</b>",
                    "maneuver": "keep-left",
                    "polyline":
                      {
                        "points": "m_jsFlv}ViEkDWQsEqDu@m@]Yk@c@oAaAa@]IGKIa@[}@s@IIUQQMi@e@{@q@]YwAiAa@[e@_@UQyBeBw@o@m@e@oAaAu@m@yAkA]W?A]Wo@g@aF}Dq@i@oAcAWSQMAAMKWUq@g@mJuHo@g@q@i@eG}Ea@[CC]YoAcA}@q@g@c@[UWSo@i@YSWUOMKIWSWUYSQMKKKGKKQOWSWQWUo@e@YWWSYUUSYSi@c@YUYU}@u@}@s@WSWS[WKKWSUQSQs@g@_@[q@i@m@g@u@k@m@g@w@m@o@i@g@a@OKMMw@m@cBsAoDqCk@e@m@g@c@a@MKm@k@y@u@KIgAiA{A{AeBkBwCyCoBqBkAoAWWkBmBcAeAWWgAiAmAoAeAgA{@}@s@w@USa@a@w@y@e@g@u@w@QQ_@]KMKKoAqAaBeB}A_BGIAA}@_A_BaByA}AgAiAeAeACCk@q@SUS[U[Ua@Wc@Q_@Ui@Se@Qg@Og@K_@Me@Ki@Ie@EWMw@Gk@UoBSeBYmCMiAMeA[qCYmCIu@YyBE[UmBc@_EIy@_AeIK}@c@cE]sCa@sDAK]wCK_AQqASuBGc@yAuMk@cFCSE]?A?AACASAG?GCMESW_CAISkBUwB?CIi@MgAGa@Kq@WqA_@gBOm@_@gA_@iAc@iAISAASe@CIg@aAi@aAw@sA_@k@i@u@W[EEY_@OOs@w@i@k@c@_@e@a@SOm@c@[Uq@c@a@S_@SUMuAo@uBcA_@Qq@[wMoGYMOIwAq@_LiFCCkEsBgD_BqBaAuFmC_CgAeFgCq@_@sAu@iBcAgC_B_@W}@k@uBuAgCaBc@YWQa@WCC]UgDuBcBiAq@a@cBiAGCOK_@UWQQKc@YwDeCuA}@u@e@]UCCaCiBu@k@[YQQw@s@kAmA[]SUw@_Aq@}@o@}@U[g@w@i@_Ae@y@o@iA]o@_CwE[m@i@_Ak@_A{A{Bi@s@UYCCu@{@GEe@g@EEk@k@w@s@YWu@q@iA_AmA{@iAw@sAy@iCsAu@[qAs@}CcAaCq@aCk@w@OkEiAcEeAUGSGcAUqA[_AUeDy@aDy@cLwCoBi@aG{A]IqA]sD{@EAu@Sg@Mi@O]KsCq@qA]e@MkBe@yEoAu@SgBi@_A[sAe@MEaBk@uAe@y@Y{@YGA{@[CAyBs@SGaBm@yDoAeBo@i@QyCaAUIcBq@yAm@uB{@wFeCqAi@aBq@w@Y[KqBs@[KuAc@sBm@gAWiCm@wAYs@M_AOWEa@GSCQCYCUGqAQk@G{@K_@GyAY}A[}A]a@K_Be@ECy@WaA_@c@OSI[K_A]mDsAcA_@cBo@A?_@OkEaBmAe@KCiAe@}As@iB}@y@e@WMOIg@WoCiAsBw@s@WQIm@UgBq@m@Sy@[yCiAkAc@aA_@q@WwAg@uBy@}@[oAc@mA_@EAu@SQEmAY{@Sk@Oq@Sa@Mi@SEAaC}@qAe@uAi@A?kBq@wAk@kAi@cCmAi@Ww@]wAo@cBs@aC}@aC_ASGsCeAsCeA]Ma@Oe@Q]KmAe@OGOGQGgC_AaBm@gDoASIa@OiG{BiAa@mCcAYK]M{EgB}B{@]MmFoBWKYK_FiBKECAOGkCaAqDsA}FwBGCWKSGKEUIgAc@]K_@OcBo@]MA?]Mi@SGCMEMEYMcE{AsAi@kAa@kAe@CAEAWKGEi@Sw@_@c@UOIGEQKKIOIc@[e@_@i@e@OOUUa@c@Y]i@q@U]e@w@IOGMKO[m@Yq@Se@ACUk@Qg@KWSm@a@kAMa@k@eBCKy@cCM_@Qi@gAeDwAiEmAuD_@gAqDcLKYIWSk@{@mCk@aBk@cBKUEIKUAEQ]CGGM_@o@U]Y_@[a@]a@e@e@YWWSWUSMA?QMIEKGk@Yk@Uc@QUEWGg@KEAk@Gq@IaAEI@u@?W@{@Di@Ds@JA?E@oAR_APc@Fu@N}@NyAX{AV{@N{AXyAV{AXyB^uCf@sDn@{AXq@Lu@N}B^YFoAPkANs@BC@u@?m@CWAMAM?_AIw@Mk@MEAw@Ua@OOGc@QKGg@Uo@a@SO}@q@CCq@i@a@[aHsFeEeDm@g@o@i@q@i@g@_@_@YSOCCOKIGEEWQGEUQIEWWq@i@iCoB_BcAaB{@aBq@_A]]MqA_@{@SQEOCA?}@Oc@IE?A?QCmAM{@Gy@GA?_@CeFWkCOkBIyBKgBKyOy@G?MAYAs@ESCUA}DScCOa@C{BS}BYuB[yAY_Ce@yBg@}D_A{Cs@m@Mo@OoEeA}@UuCo@wCs@EAICMCYGiBa@eLiC}HiBmBc@_Bc@cAYm@Uu@[CA{@a@c@Ua@U[UECYQIG_@[g@c@][c@c@WYSW_@c@S[W_@S[S[O[U_@O]Q[M]O[ACK[Sg@EKGSK_@M_@GS]sAMk@Mm@CMKg@SeAI_@O{@Kq@GYu@kEUoAMu@e@iCSiA]kBWkAMc@Mg@Om@Y{@?AQi@_@{@e@aAuAgC{@mAsA{Aw@y@uAgAm@a@w@a@KGeBs@AA[KsAe@{Bo@GCc@Ma@KYIOEYIuCaA[M_@Qi@Uk@Yi@Yi@[}A}@MI_@UoAu@e@YqC_BsBmAUMeDqB{@g@i@[uCeB_@UaDmBgEeC_@U_Ak@_@Ue@Yy@e@iGsDeBcAs@c@i@]e@Ue@[IEiF}C_DkBwA{@SKmBiAuCeBGEyA{@MIcDmBmBiAaBaA}FiDaBaAi@]u@c@_@UeAo@uEoCcBaAwA}@sAw@yA{@aBaAaCwAcEcCu@a@OKeAq@iC_ByCaB_CuA{Aw@gB_AaDcBy@e@cB_AmEiCmBiA[SWO{A}@{A}@qAw@sAw@CA]UA?_@UiC{AKGWOGCSMy@a@w@]]Og@Ma@Ig@K]EOAa@C_@Ak@?c@Bw@Fc@DW@aAPkB^gDf@kEp@oInAcBX{@JiBZ_@F_@Fm@JgANiBZiBXc@FKBy@LoDj@G?eG`Am@Je@Fa@Fk@Jm@FsAHk@Bq@Am@Ak@Cs@Ia@IYI]K[Mi@YYSWOa@Yq@k@m@g@}@u@g@a@eByA}BkB{@s@MKc@]_Aw@}OsMaBsAuBcB]Y{AoA_@Yy@s@KG?AWSsBeBeCsBwBeBwAmA}BmBuBiBsAiAgByAa@_@wBeBcBuAGGAA_Aw@g@_@e@_@{AqAk@g@g@_@mAcAk@c@g@[c@Uc@Sm@S[I]I[G_@Ec@CCA_@AGAuDEgEWaBKgCOe@EyAIgAIs@Go@CkCQq@E{BIgAEa@A[AMAM?oBIs@EOAu@EGAI?s@G{@EoAIgAIA?G?aBKm@Ee@Cy@IWAYCyCSC?WCcAEKAC?OAsBOYCWAuDWIAMAE?u@G{@GKAuCW}Gm@o@GkAKc@EKAE?y@Im@GiAOiAOu@IgBSo@G_AIwAKqAIq@Ei@EsAIcAImCO{CUmCQSAWAe@CwBOWCWAKAc@CeAI[CG?EA]CaAGSAiEYw@GMAYAcAIwIm@A?IAIAmDS?AsBMI?{@Gk@EcAGsAKWAgBMQAk@Eg@Eg@E_@A_@CGA[CG?QAKAoAGq@AYCY?oAGoCK]?q@EUAiBIWCkAG}BMmF[aAGm@EkBMMAK?}DWSAq@Ec@EKAC?a@CIAG?E?iAIaAGEA_CMs@EsAKWAkAIKAe@CcCOGA{BMgDSeBMe@E_@EI?QCYAa@AWAQ?M?MAK?KAOA[CYCy@KUEMAKAKC[EgAWWGoAWYG{Co@q@MMEA?s@QYIWIq@[m@]EAa@W]S]WWYMO[[a@c@e@e@o@q@SSUWEEUUUWa@c@UWQQcAeAg@k@mAoAIKGG_@c@SSw@}@QSa@k@e@w@e@y@q@cBm@mBs@eCe@_BWy@[eA_@qAg@cBM_@M[O_@O_@Sc@IOAAS_@QWGKOWMOMQW[SWSSKIIG{BqBQQMKCCAAA?SQSS_Ay@u@q@_@]CAAACCCCi@e@KKYWAAs@k@[Y][a@_@WUm@g@"
                      },
                    "start_location":
                      { "lat": 40.0333486, "lng": -3.925665899999999 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "1.7 km", "value": 1693 },
                    "duration": { "text": "1 min", "value": 88 },
                    "end_location": { "lat": 40.4001319, "lng": -3.7183967 },
                    "html_instructions": "Take exit <b>2A</b> to merge onto <b>M-30</b> toward <b>A-5</b>/<wbr/><b>Badajoz</b>/<wbr/><b>A-6</b>",
                    "maneuver": "ramp-right",
                    "polyline":
                      {
                        "points": "oxpuFtlrUIWEGGIEGAGEOAKAA?EAI?G@G?A?IBK@IBI?ADIDIDKJOHKLKHIJGDAFEDAFADADAP@H@BB@?HDDBFFBB@D@BBFBF@H?L?N@b@EHGFUd@Ud@CHg@tAQr@EPGTGRMj@?@Id@ABQ|@?l@?TETETEVCNADMl@q@rDKf@ENMj@ABCJ]tAENCJ?@Oh@ELIZMh@Oh@ENGXA@Of@Qj@Yx@Yr@Sf@_@`A]n@CFQ^CDCDEFEJEJ{BfD_AzAWb@MPINQXEHQCFOd@A@Oh@AB[|BAHIl@EREVIl@Ij@SzAEPER?j@@?HDn@@`@Fz@@LB~@FlA"
                      },
                    "start_location": { "lat": 40.3957623, "lng": -3.7039499 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.5 km", "value": 473 },
                    "duration": { "text": "1 min", "value": 36 },
                    "end_location": { "lat": 40.4026657, "lng": -3.7219427 },
                    "html_instructions": "Keep <b>left</b> to stay on <b>M-30</b>",
                    "maneuver": "keep-left",
                    "polyline":
                      {
                        "points": "ysquF~fuU?@T?H@V?V?HAd@?@Cj@Gf@EGXADCHCJGNABCBMRGFGFKJODQBMBM@K?KAGAQG]BC@I@OBC@SHEBIBUJa@ZYZKLKPGHMZIPUx@EDMPY@"
                      },
                    "start_location": { "lat": 40.4001319, "lng": -3.7183967 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.7 km", "value": 692 },
                    "duration": { "text": "1 min", "value": 35 },
                    "end_location":
                      { "lat": 40.40876859999999, "lng": -3.7214006 },
                    "html_instructions": "Keep <b>left</b> to stay on <b>M-30</b>",
                    "maneuver": "keep-left",
                    "polyline":
                      {
                        "points": "ucruFb}uUkAYDK?a@DYBc@BA?aAHi@FW@e@Du@BQ?c@?i@C]AC?KASCc@Gi@Kc@KYGECk@OoA_@q@UYKICy@UMEo@Iw@EyAA"
                      },
                    "start_location": { "lat": 40.4026657, "lng": -3.7219427 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.3 km", "value": 259 },
                    "duration": { "text": "1 min", "value": 28 },
                    "end_location": { "lat": 40.4110837, "lng": -3.721353 },
                    "html_instructions": "Slight <b>right</b> (signs for <b>Pᵒ V. del Puerto</b>/<wbr/><b>C/<wbr/> Segovia</b>)",
                    "maneuver": "turn-slight-right",
                    "polyline":
                      {
                        "points": "yisuFvyuUm@QMAk@BQ?Q@A?a@@A?S@M?A?Y?G@c@?U@G?i@@Q?A?O?E?G@S?A?K?UG"
                      },
                    "start_location":
                      { "lat": 40.40876859999999, "lng": -3.7214006 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.3 km", "value": 324 },
                    "duration": { "text": "1 min", "value": 55 },
                    "end_location": { "lat": 40.4139789, "lng": -3.7209563 },
                    "html_instructions": "Merge onto <b>P.º de la Virgen del Puerto</b>",
                    "maneuver": "merge",
                    "polyline":
                      { "points": "gxsuFlyuUkAAIAu@Co@Ew@GUCk@GGAmBSUAsAKm@G" },
                    "start_location": { "lat": 40.4110837, "lng": -3.721353 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.8 km", "value": 764 },
                    "duration": { "text": "2 mins", "value": 114 },
                    "end_location": { "lat": 40.413898, "lng": -3.7119377 },
                    "html_instructions": "Turn <b>right</b> onto <b>C. de Segovia</b>",
                    "maneuver": "turn-right",
                    "polyline":
                      {
                        "points": "kjtuF~vuUBu@?m@@_D?q@@kB@y@?e@?a@@{A@iC?C?e@?k@?mA?E?S@e@?}A?]?q@?u@?mC?i@?K?_@?M?O?C?G?]?I?W?_A?}A?M@c@?IAQ"
                      },
                    "start_location": { "lat": 40.4139789, "lng": -3.7209563 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.1 km", "value": 95 },
                    "duration": { "text": "1 min", "value": 26 },
                    "end_location":
                      { "lat": 40.4144408, "lng": -3.712543399999999 },
                    "html_instructions": "Turn <b>left</b> onto <b>C. de la Villa</b>",
                    "maneuver": "turn-left",
                    "polyline":
                      {
                        "points": "{ituFr~sUS?W?A?A?A@ERGZCHEREPELAD?@A@A@A?A@A?A?CAAAAA"
                      },
                    "start_location": { "lat": 40.413898, "lng": -3.7119377 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "84 m", "value": 84 },
                    "duration": { "text": "1 min", "value": 23 },
                    "end_location": { "lat": 40.414991, "lng": -3.7122205 },
                    "html_instructions": "<b>C. de la Villa</b> turns <b>right</b> and becomes <b>C. del Pretil de los Consejos</b>",
                    "polyline": { "points": "gmtuFjbtUEKCECCCCACEAC?iALEm@" },
                    "start_location":
                      { "lat": 40.4144408, "lng": -3.712543399999999 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "26 m", "value": 26 },
                    "duration": { "text": "1 min", "value": 8 },
                    "end_location":
                      { "lat": 40.4152243, "lng": -3.712259699999999 },
                    "html_instructions": "Turn <b>left</b> onto <b>C. del Sacramento</b>",
                    "maneuver": "turn-left",
                    "polyline": { "points": "uptuFj`tUm@F" },
                    "start_location": { "lat": 40.414991, "lng": -3.7122205 },
                    "travel_mode": "DRIVING"
                  },
                  {
                    "distance": { "text": "0.6 km", "value": 626 },
                    "duration": { "text": "3 mins", "value": 184 },
                    "end_location": { "lat": 40.4165207, "lng": -3.705076 },
                    "html_instructions": "Turn <b>right</b> onto <b>C. Mayor</b>",
                    "maneuver": "turn-right",
                    "polyline":
                      {
                        "points": "crtuFr`tUCMIaACYAOE]C[AAI{@?CSiBGk@ESE[UuAESAGCKIg@EWIm@Ge@?GIe@Ga@Ge@AC?IAG?CGo@Ek@Gq@Ek@?ICSEs@CYOiBCa@QkC"
                      },
                    "start_location":
                      { "lat": 40.4152243, "lng": -3.712259699999999 },
                    "travel_mode": "DRIVING"
                  }
                ],
              "traffic_speed_entry": [],
              "via_waypoint": []
            }
          ],
        "overview_polyline":
          {
            "points": "quhrF`rqWcHzBaNzDeG~A][?k@lA{Dr@mBR]HmA[WQDWE[g@mAeE?]QOeAcE[_EEuKHMCo@_@IyBoAgAYUd@KXWDmMUqFWKWi@ASR]L}A@yM[yEe@cCs@uCiAcCUiCAmBa@sDsAcCUcKHgLB}EScJ_BwLwCsOkCaQaEgOsDmIwCuGkCuJeE}DcCeG{CkPiGgx@eZuUyIeNyEwNcCcOoC_V{HcHuAkFeAaCy@uGiDeKiH{GuDmV}PcIwCaM}DqY{QuE_D_IyGoOmIwGqEoO}KqZoRqX_RqpA_z@qe@{ZgIoEgNgF{IqBqN_BsGOeGD}SrAwDTkIJqFa@oFmA_FuBqEyCcEaEkDaFqC{FmCqH{DwMiPij@kEyLkJcSwE_IaGmIgIoJkP_Oau@kl@a_A}t@i[}VwQyNkN}KoLkLu_@o`@cXyXiB_CuAoCkBcHyIqv@yIiw@i@sEmB_OoBgHcAeCuFeJsGiGqJcFoa@uRge@iUwb@mXaMcIyEoDqDmDqHcKsFkKmEiHyEmFqE}DuJaGgCoA_HuBiQkEk^cJim@qOoc@aO}HoCyOyGgHkCmHuBuL{BaMoByKeD_T_IaGcCkE{BuPwG_T_IaL}CoLeEqToJue@iQwm@aUi]iMkMyE{FeCyDqCaBgBoBwCgC{FgEiMoTip@gDeFaDiCcBw@yBk@eDYsCHyG`AwRlD_XvEsEf@iCGqDe@oBo@gCqAgCoBaVkRoA_A{IsGaHyCoD}@gGs@{WuAgTiA_N{@mMuBu]eI}_@{I_IwByCuAmEeDcEmFsBoEoB{G_BqIwEaWw@sCmDoHoCiDmCaCwE_CuIkC{E_B_D{AqPwJem@g^q|Aa~@iNiI_LaG}UkNeIyEmCqAoCs@oBMkDPi`@bGob@xGoEd@wDCmCi@wBkAgO_Ma^wYqc@{^cKqIiEcDqCgAiDa@gRy@{Fa@}Nq@iGYmXeB{^uC}JeAsOqAc^}B{v@gFeZqAuYgBwm@}DkGmA}EcAwCaAsBkA_B}AsE{EuGcH}BiC_DaGqGiTsBiE_CwCaEoDyI{HeCyB]q@KeAHm@jAyAbAKb@^JCjA_CnG_@fBSdCcBbJoCrKkDbJgFnIyAfCeAdFiAtHVnHHjFc@hD[j@k@`@y@HcAG{Af@sAvAu@pBSVY`@kAe@D{@HqCTeCJsDSuHuBqA_@oFc@wCFqFFkIi@_Fc@m@GBu@@mEB}FBkG@{I?sQ?mAo@?g@tBKFY_@uAFEm@m@FMoAOcB_@kD_AaGs@eFqAsQ"
          },
        "summary": "A-42",
        "warnings": [],
        "waypoint_order": []
      }
    ],
  "status": "OK"
}
""";
