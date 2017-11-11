//
//  ViewController.swift
//  Assignment Chart
//
//  Created by Sandeep Rana on 10/11/17.
//  Copyright © 2017 thedancho. All rights reserved.
//

import UIKit
import SwiftChart

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var vPieChartRootView: UIView!;
    @IBOutlet weak var vPieChartInnerView: UIView!;
    @IBOutlet weak var pieChart: ARPieChart!;
    @IBOutlet weak var lPercentPieChart: UILabel!;
    @IBOutlet weak var lAmountPieChart: UILabel!;

//pragma mark Line Chart
    @IBOutlet weak var lineChart: Chart!;
    @IBOutlet weak var viewChartBackGround: ChartFilled!;
// TableView

    @IBOutlet weak var tableView: UITableView!;


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    var arrOfPiCharts = [PiedataModel]();

    @IBOutlet weak var rootView: UIView!;
    @IBOutlet weak var scrollView: UIScrollView!;

    override func viewDidLoad() {
        super.viewDidLoad()


        self.setShadowToView(view: self.vPieChartRootView);
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpPieChart();
        self.setUpLineChart();
        self.setUptableView();
    }

    private func setUptableView() {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

    override func viewWillAppear(_ animated: Bool) {

        scrollView.contentSize.height = rootView.frame.height
        scrollView.contentSize.width = rootView.frame.width
        super.viewWillAppear(animated)

    }

    private func setUpLineChart() {
        self.lineChart.showXLabelsAndGrid = false;
        self.lineChart.showYLabelsAndGrid = false;
        self.lineChart.tintColor = UIColor.yellow
        self.lineChart.delegate = self;
        let series = ChartSeries([1, 3, 4, 6, 8, 11, 10, 8, 12, 14, 15, 11, 12, 11, 14, 12, 16, 17, 19, 15, 22])
        series.color = #colorLiteral(red:0.9851996303, green:0.5940072536, blue:0.595333755, alpha:1)
        series.area = false;
        self.lineChart.add(series);
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
        let amount = "\(Int(self.arrOfPiCharts[index].value).description)";
        self.lAmountPieChart.text = amount;
        self.showDialogWithValue(amount);
    }

    func pieChart(pieChart: ARPieChart, itemDeselectedAtIndex index: Int) {
        print("itemdeseledtedataindex");
    }

    func showDialogWithValue(_ amount: String) {
        let alertValue = UIAlertController(title: "Pie Chart", message: "You Selected Value \(amount)", preferredStyle: .actionSheet);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result: UIAlertAction) -> Void in
        }

        alertValue.addAction(okAction);

        self.present(alertValue, animated: true, completion: nil);
    }

}

extension HomeViewController: ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Float, left: CGFloat) {
        chart.highlightLineColor = #colorLiteral(red:0.9765608907, green:0.9770647883, blue:0.9759072661, alpha:1);
        self.viewChartBackGround.fillTill(left);
        self.showDialogWithValue(x.rounded().description);
    }

    func didEndTouchingChart(_ chart: Chart) {

    }

    func didFinishTouchingChart(_ chart: Chart) {
        print(chart);
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Names.CELL)
        cell?.textLabel?.text = "\(indexPath.row.description) Lorem Ipsum";
        return cell!;
    }
}

