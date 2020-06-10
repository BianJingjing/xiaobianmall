package servlet;

import Util.Page;
import bean.Category;
import bean.Product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

public class ProductServlet extends BaseBackServlet {
    @Override
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category c = categoryDAO.get(cid);

        String name= request.getParameter("name");

        float price = Float.parseFloat(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Product p = new Product();

        p.setCategory(c);
        p.setName(name);

        p.setPrice(price);
        p.setStock(stock);
        p.setCreateDate(new Date());

        productDAO.add(p);
        return "@admin_product_list?cid="+cid;
    }

    @Override
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    @Override
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
       int id = Integer.parseInt(request.getParameter("id"));
        Product p = productDAO.get(id);
        request.setAttribute("p", p);
        return "admin/editProduct.jsp";
    }

    @Override
    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category c = categoryDAO.get(cid);

        int id = Integer.parseInt(request.getParameter("id"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        float price = Float.parseFloat(request.getParameter("price"));

        String name= request.getParameter("name");

        Product p = new Product();

        p.setName(name);

        p.setPrice(price);
        p.setStock(stock);
        p.setId(id);
        p.setCategory(c);

        productDAO.update(p);
        return "@admin_product_list?cid="+p.getCategory().getId();
    }

    @Override
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category c = categoryDAO.get(cid);

        List<Product> ps = productDAO.list(cid, page.getStart(),page.getCount());

        int total = productDAO.getTotal(cid);
        page.setTotal(total);
        page.setParam("&cid="+c.getId());

        request.setAttribute("ps", ps);
        request.setAttribute("c", c);
        request.setAttribute("page", page);

        return "admin/listProduct.jsp";
    }
}
