Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A502E6CC6;
	Sat, 13 Dec 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765596092; cv=none; b=j9eys3QdEWFoz3D+2rK3kLFcZs2XO4TCMFPGHwyzdkBAx4bTLSdsg4NnvkyF/x/BABS4t6SXMfgImopF2RGEHbCzV93TDQ1/3v2bCuT/1yFdPm1/faIDdoobGxpiZ4fKh5erk0dDeKkb0OL13mjR52eOIFPr25hfP3lkzHuQlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765596092; c=relaxed/simple;
	bh=kT7u+4G4tMNU0hzWWYdQK1IaQytQ2ZSZvqDLHNbzUT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/cVdXYDh2MWoWb0+INtWPZva+KmjOC35Gltlsdq4bR5HH4ZzIFelNPaP57hdsBFoEFcbnNg42X1NjADBfBHhq7WPMxSGSzcoifJbe8/LgddgAAxoql/Nu2wmONdvPADtDzQM1I1Re77wd31RfgYS3NF475eLsYU5nCmH135GrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeN+3Fex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeN+3Fex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EB1C113D0;
	Sat, 13 Dec 2025 03:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765596091;
	bh=kT7u+4G4tMNU0hzWWYdQK1IaQytQ2ZSZvqDLHNbzUT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeN+3FexFboZmXsDmmxLJJloFnjNMI6naFV3jgHQ1CjrdiU7L9L6rRoFZL5/Ol0eR
	 Y3L87T6YGDnpRN0ZT61u9udq9P52/6sLk6fd8qzzDIr2rWnDxcfrq/FljOTeLLHBZZ
	 IWKTw5EX4gWH0BXC9/dem2rIAvUgHoeAf8Y0Zf/eU6lmESJQ7AKPhzDWeLlQO11EGQ
	 0E3hBLCIhScL+TiMs7aokWaAvSWKzWRa5gUdJedohhLyDYfAbyDgHJSkrhGG5mriYb
	 jmx2KNy/KJh/ExOeDfBMgiTFTRHBDp1ikpr7nKOJ/sH4cnn/B5MqUreSJNCudO9SxI
	 t+WZFKcPclRCw==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high level snapshot
Date: Fri, 12 Dec 2025 19:21:27 -0800
Message-ID: <20251213032128.50837-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6TXo=7svC2Ka=+rf_YLTMnaF8QUV_nNvuef20XMZ=+pA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Dec 2025 10:10:38 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Sat, 13 Dec 2025 at 08:11, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 12 Dec 2025 22:20:04 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Mon, 8 Dec 2025 at 15:35, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Now any DAMON API callers can report their observed access information.
> > > > The DAMON core layer is just ignoring those, though.  Update the core to
> > > > use the reported information at building the high level access pattern
> > > > snapshot.
> > >
> > > It seems inefficient to repeatedly access the damon_access_reports[1000] array
> > > using a for loop in the kdamond_check_reported_accesses() function.
> > > It is inefficient to for loop through the entire
> > > damon_access_reports[1000] array.
> > > When CONFIG_HZ and jiffies are increased as follows and
> > > damond sample_interval is 5000us (5ms), the time flow diagram is as follows.
> > >
> > > CONFIG_HZ 1000, jiffies == 1ms
> > > damond sample_interval == 5000us (5ms)
> > >
> > > reports_len(==): [0 ... 5]
> > >                                                      [*]
> > >         0    1    2    3    4    5     6    7    8    9        997    998     999
> > >         [====|====|====|====|====]-----|----|----|----|  ....  |------|-------|
> > > jiffies++    1    2    3    4    5     0    0    0    0        0      0       0
> > > damond_fn(sample interval)      -5[0<]
> > >
> > > reports_len(==): [997 ... 2]
> > >                                   [*]
> > >         0      1      2    3    4    5     6    7    8    9        997   998   999
> > >         [======|======]----|----|----|-----|----|----|----|  ....  [=====|=====]
> > > jiffies++   1001      1002 3    4    5     6    7    8    9        997   998   999
> > > damond_fn(sample interval)
> > >                             -5[997<]
> >
> > Please use fixed-length fonts for something like above, from next time.  I
> > fixed the diagram with my best effort, as above.  But I still fail at
> > understanding your point.  More clarification about what the diagram means
> > would be nice.
> 
> Thank you for readjusting the font to fit.  The first diagram above is when
> reports_len is processed normally starting from 0 to reports_len.
> The second diagram shows the process where reports_len increases to its
> maximum values of 997, 998, 999, and then returns to 0.

Thank you for adding this clarification.

> The biggest problem here is that the latter part of the array is not processed.

I don't get what "processed" is meaning, and what is the latter part of the
array that not processed, and why it is a problem.  Could you please clarify?

> 
> >
> > >
> > > It seems that only the section corresponding to the sample interval ([==|==])
> > > can be cycled as follows.  And, how about enjoying damon_access_reports[1000]
> > > as damon_access_reports[500]?  Even if it reduce the 1000ms to 500ms
> > > array space, it seems that it can sufficiently report and process within
> > > the sample interval of 5ms.
> >
> > Are you assuming the the reports can be made only once per 1 millisecond?  That
> > is not true.  The design assumes any kernel API caller could make the report,
> > so more than one report can be made within one millisecond.  Am I
> > missingsomething?
> 
> jiffies 1ms is just to simply unfold the passage of time when
> CONFIG_HZ is set to 1000.
> This is a simplification to help it understand the flow of time.

So I understand you are saying that only one report can be made per jiffy.  But
that doesn't answer my question because I'm saying that design allows any
report at any time.  Any number of reports can be made within one jiffy time
interval.

> 
> >
> > >
> > >  static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
> > >  {
> > > -       int i;
> > > +       int i = damon_access_reports_len;
> > > +       unsigned int nr = 0;
> > >         struct damon_access_report *report;
> > >         struct damon_target *t;
> > >
> > > @@ -2904,16 +2905,18 @@ static unsigned int
> > > kdamond_check_reported_accesses(struct damon_ctx *ctx)
> > >                 return 0;
> > >
> > >         mutex_lock(&damon_access_reports_lock);
> > > -       for (i = 0; i < damon_access_reports_len; i++) {
> > > -               report = &damon_access_reports[i];
> > > -               if (time_before(report->report_jiffies,
> > > -                                       jiffies -
> > > -                                       usecs_to_jiffies(
> > > -                                               ctx->attrs.sample_interval)))
> > > -                       continue;
> > > +       report = &damon_access_reports[i];
> > > +       while (time_after(report->report_jiffies,
> > > +               jiffies - usecs_to_jiffies(ctx->attrs.sample_interval))) {
> > >                 damon_for_each_target(t, ctx)
> > >                         kdamond_apply_access_report(report, t, ctx);
> > > +               if (++nr >= DAMON_ACCESS_REPORTS_CAP)
> > > +                       break;
> > > +
> > > +               i = (i == 0) ? (DAMON_ACCESS_REPORTS_CAP - 1) : (i - 1);
> > > +               report = &damon_access_reports[i];
> > >         }
> > > +
> > >         mutex_unlock(&damon_access_reports_lock);
> > >         /* For nr_accesses_bp, absence of access should also be reported. */
> > >         return kdamond_apply_zero_access_report(ctx);
> > > }
> >
> > So I still don't get your points before the above code diff, but I understand
> > this code diff.
> >
> > I agree this is more efficient.  I will consider doing something like this in
> > the next spin.
> 
> What I tried above is to process the current array [1000] as
> efficiently as possible.
> But, if I think again, It would be better to store it in a linked-list
> and process it
> in FIFO mode whenever requested in damon_report_page_fault(),
> damon_report_access(report)
> instead of storing it in an array.  I'm also analyzing the source code
> starting this week,
> so I'll organize it a bit more and get back to you with my opinion.

I personally don't feel linked list is specially better than the current
ring-buffer like implementation at the moment.  But I would be happy to learn
new ideas.  Please feel free to revisit when you get a chance.


Thanks,
SJ

[...]
