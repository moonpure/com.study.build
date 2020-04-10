package ${packageName}.core;

/**
 * API 统一返回状态码
 */
public enum ResultCode {

    /* 成功状态码 */
    SUCCESS(0, "成功"),
    /* 失败状态码 */
    FAILURE(1, "失败"),
    HTTP_500_FAILURE(500, "http 500"),
    /* 参数错误：10001-19999 */
    PARAM_IS_INVALID(1001, "参数无效"),
    PARAM_IS_BLANK(1002, "参数为空"),
    PARAM_TYPE_BIND_ERROR(1003, "参数类型错误"),
    PARAM_NOT_COMPLETE(1004, "参数缺失"),
    PARAM_NOT_EXISTED(1005, "参数系统不存在"),
    PARAM_EXISTED(1006, "系统已存在"),
    PARAM_VERIFYCODE_FAILURE(1007,"验证码不对"),
    PARAM_PASSWORD_FAILURE(1008,"密码不对"),
    PARAM_NOT_FORMAT(1009,"参数格式不对"),

    /* 用户错误：20001-29999*/
    USER_NOT_LOGGED_IN(2001, "用户未登录"),
    USER_LOGIN_ERROR(2002, "账号不存在或密码错误"),
    USER_ACCOUNT_FORBIDDEN(2003, "账号已被禁用"),
    USER_NOT_EXISTED(2004, "用户不存在"),
    USER_HAS_EXISTED(2005, "用户已存在"),
    USER_NOT_OPEN(2006, "老系统用户"),

    CODE_MOBILE_FAILURE(3001,"短信发送验证码失败"),
    CODE_EMAIL_FAILURE(3002,"邮箱发送验证码失败"),


    DATABASE_ADD_FAILURE(4001,"数据库添加失败"),
    DATABASE_EDIT_FAILURE(4002,"数据库修改失败"),
    DATABASE_QUERY_FAILURE(4003,"数据库查询失败");

    private Integer code;

    private String message;

    //3.定义构造函数
    ResultCode(int code, String message){
        this.code = code;
        this.message = message;
    }
    // 普通方法
    public static String getMessage(int code) {
        for (ResultCode rc : ResultCode.values()) {
            if (rc.getCode()== code) {
                return rc.getMessage();
            }
        }
        return null;
    }

    //4.定义get方法
    public int getCode(){
        return code;
    }

    public String getMessage(){
        return message;
    }

}
