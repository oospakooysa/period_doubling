//Below for the CA Investigations  ---------------------------------------------

enum cellTypeEnum {
  CELL_BUILDING,
  CELL_WATER,
  CELL_LAND,
  CELL_POLLUTED,
  CELL_ROAD,
  CELL_TREE,
  CELL_BRIDGE,
  CELL_NONE
};

// Below for ANN Investigations ------------------------------------------------

struct connexions {
  var() int fromID;
  var() int toID;
//  var() float weight;
};

struct parameters {
  var() int neuronID;
  var() int layer;
};

struct training {
  var() int neuronID;
  var() float value;
};

// For each neuron.

struct outputs {
  var MAS14_neuron neuron;
  var int neuronID;
};

struct inputs {
  var MAS14_Neuron neuron;
  var int neuronID;
  var float weight;
};

struct inputstr {
  var int neuronID;
  var float value;
};

struct outputstr {
  var int neuronID;
  var float value;
};

// -----------------------------------------------------------------------------

var MAS14_PlayerController pc;
var DynamicLightEnvironmentComponent LightEnvironment;

// Variables associated with logging to a file to be imported into Excel
var FileLog flog;
var string filename;
var(MAS14) string logFileName;
var(MAS14) float logInterval;
var int columnWidth;

var(MAS14) string actorName;   // name of actor to appear on the HUD
var bool bRunning;        // simulation running or halted.

function Actor_Initialize(PlayerController newPlayer){
  //get handle on player controller (and hence the player)
  if(NewPlayer.IsA('MAS14_PlayerController')){
    pc = MAS14_PlayerController(newPlayer);
  }
}

// Stub functions which are embodied in sub-classed actors ---------------------

// Called by PlayerController to get the required vals sent to the HUD
// Revised function (Dec-2012) to allow individ specification of line colors.
function SendValuesToHUDX( out array<string> HUDLine, out array<Color> LineCol);

//Calld when tracehit - general function for all sub-classes. User may define
// this function body within their sub-classed actor
function CallAction();

//process input
function ProcessKey(int controllerID,name key,EInputEvent eventType);

//change a value for the actor via the user console
function SetParam(string paramName,float paramValue);

// toggles out all console commands
//function tidyUp();

// Highlight the actor on cursor click a-la MIH56 ------------------------------

function SetHighlight(bool bHighlighted){
  local StaticMeshComponent smc;
  local LinearColor highlightColor;

  highlightColor.R = 0;
  highlightColor.G = 255;
  highlightColor.B = 0;
  highlightColor.A = 255;

  if(bHighlighted){
	forEach ComponentList(class'StaticMeshComponent',smc)
	{
		LightEnvironment.AmbientGlow = highlightColor;
		LightEnvironment.ResetEnvironment();

	}
	SetTimer(0.5,false,'restoreMat');
  }
  else{
	forEach ComponentList(class'StaticMeshComponent',smc)
	{

		LightEnvironment.AmbientGlow.R = 0;
		LightEnvironment.AmbientGlow.G = 0;
		LightEnvironment.AmbientGlow.B = 0;
		LightEnvironment.AmbientGlow.A = 0;
		LightEnvironment.ResetEnvironment();

	}
  }
}

function RestoreMat(){  //timer function called to restore materials after 1 sec
  SetHighlight(false);
}

// -----------------------------------------------------------------------------

// ======================== Logging to File Functions ==========================

function openLogFile() {
  // set up the logging files.
  flog = spawn(class'FileLog');
  filename = logFileName;
  flog.Openlog(filename,".txt",true);   // true means create unique filename.
}

function writeLogFileHeader(array<String>headerArray) {

  local int i;
  local String header;
  local String str;

  header = "";
  str = "";

  for(i=0;i<headerArray.length;i++)  {
    str = pad(headerArray[i],columnWidth);
    header = header$str$",";      // replace with some formatting.
  }

  flog.logF(header);
  flog.logF(" ");

}

function writeLogFileLine(String str) {
  flog.logF(str);
}

function writeLogFileRecord(array<float> dataArray) {

  local int i;
  local String record;
  local String str;

  record = "";
  str = "";

  for(i=0;i<dataArray.length;i++) {
    str = pad(""$dataArray[i],columnWidth);
    record = record$str$",";
  }

  flog.logF(record);

}

function string pad(String str, int nrChars) {

  local int leng;
  local int diff;
  local int ii;
  local string padded;

  padded = str;
  leng = Len(str);
  diff = nrChars - leng;
  for(ii=0;ii<diff;ii++) padded = padded$" ";
  return padded;

}

function closeLogFile() {
  flog.Closelog();
}

// =============================================================================

defaultProperties
{

  Begin Object class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
    bEnabled=TRUE
    bCastShadows = true;
  End Object

  LightEnvironment=MyLightEnvironment  //handle for accessing lightEnv
  Components.Add(MyLightEnvironment) //add to the actor

  bEdShouldSnap = true //snap to grid in editor

  //enable collision
  bCollideActors=true
  bCollideWorld = true
  bBlockActors=true

  columnWidth=20

}

