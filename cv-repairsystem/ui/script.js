function OpenUI(data) {
    $(".Body-Health").html(`
    <div class="body-text1">
    Body Health
    </div>  
    <div id="Body-Health-percentage" style="color: #4ba55b;">
    ${data.bodypercent}%
    </div>
    <div class="price-box">
        <div id="price">
            $${data.bodyprice}
        </div>
    </div>
    <div class="body-btn">
    <button id="body-health-btn" onclick="ButtonClicked('body', ${data.bodyprice})" >Buy</button>
    </div>
    </div>
    `)
    
    $(".Engine-Health").html(`
    <div class="Engine-text1">
    Engine Health
    </div>  
    <div id="Engine-Health-percentage" style="color: #4ba55b;">
    ${data.enginepercent}%
    </div>
    <div class="Engine-price-box">
        <div id="Engine-price">
        $${data.engineprice}
        </div>
    </div>
    <div class="Engine-btn">
    <button id="Engine-health-btn" onclick="ButtonClicked('engine', ${data.engineprice})">Buy</button>
    </div>
    `)
    $(".Dirt-Level").html(`
    <div class="Dirt-text1">
    Dirt Level
</div> 
<div class="percentage">
    <div id="Dirt-Health-percentage" style="color: #4ba55b;">
        ${data.dirtpercent}%
    </div>
</div>
<div class="Dirt-price-box">
    <div id="Dirt-price">
    $${data.dirtprice}
    </div>
</div>
<div class="Dirt-btn">
    <button id="Dirt-health-btn" onclick="ButtonClicked('dirt', ${data.dirtprice})" data-button="dirt">Buy</button>
</div>
    `)
    $(".full-repair").html(`
    <h1>Full Repair</h1>
                <div style="color: #878582;">
                    All around repair for your car.
                </div>
                <div style="color: #878582;">package with an 10% discount.</div>
                <div class="full-repair-price-box">
                    <div id="full-repair-price">
                        $${data.fullprice}
                    </div>
                </div>
                <div class="full-repair-btn">
                    <button id="full-repair-btn" onclick="ButtonClicked('full', ${data.fullprice})">Buy</button>
                </div>
    `)

    if (data.open) {
        $("#MainBody").fadeIn()
    }

}

function ButtonClicked(button, price) {
    if (button == "close") {
        $("#MainBody").fadeOut()
        $.post(`https://cv-repairsystem/close`)   
    } else {
        if (price > 0){
            $.post(`https://cv-repairsystem/UseButton`, JSON.stringify({
                button: button,
                price: price
            }))  
             
        } 
    }
}

function Update(button) {
    if (button == "full") {
        $(".full-repair").html(`
        <h1>Full Repair</h1>
                    <div style="color: #878582;">
                        All around repair for your car.
                    </div>
                    <div style="color: #878582;">package with an 10% discount.</div>
                    <div class="full-repair-price-box">
                        <div id="full-repair-price">
                            $0
                        </div>
                    </div>
                    <div class="full-repair-btn">
                        <button id="full-repair-btn" class="active">Buy</button>
                    </div>
        `)
        $(".Engine-Health").html(`
        <div class="Engine-text1">
        Engine Health
        </div>  
        <div id="Engine-Health-percentage" style="color: #4ba55b;">
        100%
        </div>
        <div class="Engine-price-box">
            <div id="Engine-price">
            $0
            </div>
        </div>
        <div class="Engine-btn">
        <button id="Engine-health-btn" class="active">Buy</button>
        </div>
        `)
        $(".Body-Health").html(`
        <div class="body-text1">
        Body Health
        </div>  
        <div id="Body-Health-percentage "style="color: #4ba55b;">
        100%
        </div>
        <div class="price-box">
            <div id="price">
                $0
            </div>
        </div>
        <div class="body-btn">
        <button id="body-health-btn" class="active" >Buy</button>
        </div>
        </div>
        `)
        $(".Dirt-Level").html(`
        <div class="Dirt-text1">
        Dirt Level
    </div> 
    <div class="percentage">
        <div id="Dirt-Health-percentage" style="color: #4ba55b;">
            0%
        </div>
    </div>
    <div class="Dirt-price-box">
        <div id="Dirt-price">
        $0
        </div>
    </div>
    <div class="Dirt-btn">
        <button id="Dirt-health-btn" class="active" data-button="dirt">Buy</button>
    </div>
        `)
    } else if (button ==  "body") {
        $(".Body-Health").html(`
        <div class="body-text1">
        Body Health
        </div>  
        <div id="Body-Health-percentage" style="color: #4ba55b;">
        100%
        </div>
        <div class="price-box">
            <div id="price">
                $0
            </div>
        </div>
        <div class="body-btn">
        <button id="body-health-btn" class="active" >Buy</button>
        </div>
        </div>
        `)
    } else if (button == "engine") {
        $(".Engine-Health").html(`
        <div class="Engine-text1">
        Engine Health
        </div>  
        <div id="Engine-Health-percentage" style="color: #4ba55b;">
        100%
        </div>
        <div class="Engine-price-box">
            <div id="Engine-price">
            $0
            </div>
        </div>
        <div class="Engine-btn">
        <button id="Engine-health-btn" class="active">Buy</button>
        </div>
        `)
    } else if (button == "dirt") {
        $(".Dirt-Level").html(`
        <div class="Dirt-text1">
        Dirt Level
    </div> 
    <div class="percentage">
        <div id="Dirt-Health-percentage" style="color: #4ba55b;">
            0%
        </div>
    </div>
    <div class="Dirt-price-box">
        <div id="Dirt-price">
        $0
        </div>
    </div>
    <div class="Dirt-btn">
        <button id="Dirt-health-btn" class="active" data-button="dirt style="cursor: not-allowed;"">Buy</button>
    </div>
        `)
    } 
    
}



(() => {
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    OpenUI(event.data)
                    break;
                case 'update':
                    Update(event.data.button)
                    break;
            }
        })
    }
})();