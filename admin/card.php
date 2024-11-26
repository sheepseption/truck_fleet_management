<?php
function card_graphic($title, $chartId, $chartType = 'bar', $data = [], $labels = [], $backgroundColor = 'rgba(75, 192, 192, 0.2)', $borderColor = 'rgba(75, 192, 192, 1)') {
    $dataJson = json_encode($data);
    $labelsJson = json_encode($labels);
    echo "
    <div class='card m-3 p-3' style='flex: 1; min-width: 300px;'>
        <h4 class='text-center'>$title</h4>
        <canvas id='$chartId'></canvas>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                var ctx = document.getElementById('$chartId').getContext('2d');
                new Chart(ctx, {
                    type: '$chartType',
                    data: {
                        labels: $labelsJson,
                        datasets: [{
                            label: '$title',
                            data: $dataJson,
                            backgroundColor: '$backgroundColor',
                            borderColor: '$borderColor',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            });
        </script>
    </div>
    ";
}
?>