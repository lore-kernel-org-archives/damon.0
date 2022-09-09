Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16653A4
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 17:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D9FC433C1;
	Fri,  9 Sep 2022 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662745139;
	bh=B66a8C1X/c5zPewOicz13RnmstNqV+5vYGnV+DI9Mz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQUDETN+LWBmPfZErXpnHaqb5uHodgXScTK0tOX7PaLs1Ru3xF69TKwoe+EfGMxqE
	 SGigusBOUu8DfkZhAulf2pHsBGsjWY5koB6BfUwmGedQQF4p98VbcFt3AOp1yN6DUa
	 6Y3PVjL6DwvpAwITuK4hc1usAVK//cnn9AgxoemUY5nCLo5zKn169+WTgk6rRzh79a
	 8J1rIQZUcZFoy6AA48Ye21VyJZdAHsa6IGb6hRrfOnEM+QRxrSehqYSskZ5uYOo096
	 Zvq544TCpNCfkEcp53JaXguHU4xUgom5w1XFkpG/G7c50REz0jB1JdUCo6/1XaX69C
	 28aPkpL0aB3lg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Fri,  9 Sep 2022 17:38:56 +0000
Message-Id: <20220909173856.55818-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830215428.84567-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 30 Aug 2022 21:54:28 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> > 
> > First instance: 2022-08-15 18:00 PDT
> > Second instance: 2022-08-30 09:00 PDT
> 
> According to the bi-weekly schedule, the third instance of this meeting series
> should be scheduled to 2022-09-12 18:00 PDT.  It means it will conflict with
> LPC'22[1].  For the reason, I'd like to reserve a session in the BoF trakc of
> the conference, and do an _in-persion_ DAMON community meeting in the session.
> The session could also include some followup QnA/discussions of the kernel
> summit DAMON talk[2].
> 
> I just submitted the BoF proposal asking it to be scheduled after the kernel
> summit DAMON talk.  I will provide further update once I get the feedback from
> the committee.  Hope it to be accepted!

And I just received the acceptance notification of my BoF proposal.  The
schedule is not updated yet, but I guess it should be 2022-09-14 (Wednesday)
17:00-18:30 in Irish Standard Time (IST, UTC+01:00, Europe/Dublin timezone).
So, our next DAMON Beer/Coffee/Tea Chat series will be held in LPC2022, in
person.  I will update the final time and location as soon as possible.

I will also attend OSSummit EU.  Amazon will have a booth there, and I will
also be near the booth in usual.  So if anyone doesn't attend LPC but OSSummit
EU and wants to ask or discuss anything about DAMON, please come and find me
there.  Please feel free to send me mails for making appointment or check my
schedule.

For people who cannot join in person there, I will schedule next virtual
instance of the chat series in the Monday of the LPC's next week.  That is, the
next virtual instance of this chat series will be in

	2022-09-19 18:00 PDT (https://meet.google.com/ndx-evoc-gbu)

I will also update the Google doc for the schedules and agendas:
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

Looking forward to meet you DAMON community in person as many as possible!


Thanks,
SJ

> 
> [1] https://lpc.events/
> [2] https://lpc.events/event/16/contributions/1224/
> 
> 
> Thanks,
> SJ
> 
> [...]
