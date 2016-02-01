//
//  ViewController.swift
//  ChartsTesting
//
//  Created by James Wang on 2/1/16.
//  Copyright © 2016 Dell Software. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.noDataText = "You need to provide data"
        chartView.noDataTextDescription = "GIVE REASON"
        
        let dataPoints = ["13:00", "13:10", "13:20", "13:30", "13:40", "13:50", "14:00", "14:10", "14:20", "14:30", "14:40"]
        var valuesAndOptions = [Dictionary<String, Any>]()
        valuesAndOptions.append([
            "label" : "Errors",
            "color" : UIColor.redColor(),
            "values" : randomValues(dataPoints.count)
            ])
        valuesAndOptions.append([
            "label" : "Warnings",
            "color" : UIColor.yellowColor(),
            "values" : randomValues(dataPoints.count)
            ])
        setChart(dataPoints, valuesAndOptions: valuesAndOptions)
    }
    
    
    func randomValues(count: Int) -> [Double] {
        var values = [Double]()
        
        for _ in 0..<count {
            values.append(Double(arc4random_uniform(20)))
        }
        
        return values
    }
    
    func setChart(dataPoints : [String], valuesAndOptions : [Dictionary<String, Any>]) {
        var dataSets = [IChartDataSet]()
        
        for valuesAndOption in valuesAndOptions {
            var dataEntries = [ChartDataEntry]()
            
            let label = valuesAndOption["label"] as! String
            let color = valuesAndOption["color"] as! UIColor
            let values =  valuesAndOption["values"] as! [Double]
            
            for i in 0..<values.count {
                let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = LineChartDataSet(yVals: dataEntries, label: label)
            chartDataSet.colors = [color]
            dataSets.append(chartDataSet)
        }
        
        let chartData = LineChartData(xVals: dataPoints, dataSets: dataSets)
        chartView.data = chartData
        chartView.xAxis.labelPosition = .Bottom
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    
        let limitLine = ChartLimitLine(limit: 10.0, label: "Threshold")
        chartView.rightAxis.addLimitLine(limitLine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

