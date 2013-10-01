package courses.alex.data;

//import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.io.File;

public class DataProvider {
    // private static String path = "F:\\workspace\\CSSP\\WebContent\\images";
    private static String path           = "F:\\ws\\test\\WebContent\\WEB-INF\\config\\data.xml";
    private static String galleryTagName = "gallery";
    private static String prefixImage = "resources/images";

    private static NodeList getNodeList() {
        NodeList nList = null;
        try {
            File fXmlFile = new File(path);

            DocumentBuilderFactory dbFactory = DocumentBuilderFactory
                    .newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);

            doc.getDocumentElement().normalize();
            nList = doc.getElementsByTagName(galleryTagName);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return nList;
    }

    public static List<String> GetNamesOfGalleries() {
        List<String> names = new ArrayList<String>();
        NodeList nList = getNodeList();
        for (int i = 0; i < nList.getLength(); i++) {
            Node nNode = nList.item(i);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                names.add(eElement.getAttribute("name"));
            }
        }
        return names;
    }

    private static Image getImageContents(Node node, String nameGallery) {        
        Element eImage = (Element) node;
        Image image = new Image();
        String src = prefixImage;
        src += '/';
        src += nameGallery;
        src += '/';
        src += eImage.getAttribute("src");
        image.setUrl(src);
        image.setEffect(eImage.getAttribute("effect"));
        image.setContrast(eImage.getAttribute("contrast"));
        image.setSharpness(eImage.getAttribute("sharpness"));
        image.setMoving(eImage.getAttribute("moving"));
        image.setScrollSpeed(eImage.getAttribute("scrollSpeed"));
        return image;
    }

    public static List<Image> getGalleryContents(String galleryName) {
        List<Image> images = new ArrayList<Image>();
        NodeList nList = getNodeList();
        for (int i = 0; i < nList.getLength(); i++) {
            Node nNode = nList.item(i);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                String name = eElement.getAttribute("name");
                if (name.equals(galleryName)) {
                    NodeList subNode = eElement.getElementsByTagName("image");
                    for (int j = 0; j < subNode.getLength(); j++) {
                        Node image = subNode.item(j);
                        images.add(getImageContents(image, name));
                    }
                }
            }
        }
        return images;
    }

    public static class Test {
        public static void main(String[] args) {
            System.out.println(DataProvider.GetNamesOfGalleries());
            System.out.println(DataProvider.getGalleryContents("TestGallery"));
        }
    }
}
