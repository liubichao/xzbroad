package com.keerinfo.springmvc.service;

import com.keerinfo.springmvc.basedao.ConnectionFactory;
import com.keerinfo.springmvc.utils.MyUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.Arrays;

public abstract class Service {
    public abstract int save(HttpServletRequest request, HttpSession session);
    public abstract int update(HttpServletRequest request, HttpSession session);
    public abstract int delete(HttpServletRequest request, HttpSession session);
    //public abstract int login(HttpServletRequest request, HttpSession session);
    public abstract JSONArray getCategoryArray(HttpServletRequest request);
    public abstract JSONObject getAllResultToJSON(HttpServletRequest request);
    public abstract String fileUpload(HttpServletRequest request, HttpSession session);
    public abstract String getCategoryTreeByName(HttpServletRequest request);

    private static Logger log = Logger.getLogger(Service.class);
    private Connection con = null;
    private PreparedStatement pst = null;
    private ResultSet rs = null;

    private void init(String sql) {
        con = ConnectionFactory.getConnection();
        try {
            pst = con.prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据module获取对应的分类
     * @param module
     * @return
     */
    public JSONArray getCategoryByName(String module){
         if(MyUtils.isEmpty(module)) return  new JSONArray();
         String sql = "select id,name,parentId from category where module = ? order by sort ";
         init(sql);
         log.info("---" + sql);
         JSONArray array = new JSONArray();
        try {
            pst.setString(1,module);
            rs = pst.executeQuery();
            JSONObject obj = null;
            while (rs.next()){
                obj = new JSONObject();
                obj.put("id",rs.getString(1));
                obj.put("name",rs.getString(2));
                obj.put("parentId",rs.getString(3));

                array.add(obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs,pst,con);
        }
        return array;
    }

    /**
     * 查询结果
     * @param sql
     * @return
     */
    public JSONArray getAllResultToJSON(String sql){
        if(MyUtils.isEmpty(sql)) return new JSONArray();
        log.info("---" + sql);
        Connection con = ConnectionFactory.getConnection();
        PreparedStatement pst = null;
        JSONArray array = new JSONArray();
        try {
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            array = getAllResultToJSON(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs,pst,con);
        }
        return array;
    }

    /**
     * 根据条件获取日志配置
     * @param request
     * @return
     */
    public JSONObject getAllResultOfLogClear(HttpServletRequest request){
        String params = MyUtils.getParam(request,MyUtils.PARAMS);
        String tableName = MyUtils.getParam(request,MyUtils.TABLENAME);
        String primaryKey = MyUtils.getParam(request,MyUtils.PRIMARYKEY);
        String contentId = MyUtils.getParam(request,MyUtils.CONTENTID);
        String sql = "select " + params + " from " + tableName + " where "+ primaryKey +" = '"+ contentId +"'";
        JSONObject obj = new JSONObject();
        log.info("---" + sql);
        init(sql);
        try {
            rs = pst.executeQuery();
            String[] split = params.split(",");
            while (rs.next()){
                for(int i = 0 ; i < split.length;i++){
                     obj.put(split[i],rs.getString((i+1)));
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            close(rs,pst,con);
        }
        return obj;
    }

    /**
     * 根据ResultSet对象转化JSONArray
     *
     * @date 2015-12-2 下午12:00:50
     * @param rs
     * @throws SQLException
     * @return JSONArray
     */
    public JSONArray getAllResultToJSON(ResultSet rs)
            throws SQLException {
        if (rs == null)
            return null;
        ResultSetMetaData rsmd = rs.getMetaData();
        int count = rsmd.getColumnCount();
        JSONArray array = new JSONArray();
        JSONObject o = null;
        while (rs.next()) {
            o = new JSONObject();
            for (int i = 1; i <= count; i++) {
				/* rsmd.getColumnType(i);//获取列的数据类型 */
                o.put(rsmd.getColumnName(i), rs.getString(i));/* 获取列名,或列值,都是从1开始 */
            }
            array.add(o);
        }
        return array;
    }
    /**
     * 更新包括新增、修改、删除
     *
     * @param sql
     * @return
     * @throws
     * @Title: update
     * @Description: 2016-9-8下午5:07:27
     * @return: int
     */
    public int update(String sql) {
        log.info("---" + sql);
        if (MyUtils.isEmpty(sql)) return 0;
        int flag = 0;
        try {
            init(sql);
            flag = pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            flag = -1;
        } finally {
            close(null, pst, con);
        }
        return flag;
    }

    /**
     * 查询记录数
     *
     * @param sql
     * @return
     * @throws
     * @Title: queryCount
     * @Description: 2016-9-8下午6:15:12
     * @return: int
     */
    public int queryCount(String sql) {
        if (MyUtils.isEmpty(sql) || !sql.trim().startsWith("from")) return 0;
        sql = "select count(*) " + sql;
        log.info("---" + sql);
        init(sql);
        try {
            rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 添加日志
     *
     * @param request
     * @param session
     * @param useraction
     * @param programinfo
     * @return
     * @throws
     * @Title: saveLog
     * @Description: 2016-9-8下午6:06:07
     * @return: int
     */
    public int saveLog(HttpServletRequest request, HttpSession session, String useraction, String programinfo) {
        String sql = "insert into loginfo (id,username,useraction,userip,programinfo) values (?,?,?,?,?)";
        Connection con = ConnectionFactory.getConnection();
        PreparedStatement pst = null;
        String username = session.getAttribute("USERNAME") == null ? "visitor" : (session.getAttribute("USERNAME").toString());
        try {
            pst = con.prepareStatement(sql);

            pst.setString(1, MyUtils.getUUID());
            pst.setString(2,username);
            pst.setString(3, useraction);
            pst.setString(4, MyUtils.getIp2(request));
            pst.setString(5, programinfo);

            return pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(null, pst, con);
        }

        return 0;
    }
    /**
     * 根据上一级ID获取下级分类，
     */
    public JSONArray getCategory(String pid) {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String sql = "select c.id,c.name,c.sort,c.isvalid,c.parentId from category c where c.parentId = ? order by c.sort ";
        log.info("---" + sql);
        JSONArray array = new JSONArray();
        JSONObject obj = null;
        try {
            con = ConnectionFactory.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, pid);
            rs = pst.executeQuery();
            while(rs.next()){
                obj = new JSONObject();
                obj.put("id", rs.getString(1));
                obj.put("name", rs.getString(2));
                obj.put("sort", rs.getInt(3));
                obj.put("isvalid", rs.getInt(4));
                obj.put("parentId", rs.getString(5));
                array.add(obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
            close(rs,pst,con);
        }
        return array;
    }

    /**
     * 生成缩略图
     * @param srcFile
     * @param destFile
     */
    public void createPreviewImage(String srcFile, String destFile) {
        File imgFile = new File(srcFile);
        if(imgFile.exists()){
            try {
                // ImageIO 支持的图片类型 : [BMP, bmp, jpg, JPG, wbmp, jpeg, png, PNG, JPEG, WBMP, GIF, gif]
                String types = Arrays.toString(ImageIO.getReaderFormatNames());
                String suffix = null;
                // 获取图片后缀
                if(imgFile.getName().indexOf(".") > -1) {
                    suffix = imgFile.getName().substring(imgFile.getName().lastIndexOf(".") + 1);
                }// 类型和图片后缀全部小写，然后判断后缀是否合法
                if(suffix == null || types.toLowerCase().indexOf(suffix.toLowerCase()) < 0){
                    log.error("Sorry, the image suffix is illegal. the standard image suffix is {}." + types);
                    return ;
                }
                log.debug("target image's size, width:{}, height:{}.");
                Image img = ImageIO.read(imgFile);
                boolean force = false;
                int w = 120,h = 120;
                if(!force){
                    // 根据原图与要求的缩略图比例，找到最合适的缩略图比例
                    int width = img.getWidth(null);
                    int height = img.getHeight(null);
                    if((width*1.0)/w < (height*1.0)/h){
                        if(width > w){
                            h = Integer.parseInt(new java.text.DecimalFormat("0").format(height * w/(width*1.0)));
                            log.debug("change image's height, width:{}, height:{}.");
                        }
                    } else {
                        if(height > h){
                            w = Integer.parseInt(new java.text.DecimalFormat("0").format(width * h/(height*1.0)));
                            log.debug("change image's width, width:{}, height:{}.");
                        }
                    }
                }
                BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
                Graphics g = bi.getGraphics();
                g.drawImage(img, 0, 0, w, h, Color.LIGHT_GRAY, null);
                g.dispose();
                String p = imgFile.getPath();
                // 将图片保存在原目录并加上前缀
                ImageIO.write(bi, suffix, new File(destFile));
            } catch (IOException e) {
                log.error("generate thumbnail image failed.",e);
            }
        }else{
            log.warn("the image is not exist.");
        }
    }
    /**
     * 关闭链接
     *
     * @throws SQLException
     * @throws
     * @Title: close
     * @Description: 2016-9-8下午5:10:10
     * @return: void
     */
    public void close(ResultSet rs, PreparedStatement pst, Connection con) {
        try {
            if (rs != null) {
                rs.close();
                rs = null;
            }
            if (pst != null) {
                pst.close();
                pst = null;
            }
            if (con != null) {
                con.close();
                con = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
