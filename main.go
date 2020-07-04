package main

import (
	"time"

	"github.com/skip2/go-qrcode"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/canvas"
	"fyne.io/fyne/widget"
)

type imageResource struct {
	secret string
}

func (c imageResource) Name() string {
	return ""
}

func (c imageResource) Content() []byte {
	png, err := qrcode.Encode(c.secret, qrcode.Medium, 512)
	if err != nil {
		panic(err)
	}
	return png
}

type qrSecret struct {
	gui fyne.App

	window fyne.Window

	content *widget.Box

	button *widget.Button
	input  *widget.Entry
}

func (qr qrSecret) onChangeInput(key string) {
	if qr.input.Text != "" {
		qr.button.Enable()
	} else {
		qr.button.Disable()
	}
}

func (qr qrSecret) onTapButton() {
	qr.button.Disable()
	qr.input.Disable()

	qrResource := imageResource{
		secret: string(qr.input.Text),
	}

	qrImage := canvas.NewImageFromResource(qrResource)
	qrImage.FillMode = canvas.ImageFillOriginal

	qr.content.Append(qrImage)

	go qr.close()
}

func (qr qrSecret) close() {
	time.Sleep(10 * time.Second)
	qr.gui.Quit()
}

func main() {

	gui := app.New()

	window := gui.NewWindow("QRSecret")
	window.Resize(
		fyne.Size{
			Width: 256,
		},
	)
	window.SetFixedSize(true)

	qrsecret := qrSecret{
		gui:    gui,
		window: window,
		input:  widget.NewPasswordEntry(),
		button: widget.NewButton("Generate QR", nil),
	}

	qrsecret.input.Wrapping = fyne.TextWrapBreak
	qrsecret.input.MultiLine = true
	qrsecret.button.Disable()
	qrsecret.input.OnChanged = qrsecret.onChangeInput
	con := widget.NewScrollContainer(qrsecret.input)
	con.SetMinSize(fyne.NewSize(256, 256))
	qrsecret.content = widget.NewVBox(con, qrsecret.button)
	qrsecret.button.OnTapped = qrsecret.onTapButton

	window.SetContent(qrsecret.content)
	window.ShowAndRun()

}
