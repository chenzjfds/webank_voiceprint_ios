//
//  Presenter.swift
//  voiceprint
//
//  Created by zhijunchen on 2019/12/29.
//  Copyright © 2019 zhijunchen. All rights reserved.
//

import Foundation
import Voiceprintsdk
//let  DEBUG = true
//let  APP_ID = "appIdmGWGsx0TDxp6b8F39eRvWLabCrkqoh9y"
//let  APP_KEY = "appKeyNsAHpifFfishlhNonxdAaqPYuqLqxyT1"
//let  APP_PROJECT_NAME = "sdk专用测试"
//let  APP_BUSINESS_NAME = "sdk"
let  DEBUG = false
let  APP_ID = ""
let  APP_KEY = ""
let  APP_PROJECT_NAME = ""
let  APP_BUSINESS_NAME = ""

//let  BASE_URL = "http://wes.test.webank.com:8080/asr/e"
public class  Demo{
    static let Shared=Demo();
    public static let regist_file_path = "audio_regist"
    
    public static let search_file_path = "audio_search"
    
    public static let verify_audio_path = "audio_verify"
    
    public static let group_id = "all_user"
    public static let user = "user"
    var vpAgent:VoiceprintAgent
    init(){
        var mConfig=Config(DEBUG,APP_ID,APP_KEY,APP_BUSINESS_NAME,APP_PROJECT_NAME)
        vpAgent = VoiceprintAgent(mConfig)
    }
    /**
     检查音频合法性
     */
    public func test(){
        //        vpAgent.test()
    }
    public func regist(){
        var  audio=dealFile(path: getPath(name: Demo.regist_file_path))
        var params = VpRegistRequest.VpRegistParams(Demo.user,[Demo.group_id],audio)
        params.liveness_check=true
        params.quality_check=true
        var success={(data:VpRegistRequest.VpRegistResponse)->() in
             var result = "success="+self.entity2Json(param: data);
                      print(result)
                      self.showToast(msg: result)
        }
        var fault={(data:RequestError)->() in
            var result = "fault="+data.msg
                       self.showToast(msg: result)
            
        }
        vpAgent.regist(params, success, fault)
    }
    public func delete(){
        var params = VpDeleteRequest.VpDeleteParams(Demo.user)
     
        var success={(data:VpDeleteRequest.VpDeleteResponse)->() in
              var result = "success="+self.entity2Json(param: data);
                       print(result)
                       self.showToast(msg: result)
        }
        var fault={(data:RequestError)->() in
            var result = "fault="+data.msg
                       self.showToast(msg: result)
            
        }
        vpAgent.delete(params, success, fault)
    }
    public func verify(){
        var  audio=dealFile(path: getPath(name: Demo.verify_audio_path))
        var params = VpVerifyRequest.VpVerifyParams(Demo.user,audio)
        params.liveness_check=true
        params.quality_check=true
        var success={(data:VpVerifyRequest.VpVerifyResponse)->() in
            var result = "success="+self.entity2Json(param: data);
            print(result)
            self.showToast(msg: result)
        }
        var fault={(data:RequestError)->() in
            var result = "fault="+data.msg
                       self.showToast(msg: result)
        }
        vpAgent.verify(params, success, fault)
    }
    public func search(){
        var  audio=dealFile(path: getPath(name: Demo.search_file_path))
        var params = VpSearchRequest.VpSearchParams([Demo.group_id],audio)
        params.liveness_check=true
        params.quality_check=true
        var success={(data:VpSearchRequest.VpSearchResponse)->() in
             var result = "success="+self.entity2Json(param: data);
                      print(result)
                      self.showToast(msg: result)
        }
        var fault={(data:RequestError)->() in
            var result = "fault="+data.msg
             self.showToast(msg: result)
        }
        vpAgent.search(params, success, fault)
    }
    private func getPath(name:String)->String{
        let htmlBundlePath = Bundle.main.path(forResource:"resource", ofType:"bundle")
        let htmlBundle = Bundle.init(path: htmlBundlePath!)
        let path = htmlBundle?.path(forResource: name, ofType: "wav", inDirectory: "audio")
        print("path="+path!)
        return path!
    }
    private func dealFile(path:String)->String{
        var data = FileUtil.readFile2Base64(path: path) ?? ""
        print("dealFile lenght="+String(data.count))
        return data
    }
    func  entity2Json<T>(param:T)->String where T : Encodable{
        
        if let jsonData = try? JSONEncoder().encode(param)  { // 编码成功
            
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                return jsonString
            }
        }
        return ""
    }
    func  showToast(msg:String){
        DispatchQueue.global().async {
                   print("async do something\(Thread.current)")
                   DispatchQueue.main.async {
                       EWToast.showBottomWithText(text: msg, bottomOffset: 150)
                   }
               }
    }
}
