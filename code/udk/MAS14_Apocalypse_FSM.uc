// ** Area for GLOBAL variables which can be seen by any function in this class.

//structures and enumerations **************************************************

enum stateEnum {
  STATE_RISING,
  STATE_FALLING,
  STATE_PAUSEATTOP,
  STATE_BRAKING,
  STATE_STOPPED
};
//static mesh components that make up this model--------------------------------
var StaticMeshComponent car;

// Parameters
var() float gravity;
var() float mmass;
var() float brakingForce;
var float releaseHeight;  // height at the top when the car is released.
var() float brakingHeight;
var() float pauseTime;

// Initial Conditions
var() float velyLift;     // winch velocity lifting the car to the top
var stateEnum carState;

// Timestep to advance the numerical solver.
var(MAS14) float deltaT;

// Internal variables. These are the "state" variables which are not editable.
var float velyZ;
var float dispZ;
var float accelZ;
var() float maxAcc;
var float time;

var float saveTime;

// Internal Constants. These may be used for conversions between units.
var float scaling;
var int itn;
var vector oldLoc;

var bool bFractured;

// functions********************************************************************

// Initialisation of this actor. do not change this. ---------------------------
function Actor_Initialize(PlayerController newPlayer){

  bRunning = false;

  super.Actor_Initialize(newPlayer);
  oldLoc = location;
  initializeVariables();
  setInitialConditions();
  visualization();

  openLogFile();
  setLogFileColumnLabels();

  setTimer(deltaT,true,'computeTimer');

}

// Sets the initial values for this actor. You will need to amend this code for
// your particular model.

function setInitialConditions() {
  time = 0;
  dispZ = 0;
  velyZ = velyLift;
  carState = STATE_RISING;

}

// Sets additional variables and constants.
function initializeVariables() {

  releaseHeight = 54.0;
  scaling = 52.5;
  accelZ = 0;

}

function reset() {
  bRunning=false;
  initializeVariables();
  setInitialConditions();
  bFractured = false;
  car.setHidden(false);
  visualization();
}

// Functions to set up data logging --------------------------------------------

// Sets the column labels in the data log file. One line of code for each label
function setLogFileColumnLabels() {
  local array<String> columnLabels;

  columnLabels.length = 0; //empty array.

  columnLabels[0] = "time";
  columnLabels[1] = "dispZ";
  columnLabels[2] = "velyZ";
  columnLabels[3] = "accelZ(ms2)";
  columnLabels[4] = "accelZ(Gs)";

  writeLogFileHeader(columnLabels);
}

// Here you specify which VARIABLES will be logged should agree with your
// column labels.
function logDataRecord() {

  local array<float> dataArray;

  dataArray.length = 0; //empty array.

  dataArray[0] = time;
  dataArray[1] = dispZ;
  dataArray[2] = velyZ;
  dataArray[3] = accelZ;
  dataArray[4] = accelZ/gravity;

  writeLogFileRecord(dataArray);

}

// function to log the data at the logInterval.
function logData() {
  local int m;
  m = int(logInterval/deltaT);
  if( itn % m == 0) logDataRecord();
}


// ============================ CVI ============================================

// do not touch this !!!!
function computeTimer(){

 if(bRunning) {
   computation(deltaT);
   visualization();
   logData();
   itn++;
   time += deltaT;
 }

}

// COMPUTATION =================================================================

// Here you will write your code based on your mathematical model --------------

function computation(float dT) {
// Any variable here is local to this function. You cannot access it outside
  // this function, e.g., you cannot sent it to the HUD.
  local float forceZ;

  // if we are not at the top then we must get there ---------------------------
  if ( carState == STATE_RISING ) {
    forceZ = 0.0;
    accelZ = forceZ/mmass;
    velyZ = velyLift;
    dispZ += velyZ*dT;

    if(dispZ >= releaseHeight) {  // have reached the top
      velyZ = 0;
      carState = STATE_PAUSEATTOP;
      saveTime = time;
    }
  }

  // we will delay at the top --------------------------------------------------
  if(carState == STATE_PAUSEATTOP) {

    if(time > (saveTime + pauseTime))    // wait until pause is finished
      carState = STATE_FALLING;

  }

  // we are falling ------------------------------------------------------------
  if(carState == STATE_FALLING) {
    forceZ = mmass*gravity;
    accelZ = forceZ/mmass;
    velyZ += accelZ*dT;
    dispZ += velyZ*dT;

    if(dispZ <= brakingHeight)
      carState = STATE_BRAKING;
    } 

    // we are braking ----------------------------------------------------------
    if(carState == STATE_BRAKING) {
      forceZ = mmass*gravity + brakingForce;
      accelZ = forceZ/mmass;
      velyZ += accelZ*dT;
      dispZ += velyZ*dT;

      if( velyZ >=0 )
        carState = STATE_STOPPED;
    }

    // we have stopped ---------------------------------------------------------
    if(carState == STATE_STOPPED)
      bRunning = false;
}

// =============================================================================

function Visualization(){

  local vector newVec;

  newVec =  oldLoc;
  newVec.Z = newVec.Z + (dispZ * scaling);
  setLocation(newVec);

  if(accelZ > maxAcc && !bFractured){
	spawn(class'MAS14_FM',self,,location,,,true);
	bFractured = true;
	car.setHidden(true);
  }
}

// INTERACTION =================================================================

// Send values to the HUD
function SendValuesToHUDX( out array<string> HUDLine, out array<Color> LineCol){

  HUDLine.length = 0; //empty array.

  HUDLine[0] = actorName;  // leave this alone
  HUDLine[1] = "Running: "@bRunning;
  HUDLine[2] = "Time: "@time;
  HUDLine[3] = "VelyZ: "@velyZ;
  HUDLine[4] = "dispZ: "@dispZ;
  HUDLine[5] = "accelZ: "@accelZ;
  HUDLine[6] = "accelZ (Gs): "@accelZ/9.8;
  HUDLine[7] = "State: "@carState;

  // Assign colors to each line on the HUD. No entry here will assign a default
  // value of light blue.
  LineCol.length = 0;
  LineCol[0] = MakeColor(255,255,0,255);
  LineCol[1] = MakeColor(255,0,0,255);
  LineCol[2] = MakeColor(0,0,255,255);

}

// Input parameters from the command line.
function SetParam(string paramName,float paramValue){
  WorldInfo.Game.Broadcast(self,paramName@paramValue);

  paramName = Caps(paramName); //capitalize so case insensitive

  if(paramName == Caps("gravity")){
    gravity = paramValue;
  }
  else if(paramName == Caps("mass")){
    mmass = paramValue;
  }
  else if(paramName == Caps("brakingHeight")){
    brakingHeight = paramValue;
  }
  else if(paramName == Caps("brakingForce")){
    brakingForce = paramValue;
  }
}

// associate any key with this experiment
function ProcessKey(int controllerID,name key,EInputEvent eventType){
  //WorldInfo.Game.Broadcast(self,"key pressed was:"@key);  //displays key pressed

  if(eventType == IE_Released){
    if(Key == 'F1'){
      bRunning = !bRunning; //toggles bRunning
    }

  }
}


defaultproperties  //***********************************************************
{
  Begin Object class=StaticMeshComponent Name=StaticMeshComponent1
    StaticMesh=StaticMesh'NJS_Extras.apocalypse.apocCarV2'
	LightEnvironment=MyLightEnvironment
	bUsePrecomputedShadows=FALSE
	Scale3D=(X=3.0,Y=3.0,Z=3.0)
  End Object
  Components.Add(StaticMeshComponent1)

  car = StaticMeshComponent1

  //enable collisions for actor (including traces)
  bCollideActors=true
  bBlockActors=true
  bCollideWorld=false

  //custom var defaults
  scaling=52.5
  brakingHeight=13.5
  gravity= -9.8
  maxAcc= 39.2
	pauseTime = 2
	brakingForce=39.2
	deltaT = 0.01
	velylift = 10
	mmass = 1
	
	logFileName="Apoc_FSM"
  logInterval=0.1
  actorName="MAS14_Robot_LF"
}