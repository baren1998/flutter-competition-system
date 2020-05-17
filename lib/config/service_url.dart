const serviceUrl = 'http://localhost:8080/';
const servicePath = {
  'findAllCompetitions' : serviceUrl + 'competitions/findAll',  // 获取所有竞赛信息
  'findAllCompetitionsByPage' : serviceUrl + 'competitions/findAllByPage', // 获取所有竞赛信息的分页形式
  'findCompetitionsByType' : serviceUrl + 'competitions/findByType', // 获取指定类别的竞赛信息
  'findCompetitionsByTypeAndPage' : serviceUrl + 'competitions/findByTypeAndPage', // 获取指定类别的竞赛信息的分页形式
  'findUserByName' : serviceUrl + 'users/findByName', // 根据用户名判断用户是否存在(用于注册时判断
  'login' : serviceUrl + 'users/login',  // 用户登录接口，返回用户基本信息
  'pullNotification' : serviceUrl + 'users/pullNotification', // 拉取通知信息
  'getLastNotifyTime' : serviceUrl + 'users/getLastNotifyTime', // 获取后端最后一次推送通知的时间
  'register' : serviceUrl + 'users/register',  // 用户注册接口，返回注册状态信息
};