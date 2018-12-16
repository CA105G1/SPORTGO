package importImgIntoDB
裡面的程式，是方便各位把圖片初始化，
(預先動作，請把各位對應的圖片，放進git\SPORTGO\InitDB\image\YourTableName)
(圖檔，檔名，請用該PK的值，否則無法存入)

第一步，find mainAllimageIntoDB.java

第二步，設定
private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
private static final String USER = "CA105_WEB";
private static final String PASSWORD = "123456";

第三步，設定
第18行
// 請設定pull到本地端的實際路徑，如--->C:\Users\wenshock\git\SPORTGO\InitDB\image
String rootPath = "C:\\image";
(現階段，依舊取本地端資料)

第四步，執行mainAllimageIntoDB.java 的main，換言之， java application