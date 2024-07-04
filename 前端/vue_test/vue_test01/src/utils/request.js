import axios from "axios";

//1.创建一个axios对象
const request = axios.create({
    baseURL: 'http://localhost:8080/api',
    // 待解开
    timeout: 5000
})


/* request 拦截器
可以在请求发送前对请求做一些处理
比如统一加token，对请求参数统一加密 */
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';
    const user = localStorage.getItem("user")
    //从localstorage中获取用户登录信息
    if(user){
        config.headers['token'] = JSON.parse(user).token
    }
    return config
},error =>{
    return Promise.reject(error)
});

//response拦截器：可以在接口响应后统一处理结果
request.interceptors.response.use(response =>{
    //response.data即为后端返回的Result
    let res = response.data
    if(typeof res ==='string'){
        res = res?JSON.parse(res):res
    }
    return res;
},
    error =>{
        console.log('err'+error);
        return Promise.reject(error)
    }
)
export default request