//
//  ViewController.swift
//  Assignment Chart
//
//  Created by Sandeep Rana on 10/11/17.
//  Copyright © 2017 thedancho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UIScrollViewDelegate{

    @IBOutlet weak var vPieChartRootView: UIView!;
    @IBOutlet weak var vPieChartInnerView: UIView!;
    @IBOutlet weak var pieChart: ARPieChart!;
    @IBOutlet weak var lPercentPieChart: UILabel!;
    @IBOutlet weak var lAmountPieChart: UILabel!;

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    var arrOfPiCharts = [PiedataModel]();

    @IBOutlet weak var rootView: UIView!;
    @IBOutlet weak var scrollView: UIScrollView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self;
        self.setShadowToView(view: self.vPieChartRootView);
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpPieChart();
    }

    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / rootView.bounds.width
        let heightScale = size.height / rootView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    private func setUpPieChart() {
        self.pieChart.delegate = self;
        self.pieChart.dataSource = self;
        self.pieChart.outerRadius = 35;
        self.pieChart.innerRadius = 28;

        self.pieChart.animationDuration = 1.00;

        self.arrOfPiCharts.append(PiedataModel(value: 456, color: #colorLiteral(red:0.9832152724, green:0.5008653402, blue:0.3363953829, alpha:1), description: "someting"));
        self.arrOfPiCharts.append(PiedataModel(value: 885, color: #colorLiteral(red:0.9877961278, green:0.6795038581, blue:0.3474167883, alpha:1), description: "someting"));

        self.pieChart.reloadData()
    }

    func setShadowToView(view: UIView) {
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return rootView;
    }
}

extension HomeViewController: ARPieChartDataSource, ARPieChartDelegate {

    func numberOfSlicesInPieChart(pieChart: ARPieChart) -> Int {
        return self.arrOfPiCharts.count;
    }

    func pieChart(pieChart: ARPieChart, valueForSliceAtIndex index: Int) -> CGFloat {
        return self.arrOfPiCharts[index].value;
    }

    func pieChart(pieChart: ARPieChart, colorForSliceAtIndex index: Int) -> UIColor {
        return self.arrOfPiCharts[index].color;
    }

    func pieChart(pieChart: ARPieChart, descriptionForSliceAtIndex index: Int) -> String {
        return self.arrOfPiCharts[index].description ?? "";
    }

    func pieChart(pieChart: ARPieChart, itemSelectedAtIndex index: Int) {
        let percent: CGFloat = (self.arrOfPiCharts[index].value / pieChart.total) * 100;
        self.lPercentPieChart.text = "\((Int(percent)).description) %"
        self.lAmountPieChart.text = "\(Int(self.arrOfPiCharts[index].value).description)";
    }

    func pieChart(pieChart: ARPieChart, itemDeselectedAtIndex index: Int) {
        print("itemdeseledtedataindex");
    }
}


