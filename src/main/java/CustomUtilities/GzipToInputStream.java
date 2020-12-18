package CustomUtilities;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

public class GzipToInputStream {
	
	public static InputStream getStreamData(byte[] data) {
		InputStream inputStream = new ByteArrayInputStream(data);
		return inputStream;
	}

}
