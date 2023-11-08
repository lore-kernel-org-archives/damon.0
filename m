Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B95A2FE2E
	for <damon@lists.linux.dev>; Wed,  8 Nov 2023 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHZKEOBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EEEC433C7;
	Wed,  8 Nov 2023 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699455341;
	bh=SyHUGqhq5GhN6Gpzy5MDudMqRL6roYzi8hTlHcwugmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=lHZKEOBFK/+KyUgKy1aQ3b8vedxJ775eRg4e5saOWvKQdUvFxW3rfhZ+IBVMKffmB
	 dBqbkhk8TaX+o8WjpFezjXkjKRQJxztFflyveEgVoqt4zX5gmWaHXi2z04/ZxTYNIc
	 2woteo23i+eMysuMeAQR68NJygYbLyJypqb2C4gKtgwPzu/90zC+t/nwL3YSs8KSsJ
	 lJfvKNuJocQ17kqPT9YZzFYQNhRoy6H8OJwAAmwgVEy0B4bc9QXvXzSgQnIKWACSWn
	 ZrZ2/zvGoHc/i08rfwnpH7NGbQaoZRkX8wul3UeQ+mV5qSGKNVQxWiOiPOmUV/8FHf
	 m6VUqowYy6P5g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Wed,  8 Nov 2023 06:55:25 -0800
Message-Id: <20231108145525.12650-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909173856.55818-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hello Community,

On Fri, 9 Sep 2022 17:38:56 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Tue, 30 Aug 2022 21:54:28 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Hello,
> > > 
> > > 
> > > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > > meeting series for DAMON community.
> > > 
> > > Important links and dates
> > > -------------------------
> > > 
> > > Location: https://meet.google.com/ndx-evoc-gbu
> > > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> > > 
> > > First instance: 2022-08-15 18:00 PDT
> > > Second instance: 2022-08-30 09:00 PDT
[...]
> 
> And I just received the acceptance notification of my BoF proposal.  The
> schedule is not updated yet, but I guess it should be 2022-09-14 (Wednesday)
> 17:00-18:30 in Irish Standard Time (IST, UTC+01:00, Europe/Dublin timezone).
> So, our next DAMON Beer/Coffee/Tea Chat series will be held in LPC2022, in
> person.  I will update the final time and location as soon as possible.

Like the last year, DAMON BoF at LPC has accepted and scheduled[1].  So we will
have the second in-person DAMON community meetup (a.k.a Beer/Coffee/Tea Chat)!
The schedule is Wednesday 4:30 PM, EST.  I hope it to be the place to meet with
community members, say hi to each other, and discuss any interesting things.
Since that's the close to the end of the conference, it could also be a good
place to say good bye to each other :)

Of course, please don't wait until the time slot if you have anything want to
ask to, or discuss with me.  If you find me on the hall, I'm yours :)

Please also note that I'll have a talk about DAMON status and plans[2] at
kernel summit.  The talk will start 2:30 PM, EST, of the same day (Wednesday).
So if I fail at time managing again and therefore if your question is not
answered, the BoF will be a nice place for that.

Looking forward to meet you all!

[1] https://lpc.events/event/17/contributions/1652/
[2] https://lpc.events/event/17/contributions/1624/


Thanks,
SJ

[...]
