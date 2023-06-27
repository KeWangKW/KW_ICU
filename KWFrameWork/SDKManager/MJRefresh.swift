//
//  Refresh.swift
//  InheritTableViewController
//
//  Created by 渴望 on 2020/5/19.
//  Copyright © 2020 渴望. All rights reserved.
//

import UIKit

#if canImport(MJRefresh)
import MJRefresh

public extension UIScrollView {
    @objc var kw_header: MJRefreshHeader? {
        get { return self.mj_header }
        set { self.mj_header = newValue }
    }
    @objc var kw_footer: MJRefreshFooter? {
        get { return self.mj_footer }
        set { self.mj_footer = newValue}
    }
    
    @objc func kw_refreshHeader(_ closure: @escaping () -> Void) {
        self.mj_header = RefreshHeader(refreshingBlock: closure)
    }
    
    @objc func kw_refreshFooter(_ closure: @escaping () -> Void) {
        self.mj_footer = RefreshFooter2(refreshingBlock: closure)
    }
    
    @objc func kw_endRefresh() {
        if let head = kw_header, head.isRefreshing {
            head.endRefreshing()
        }
        if let foot = kw_footer, foot.isRefreshing {
            foot.endRefreshing()
        }
    }
}


class RefreshHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        
        setTitle("下拉刷新", for: .idle)
        setTitle("松开刷新", for: .pulling)
        setTitle("刷新数据中...", for: .refreshing)
        setTitle("刷新数据中...", for: .willRefresh)
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.font = .systemFont(ofSize: 13)
        
        stateLabel?.textColor = .black
        loadingView?.color = .black

        if #available(iOS 13.0, *) {
            loadingView?.style = .medium
        }
    }
}

///上拉自动加载
class RefreshFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()

        setTitle("", for: .idle) //点击或上拉加载
        setTitle("松开加载", for: .pulling)
        setTitle("数据加载中...", for: .refreshing)
        setTitle("数据加载中...", for: .willRefresh)
        setTitle("", for: .noMoreData) //已加载全部 已经到底了

        stateLabel?.font = .systemFont(ofSize: 13)
        stateLabel?.textColor = .black
        loadingView?.color = .black

        if #available(iOS 13.0, *) {
            loadingView?.style = .medium
        }
    }
}

///松手后加载
class RefreshFooter2: MJRefreshBackNormalFooter {
    override func prepare() {
        super.prepare()

        setTitle("上拉可以加载更多", for: .idle) //
        setTitle("松开立即加载更多", for: .pulling)
        setTitle("正在加载更多数据...", for: .refreshing)
        setTitle("正在加载更多数据...", for: .willRefresh)
        setTitle("已经到底了", for: .noMoreData) //已加载全部 已经到底了

        stateLabel?.font = .systemFont(ofSize: 13)
        stateLabel?.textColor = .black
        loadingView?.color = .black

        if #available(iOS 13.0, *) {
            loadingView?.style = .medium
        }
    }
}


#endif
