function Gobang(canvasDOM, rows, cols) {
    function Background(rows, cols) {
        this.rows = rows;
        this.cols = cols;
        this.draw = function() {
            this.canvas.fillStyle = "rgb(208, 141, 47)";
            this.canvas.fillRect(0, 0, this.canvasWidth, this.canvasHeight);
            this.canvas.fillStyle = "#000000";

            this.canvas.beginPath();
            var cellWidth = this.canvasWidth / (this.cols + 1);
            var cellHeight = this.canvasHeight / (this.rows + 1);
            for (var i = 1; i <= this.cols; i++) {
                this.canvas.moveTo(cellWidth * i, cellHeight);
                this.canvas.lineTo(cellWidth * i, this.canvasHeight - cellHeight);
            }
            for (var i = 1; i <= this.rows; i++) {
                this.canvas.moveTo(cellWidth, cellHeight * i);
                this.canvas.lineTo(this.canvasWidth - cellWidth, cellHeight * i);
            }
            this.canvas.closePath();
            this.canvas.stroke();
        }
    }

    function StonePool(rows, cols) {
        this.draw = function(currentPlayer) {
            var white = (currentPlayer == 0);
            var radius = this.game.cellWidth + this.game.cellHeight;
            radius /= 4;
            this.canvas.fillStyle = white ? '#fff' : '#000';
            for (var i = this.moves.length - 1; i >= 0; i--) {
                this.canvas.fillStyle = currentPlayer == 0 ? "#000" : "#fff";
                this.canvas.beginPath();
                this.canvas.arc(this.moves[i][1] * this.game.cellWidth + this.game.cellWidth,
                        this.moves[i][0] * this.game.cellHeight + this.game.cellHeight,
                        radius, 0, 2 * Math.PI);
                this.canvas.closePath();
                this.canvas.fill();
                currentPlayer = 1 - currentPlayer;

                if (i == this.moves.length - 1) {
                    this.canvas.fillStyle = "#f00";
                    this.canvas.beginPath();
                    this.canvas.arc(
                            this.moves[i][1] * this.game.cellWidth + this.game.cellWidth,
                            this.moves[i][0] * this.game.cellHeight + this.game.cellHeight, 
                            3, 0, 2 * Math.PI);
                    this.canvas.closePath();
                    this.canvas.fill();
                }
            }
        }
    }

    /* utils */
    this.inBoard = function (row, col) {
        return row >= 0 && col >= 0 && row < this.rows && col < this.cols;
    }

    this.rows = rows ? rows : 15;
    this.cols = cols ? cols : 15;

    this.currentPlayer = 0;
    this.moves = [];
    this.grid = new Array(this.rows);
    for (var i = 0; i < this.rows; i++) 
        this.grid[i] = new Array(this.cols);

    this.enableAI = true;
    this.hardness = 2;
    this.newMove = function(row, col, isAI) {
        if (this.grid[row][col] != -1) return;
        this.grid[row][col] = this.currentPlayer;
        this.moves.push([row, col]);

        this.draw();

        if (this.winningMove(row, col)) {
            var winnerDOM = document.getElementById("gobang-winner");
            if (this.currentPlayer == 0)
                winnerDOM.innerHTML = "Black";
            else
                winnerDOM.innerHTML = "White";

            if (isAI)
                winnerDOM.innerHTML = winnerDOM.innerHTML + "-AI";

            this.currentPlayer = 0;
            this.finish();
            return;
        }

        this.currentPlayer = 1 - this.currentPlayer;

        /* AI */
        if (!isAI && this.enableAI) {
            var startTime = Date.now() / 1000;
            var waitingPanel = document.getElementById("gobang-waiting");
            waitingPanel.style.display = "table";
            var that = this;
            setTimeout(function() {
                ret = AI.play(that.grid, that.currentPlayer, that.hardness);
                waitingPanel.style.display = "none";
                var elapsed = (Date.now() / 1000 - startTime);
                console.log("AI said: ", ret[0], ret[1], " Spent: ", elapsed, " seconds.");
                that.newMove(ret[1][0], ret[1][1], true);
            }, 40);
        }
    }
    this.regret = function() {
        var tmp = this.moves.pop();
        if (tmp)
            this.grid[tmp[0]][tmp[1]] = -1;
        tmp = this.moves.pop();
        if (tmp)
            this.grid[tmp[0]][tmp[1]] = -1;
        this.currentPlayer = 1 - this.currentPlayer;
        this.draw();
        this.currentPlayer = 1 - this.currentPlayer;
    }

    this.winningMove = function(row, col) {
        for (var i = -1; i <= 1; i++)
            for (var j = -1; j <= 1; j++) {
                if (i == 0 && j == 0) continue;
                var cnt = 1;
                // Two direction
                for (var dir = -1; dir <= 1; dir+=2) {
                    for (var l = 1; l <= 4; l++) {
                        newrow = row + dir * i * l; 
                        newcol = col + dir * j * l;
                        if (this.inBoard(newrow, newcol) && 
                                this.currentPlayer == this.grid[newrow][newcol])
                            cnt++;
                        else
                            break;
                        if (cnt == 5)
                            return true;
                    }
                }
                if (cnt >= 5) return true;
            }
        return false;
    }

    this.init = function() {
        this.canvasDOM = canvasDOM;
        this.mainCanvas = canvasDOM.getContext("2d");
        if (!this.mainCanvas) return false;
        this.width = canvasDOM.width;
        this.height = canvasDOM.height;
        this.cellWidth = this.width / (this.cols + 1);
        this.cellHeight = this.height / (this.rows + 1);

        this.hoverCanvasDOM = document.createElement("canvas");
        this.hoverCanvasDOM.width = this.width;
        this.hoverCanvasDOM.height = this.height;
        this.hoverCanvas = this.hoverCanvasDOM.getContext("2d");
        document.getElementsByClassName("gobang-container")[0].appendChild(this.hoverCanvasDOM);

        document.getElementById("gobang-result").style.display = "none";
        document.getElementById("gobang-welcome").style.display = "table";
        var game = this;
        var buttons = document.getElementsByClassName("gobang-start");
        for (var i = 0; i < buttons.length; i++)
            buttons[i].onclick = function() {
                game.run();
            }

        Background.prototype.canvas = this.mainCanvas;
        Background.prototype.canvasWidth = this.width;
        Background.prototype.canvasHeight = this.height;
        Background.prototype.game = this;

        StonePool.prototype.canvas = this.mainCanvas;
        StonePool.prototype.canvasWidth = this.width;
        StonePool.prototype.canvasHeight = this.height;
        StonePool.prototype.moves = this.moves;
        StonePool.prototype.game = this;

        this.bg = new Background(this.rows, this.cols);
        this.stones = new StonePool(this.rows, this.cols);
        return true;
    }

    this.draw = function() {
        this.bg.draw();
        this.stones.draw(this.currentPlayer);
    }

    this.clearHover = function() {
        this.hoverCanvas.clearRect(0, 0, 
                this.hoverCanvasDOM.width, this.hoverCanvasDOM.height);
    }

    this.drawFocus = function(row, col) {
        this.clearHover();
        this.hoverCanvas.beginPath();
        this.hoverCanvas.fillStyle = "#000000";
        this.hoverCanvas.rect(
                col * this.cellWidth + this.cellWidth / 2, 
                row * this.cellHeight + this.cellHeight / 2, 
                this.cellWidth,
                this.cellHeight);
        this.hoverCanvas.closePath();
        this.hoverCanvas.stroke();
    }
    
    this.run = function() {
        this.moves.splice(0, this.moves.length);
        for (var i = 0; i < this.rows; i++)
            for (var j = 0; j < this.cols; j++)
                this.grid[i][j] = -1;

        this.draw();

        document.getElementById("gobang-welcome").style.display = "none";
        document.getElementById("gobang-result").style.display = "none";

        var game = this;
        function coordOnBoard(element, e) {
            var ratioX = canvasDOM.width / canvasDOM.offsetWidth;
            var ratioY = canvasDOM.height / canvasDOM.offsetHeight;
            return {
                y: Math.round((e.pageY - element.offsetTop) * ratioY / game.cellHeight) - 1,
                x: Math.round((e.pageX - element.offsetLeft) * ratioX / game.cellWidth) - 1
            };
        }
        this.hoverCanvasDOM.onclick = function(e) {
            pos = coordOnBoard(this, e);
            if (pos.x >= 0 && pos.y >= 0 && pos.x < game.cols && pos.y < game.rows)
                game.newMove(pos.y, pos.x);
        }
        var mouseOnBoard = false;
        this.hoverCanvasDOM.addEventListener("mouseover", function(e) {
            mouseOnBoard = true;
        });
        this.hoverCanvasDOM.addEventListener("mousemove", function(e) {
            if (!mouseOnBoard) return;
            pos = coordOnBoard(this, e);
            if (pos.x >= 0 && pos.y >= 0 && pos.x < game.cols && pos.y < game.rows)
                game.drawFocus(pos.y, pos.x);
        });
        this.hoverCanvasDOM.addEventListener("mouseout", function(e) {
            mouseOnBoard = false;
            game.clearHover();
        });
    }

    this.finish = function(winner) {
        document.getElementById("gobang-welcome").style.display = "none";
        document.getElementById("gobang-result").style.display = "table";
        canvasDOM.onclick = null;
    }
}
