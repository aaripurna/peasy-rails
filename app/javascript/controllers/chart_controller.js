import { Controller } from "@hotwired/stimulus";
import Chart from 'chart.js/auto';


export default class extends Controller {
  static targets = ['counts', 'average']

  connect() {
    this.fetchUserCounts(data => {
      this.userCountChart(data)
      this.userAverageAgeChart(data)
    })
  }

  fetchUserCounts(callback) {
    fetch("/user_counts")
      .then(r => r.json())
      .then(data => callback(data))
      .catch(e => {
        alert("Error fetching data")
      })
  }

  userCountChart(data) {
    if(!data.male_count || !data.female_count) return;

    new Chart(this.countsTarget, {
      type: 'bar',
      data: {
        labels: ['Male', 'Female'],
        datasets: [{
          label: 'User Count',
          data: [data.male_count, data.female_count]
        }]
      }
    })
  }

  userAverageAgeChart(data) {
    if(!data.male_count || !data.female_count) return;

    new Chart(this.averageTarget, {
      type: 'bar',
      data: {
        labels: ['Male', 'Female'],
        datasets: [{
          label: 'User Average Age',
          data: [parseFloat(data.male_avg_age).toFixed(2), parseFloat(data.female_avg_age).toFixed(2)]
        }]
      }
    })
  }
}