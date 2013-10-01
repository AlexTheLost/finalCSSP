package courses.alex.servlets;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 * Servlet implementation class saveGalleryData
 */
public class saveGalleryData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public saveGalleryData() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");

		String data = request.getParameter("data");
		addImgToXmlData(data);
		
		String galleryName = request.getParameter("galleryName");
		request.setAttribute("galleryName", galleryName);
        RequestDispatcher dispatcher = getServletContext()
                .getRequestDispatcher("/gallery.jsp");
        dispatcher.forward(request, response);
	}

	private static String path = "F:\\ws\\test\\WebContent\\WEB-INF\\config\\data.xml";

	private static void addImgToXmlData(String data) {
		try {
			File fXmlFile = new File(path);

			DocumentBuilderFactory dbFactory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			Document dataDoc = dBuilder.parse(new InputSource(
					new ByteArrayInputStream(data.getBytes("utf-8"))));

			doc.getDocumentElement().normalize();
			dataDoc.getDocumentElement().normalize();

			NodeList nListFromFile = doc.getElementsByTagName("gallery");
			Element eListFromData = (Element) dataDoc.getElementsByTagName(
					"gallery").item(0);

			String galleryNameData = eListFromData.getAttribute("name");
			NodeList nListDataDoc = dataDoc.getElementsByTagName("image");

			int len = nListFromFile.getLength();
			for (int i = 0; i < len; i++) {
				Node eNode = nListFromFile.item(i);
				Element eElement = (Element) eNode;
				String name = eElement.getAttribute("name");
				if (name.equals(galleryNameData)) {
					NodeList subNode = eElement.getElementsByTagName("image");
					int leng = subNode.getLength();
					for (int j = 0; j < leng; j++) {
						Node image = subNode.item(0);
						Element imageElement = (Element) image;
						eElement.removeChild(imageElement);
					}
					leng = nListDataDoc.getLength();
					for (int p = 0; p < leng; p++) {
						Node imageDataDoc = nListDataDoc.item(p);
						Element imageDataDocElement = (Element) imageDataDoc;
						Node eDocImportedNode = doc.importNode(
								imageDataDocElement, true);
						eElement.appendChild(eDocImportedNode);
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

			// System.out.println("XML file updated successfully");

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	private static void modify(Element modifiable, Element modifying) {
		modifiable.setAttribute("contrast", modifying.getAttribute("contrast"));
		modifiable.setAttribute("effect", modifying.getAttribute("effect"));
		modifiable.setAttribute("sharpness",
				modifying.getAttribute("sharpness"));
		modifiable.setAttribute("src", modifying.getAttribute("src"));
		modifiable.setAttribute("moving", modifying.getAttribute("moving"));
		modifiable.setAttribute("scrollSpeed",
				modifying.getAttribute("scrollSpeed"));
	}
}
