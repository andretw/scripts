import java.security.MessageDigest;
String encryptionAlgorithm = "SHA-1";

//{APP-KEY}+{XQNAP-APP-ID}+{XQNAP-TIME}+{XQNAP-APP-VER
String valueToEncrypt = vars.get("appKey")+vars.get("appId")+vars.get("appTime")+vars.get("appVer");

MessageDigest msgDgst = MessageDigest.getInstance(encryptionAlgorithm);
byte[] mdbytes = new byte[40];
msgDgst.update(valueToEncrypt.getBytes(), 0, valueToEncrypt.length());
mdbytes = msgDgst.digest();

StringBuffer sb = new StringBuffer();
for (int i = 0; i < mdbytes.length; i++) {
    sb.append(Integer.toString((mdbytes[i] & 0xff) + 0x100, 16).substring(1));
}

vars.put("myCheck", sb.toString());
