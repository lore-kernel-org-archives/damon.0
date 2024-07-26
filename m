Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C5368;
	Fri, 26 Jul 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954255; cv=none; b=QMMvdYl6uX3/wnVYelgEmdGTHc+YEFAXj6oV+n42+YMiwlna05MfMHm0OxupAq37WKmV9R87SqCe/+nuHwSCNBy9YXgWca582HI2nXVtz8BCP9nNuDExexNNaNwblwVvg/QhMqiHQLJILtTnIkJ5erZcGMzpL1RKe24lQkVHD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954255; c=relaxed/simple;
	bh=wqIff2sCJxyCkhd5vzmXpYM9Xsdp8Np1s/Dl96BuX08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tsz2CqOrDBUPUYvL1PzWkrwBSz3wTmd3X0IDykuXTK9izu2/eiO2b1mN8TabFNua2K5PjUUCm04MaLgN2BGgbARS5tWHDBNPH4eJngJ4vg1kvnHSbdgVhMErpLvB21BJXd85Fo02XPFg7x0kN6whSyFnURA3HztudBf/MmtzaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQCGSdWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQCGSdWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB6EC116B1;
	Fri, 26 Jul 2024 00:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721954255;
	bh=wqIff2sCJxyCkhd5vzmXpYM9Xsdp8Np1s/Dl96BuX08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQCGSdWiNin82MMGIuNreTmIdunT9mRTrMhIUpPiyySFfwsnKURSe2xTVOO4Q+e9Q
	 bgx+RZO39jB2P1I99tnT/dNGbQdnKdWvzZxEKSZ0LGwDbM2BoiRJTabrecUfn6iz2H
	 +wfKH/qmgjO1VqFCSm9oSa/cllXeQzL4iB6I8fBgeWVuD29FzCE5Rq+iFLO4QaZVL1
	 eQ/X6fEXtxXzdA4W1VitezOy8DKMYwlWytG7NIOnAbGpaB323SmKxRIi+F/novEyfy
	 i1M/08yec3Nhkqo5vOdKtZb+0s5/INjy8Cl61cptlKb1f1qqGIDPeSCqpcvdAc0Y+M
	 x9YRENvjeCVxw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder (was: Re: DAMON Beer/Coffee/Tea chat reminder and extending for office hour)
Date: Thu, 25 Jul 2024 17:37:32 -0700
Message-Id: <20240726003732.47346-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240519163329.150340-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun, 19 May 2024 09:33:29 -0700 SeongJae Park <sj@kernel.org> wrote:
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
> 
[...]
> Firstly, I will regularly provide reminder of the series, probably 1-2 days
> before every instance.
> 
> Secondly, I'm extending this series for reservation-based office hour.  That
> is, I will reserve my time for 30 minutes every two weeks, keep the schedule
> public, and encourage people to reserve the time for discussion on a special
> topic for them.  The reservation should be made at least one day before the
> time slot, and will be first-come first-served basis.  In detail, I will
> reserve Monday afternoon or Tuesday morning of the group chat scheduled week.
> Note that this is not necessarily only time slot for such discussion.  You're
> still encouraged to schedule private meetings on your convenience.

So, yet another reminder.

Dedicated-topic discussions
---------------------------

Next three time slots that I reserved in advance for possible future dedicated
topic discussions are as below.

- 2024-07-29 (Mon) 18:00 PT (reserved)
- 2024-08-13 (Tue) 09:30 PT (not yet reserved)
- 2024-08-26 (Mon) 18:00 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available based on the discussion.

Any-topic discussions
---------------------

Next two chat instance for any topic (no reservation is required) are scheduled
as below:

- 2024-07-30 (Tue) 09:30 PT (https://meet.google.com/ndx-evoc-gbu)
- 2024-08-12 (Mon) 18:00 PT (https://meet.google.com/ndx-evoc-gbu)

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t

You can also get the past and upcoming schedules via
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ

[...]
