import bb.cascades 1.0

Container {
    id: container
    property int duration: 1000
    property bool isDarkTheme: false
    property bool running: true
    
    onRunningChanged: {
        if (running) {
            outerRotateTransition.play()
            parallelAnimation.play()
        }
        else {
            outerRotateTransition.stop()
            parallelAnimation.stop()
        }
    }
    
    onCreationCompleted: {
        outerRotateTransition.play()
        parallelAnimation.play()
    }
    
    layout: DockLayout {}
    ImageView {
        id: outerCircle
        imageSource: isDarkTheme ? "asset:///Squircle/squircleDark.png" : "asset:///Squircle/squircleBright.png"
        scalingMethod: ScalingMethod.AspectFit
        animations: [
            RotateTransition {
                id: outerRotateTransition
                fromAngleZ: rotationZ
                toAngleZ: rotationZ + 90
                duration: container.duration
                easingCurve: StockCurve.Linear
                onEnded: if (running) play()
            }
        ]
    }
    ImageView {
        id: innerCircle
        imageSource: isDarkTheme ? "asset:///Squircle/squircleDark.png" : "asset:///Squircle/squircleBright.png"
        scalingMethod: ScalingMethod.AspectFit
        animations: [
            ParallelAnimation {
                id: parallelAnimation
                onEnded: if (running) play()
                RotateTransition {
                    fromAngleZ: rotationZ
                    toAngleZ: rotationZ + 180
                    duration: container.duration
                    easingCurve: StockCurve.Linear
                }
                SequentialAnimation {
                    id: sequentialAnimation
                    ScaleTransition {
                        toX: 0.78
                        toY: toX
                        duration: container.duration / 2
                        easingCurve: StockCurve.Linear
                    }
                    ScaleTransition {
                        toX: 1
                        toY: toX
                        duration: container.duration / 2
                        easingCurve: StockCurve.Linear
                    }
                }
            }
        ]
    }
}
