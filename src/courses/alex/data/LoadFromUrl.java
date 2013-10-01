package courses.alex.data;

import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

public class LoadFromUrl {

	static String URL = "http://media.oboobs.ru/boobs/04748.jpg";
	static String prefixSrc = "F:\\New folder\\CSSP\\WebContent\\resources\\images\\";
	private static String path = "F:\\ws\\test\\WebContent\\WEB-INF\\config\\data.xml";

	public static void loadImage(String url, String galleryName) {
		try {
			String src = prefixSrc;
			src += galleryName;
			src += "\\";
			String imgName = getFileName(url);
			src += getFileName(url);
			addImgToXmlData(imgName, galleryName);
			BufferedImage img = ImageIO.read(new URL(url));
			File file = new File(src);
			if (!file.exists()) {
				file.createNewFile();
			}
			ImageIO.write(img, "jpg", file);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String getFileName(String url) {
		String name = "";
		for (int i = (url.length() - 1); i >= 0; i--) {
			char symbol = url.charAt(i);
			if (symbol == '/')
				break;
			name += symbol;
		}
		return new StringBuffer(name).reverse().toString();
	}

	private static void addImgToXmlData(String imgName, String galleryName) {
		NodeList nList = null;
		try {
			File fXmlFile = new File(path);

			DocumentBuilderFactory dbFactory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);

			doc.getDocumentElement().normalize();

			nList = doc.getElementsByTagName("gallery");

			int len = nList.getLength();
			for (int i = 0; i < len; i++) {
				Node nNode = nList.item(i);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					String name = eElement.getAttribute("name");
					if (name.equals(galleryName)) {
						Element img = doc.createElement("image");
						img.setAttribute("src", imgName);
						img.setAttribute("effect", "");
						img.setAttribute("contrast", "");
						img.setAttribute("sharpness", "");
						img.setAttribute("moving", "");
						img.setAttribute("scrollSpeed", "");
						eElement.appendChild(img);
					}
				}
			}

			doc.getDocumentElement().normalize();
			TransformerFactory transformerFactory = TransformerFactory
					.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(path));
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.transform(source, result);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public static void main(String[] args) {
		loadImage(URL, "TestGallery");
	}
}