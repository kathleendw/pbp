$(document).ready(() => {
  getFeedback();
  getSomeFeedback();
})

function addFeedback() {
  const form = $(".addFeedback");
  $.ajax(
  {
      type: "POST",
      url: "/add-feedback/",
      data: form.serialize(),
  }).done(function (data) {
      form.trigger("reset");
      getFeedback();
      getSomeFeedback();
  });
  $("#feedbackModal").modal("hide");
}

function deleteTask(id) {
  $.ajax({
      type: "GET",
      url: "/delete-task/" + id,
      data: {csrfmiddlewaretoken: '{{ csrf_token }}'}
  }).done((data) => {
      getSomeFeedback();
      getFeedback();
  })
}

function getFeedback() {
  $.ajax({
      type: "GET",
      url: "/json-all/"
  }).done((data) => {
      putFeedback(data);
  });
}

function getSomeFeedback() {
  $.ajax({
      type: "GET",
      url: "/json-user/"
  }).done((data) => {
      putSomeFeedback(data);
  });
}

function putFeedback(data) {
  const cardContainer = $('#allFeedback');
  cardContainer.empty();
  data.forEach(task => {
      const taskCard = `
      <li class="card">
          <div>
          <h6 class="card-title">RATING: ${task.fields.rating}/10</h6>
          <h6 class="card-subtitle mb-2 text-muted">${task.fields.date}</h6>
          <div class="card-content">
          <span>
              <p>Feedback: </p>
              <p class="feedback"> ${task.fields.feedback}</p>
          </span>
          </div>
          </div>
      </li>
      `
      cardContainer.append(taskCard);
  })
};

function putSomeFeedback(data) {
  const cardContainer = $('#userFeedback');
  cardContainer.empty();
  data.forEach(task => {
      const taskCard = `
      <li class="card">
          <div>
          <h6 class="card-title">RATING: ${task.fields.rating}/10</h6>
          <h6 class="card-subtitle mb-2 text-muted">${task.fields.date}</h6>
          <div class="card-content">
          <span>
              <p>Feedback: </p>
              <p> ${task.fields.feedback}</p>
          </span>
          </div>
          </div>
          <div class="card-link-wrapper">
          <input type="submit" value="Delete Feedback"  class="btn btn-danger toggleButton" onclick="deleteTask(${ task.pk })" />
          </div>
      </li>
      `
      cardContainer.append(taskCard);
  })
};