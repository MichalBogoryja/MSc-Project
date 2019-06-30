/* Include the controller definition */
#include "epuck_obstacleavoidance.h"
/* Function definitions for XML parsing */
#include <argos3/core/utility/configuration/argos_configuration.h>
/* 2D vector definition */
#include <argos3/core/utility/math/vector2.h>

/****************************************/
/****************************************/

CEPuckObstacleAvoidance::CEPuckObstacleAvoidance() :
   m_pcWheels(NULL),
   m_pcProximity(NULL),
   m_fWheelVelocity(2.5f) {}

/****************************************/
/****************************************/

void CEPuckObstacleAvoidance::Init(TConfigurationNode& t_node) {
   /*
    * Get sensor/actuator handles
    *
    * The passed string (ex. "differential_steering") corresponds to the
    * XML tag of the device whose handle we want to have. For a list of
    * allowed values, type at the command prompt:
    *
    * $ argos3 -q actuators
    *
    * to have a list of all the possible actuators, or
    *
    * $ argos3 -q sensors
    *
    * to have a list of all the possible sensors.
    *
    * NOTE: ARGoS creates and initializes actuators and sensors
    * internally, on the basis of the lists provided the configuration
    * file at the <controllers><epuck_obstacleavoidance><actuators> and
    * <controllers><epuck_obstacleavoidance><sensors> sections. If you forgot to
    * list a device in the XML and then you request it here, an error
    * occurs.
    */
   m_pcWheels    = GetActuator<CCI_DifferentialSteeringActuator>("differential_steering");
   m_pcProximity = GetSensor  <CCI_ProximitySensor             >("proximity"    );
   m_battery_sensor = GetSensor <CCI_BatterySensor>("battery");
   m_pcLight = GetSensor <CCI_LightSensor>("light");
   /*
    * Parse the configuration file
    *
    * The user defines this part. Here, the algorithm accepts three
    * parameters and it's nice to put them in the config file so we don't
    * have to recompile if we want to try other settings.
    */
   GetNodeAttributeOrDefault(t_node, "velocity", m_fWheelVelocity, m_fWheelVelocity);
}

/****************************************/
/****************************************/

void CEPuckObstacleAvoidance::ControlStep() {
   /* Get the highest reading in front of the robot, which corresponds to the closest object */
   CCI_BatterySensor::SReading reading = m_battery_sensor->GetReading();

   std::cout << reading.AvailableCharge << std::endl;
   std::cout << reading.TimeLeft << std::endl;

   if(reading.AvailableCharge < 0.999){
       m_pcWheels->SetLinearVelocity(0, 0);
       m_battery_sensor->Reset();

   }
   else {

       Real fMaxReadVal = m_pcProximity->GetReadings()[0];
       UInt32 unMaxReadIdx = 0;
       if (fMaxReadVal < m_pcProximity->GetReadings()[1]) {
           fMaxReadVal = m_pcProximity->GetReadings()[1];
           unMaxReadIdx = 1;
       }
       if (fMaxReadVal < m_pcProximity->GetReadings()[7]) {
           fMaxReadVal = m_pcProximity->GetReadings()[7];
           unMaxReadIdx = 7;
       }
       if (fMaxReadVal < m_pcProximity->GetReadings()[6]) {
           fMaxReadVal = m_pcProximity->GetReadings()[6];
           unMaxReadIdx = 6;
       }
       /* Do we have an obstacle in front? */
       if (fMaxReadVal > 0.0f) {
           /* Yes, we do: avoid it */
           if (unMaxReadIdx == 0 || unMaxReadIdx == 1) {
               /* The obstacle is on the left, turn right */
               m_pcWheels->SetLinearVelocity(m_fWheelVelocity, 0.0f);
           } else {
               /* The obstacle is on the left, turn right */
               m_pcWheels->SetLinearVelocity(0.0f, m_fWheelVelocity);
           }
       } else {
           /* No, we don't: go straight */
           m_pcWheels->SetLinearVelocity(m_fWheelVelocity, m_fWheelVelocity);
       }

   }

    //m_pcWheels->SetLinearVelocity(m_fWheelVelocity, m_fWheelVelocity);
}
/*
CVector2 CEPuckObstacleAvoidance::CalculateVectorToLight() {
    /* Get readings from light sensor *
    const CCI_EpuckLightSensor::TReadings& tLightReads = m_pcLight->GetReadings();
    /* Sum them together *
    CVector2 cAccumulator;
    for(size_t i = 0; i < tLightReads.size(); ++i) {
        cAccumulator += CVector2(tLightReads[i].Value, tLightReads[i].Angle);
    }
    /* If the light was perceived, return the vector *
    if(cAccumulator.Length() > 0.0f) {
        return CVector2(1.0f, cAccumulator.Angle());
    }
        /* Otherwise, return zero *
    else {
        return CVector2();
    }
}
*/
/****************************************/
/****************************************/

/*
 * This statement notifies ARGoS of the existence of the controller.
 * It binds the class passed as first argument to the string passed as
 * second argument.
 * The string is then usable in the configuration file to refer to this
 * controller.
 * When ARGoS reads that string in the configuration file, it knows which
 * controller class to instantiate.
 * See also the configuration files for an example of how this is used.
 */
REGISTER_CONTROLLER(CEPuckObstacleAvoidance, "epuck_obstacleavoidance_controller")
