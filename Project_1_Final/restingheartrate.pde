String val;
float averageHeartRate = 0;
ArrayList<Float> restingheartRates = new ArrayList<Float>();  



float restingheartrate(float averageHeartRate, int start_time) {
 
  
  if (averageHeartRate == 0) {
    while (millis() / 1000 - start_time < 30) {
     println(millis() / 1000 - start_time);
      if (myPort.available() > 0) {
        val = myPort.readStringUntil('\n');
        println(val);
        if (val != null) {
          print("enters");
          print(val);
          String[] list = split(val, ";");
          restingheartRates.add(Float.parseFloat(list[0]));
        }
      }
    }  
    
    int array_length = restingheartRates.size();
    
    ArrayList<Float> nonzeroHeartRates = new ArrayList<Float>();  
    for (int i = 0; i < array_length; i++) {
      if (restingheartRates.get(i) != 0) {
              nonzeroHeartRates.add(restingheartRates.get(i));
       }
    }


    
    array_length = nonzeroHeartRates.size();
    for (int i = 0; i < array_length; i++) {
      averageHeartRate = averageHeartRate + nonzeroHeartRates.get(i);
    }

    averageHeartRate = averageHeartRate/array_length;
    println("averageheartrate");
    println(averageHeartRate);

    return averageHeartRate;
  } else {
    println("averageheartrate");
    println(averageHeartRate);
    return averageHeartRate;
  }
}
