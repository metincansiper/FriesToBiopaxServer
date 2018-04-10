import java.io.IOException;
import java.util.LinkedHashMap;

import org.clulab.frext.FrextFormatter;
import org.json.simple.JSONObject;
import org.panda.frexttobiopax.FrextToBioPAX;

public class FriesToBiopax {
	
	public FriesToBiopax() {
	}
	
	public static String convert(JSONObject friesJson) {
		FrextFormatter frextFormatter = new FrextFormatter(null);
		FrextToBioPAX frextToBiopax = new FrextToBioPAX();
		
		LinkedHashMap frextRes = (LinkedHashMap) frextFormatter.friesToFrext(null, friesJson);
		
		try {
			frextToBiopax.addToModel(frextRes);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return frextToBiopax.convertToOWL();
	}
	
	public static void main(String[] args) {
		System.out.println("Working");
	}
}
