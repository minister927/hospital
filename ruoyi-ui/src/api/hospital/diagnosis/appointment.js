import request from '@/utils/request'

// 查询预约挂号列表
export function listAppointment(query) {
  return request({
    url: '/diagnosis/appointment/list',
    method: 'get',
    params: query
  })
}

// 查询预约挂号详细
export function getAppointment(appointmentId) {
  return request({
    url: '/diagnosis/appointment/' + appointmentId,
    method: 'get'
  })
}

// 新增预约挂号
export function addAppointment(data) {
  return request({
    url: '/diagnosis/appointment',
    method: 'post',
    data: data
  })
}

// 修改预约挂号
export function updateAppointment(data) {
  return request({
    url: '/diagnosis/appointment',
    method: 'put',
    data: data
  })
}

// 删除预约挂号
export function delAppointment(appointmentId) {
  return request({
    url: '/diagnosis/appointment/' + appointmentId,
    method: 'delete'
  })
}
