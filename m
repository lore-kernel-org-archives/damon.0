Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DD3B8D4B;
	Sat, 13 Dec 2025 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765605218; cv=none; b=doa3x0uPFtGhOYN1Cdep8eC7Prs+6vwtxKG9eb8mt6yufb1f6wNR8j5IQ8Nak+LzT0ZnAmizV26MFudFVa0D6QbLVo6g1Y5pXeHgmhtdZL3AvpCUZxdZKUugwOnNL+zUV06kib5mWO1ye9mlcTzEe35C7+in33zhqnGbUlUj41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765605218; c=relaxed/simple;
	bh=Wccp+wZXScgD8eLeujdXQFZ/mmoEHYeNoY4rN4AzM+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm60b+P4RlHOwjyw5/UUNZrSn46cuXqWW1DKflHm9owpJFLheOR0w9t7bfR2DdalEaZsqwQuuo6TFQS3b17wB4I41V81OQZKLAn9/455SMN2K2tOs3tKDz6KRMEUQdOYjrNp4La9u6u/1+pkgd/uzsPEnzBtjav65zXDDKG5Fl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So410YQ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So410YQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A307C4CEF7;
	Sat, 13 Dec 2025 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765605218;
	bh=Wccp+wZXScgD8eLeujdXQFZ/mmoEHYeNoY4rN4AzM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=So410YQ6KPo6pKsazNewNsZwmkjx1uv56FwCs5LKCdpaAhqfwNKHd2w/UkMnSPDj5
	 umohLOb8ZXoe1fecaDJkCrJT+Bvjlae+fr5JDcKos/Nk/zekY0DGBg1x1T6/52qUGv
	 HUzJDPCtlKvvDVxU7OvOcA0ekgZBJklfeHbrwFajcEL84rPyLwM/4H3lVHHuASGn+r
	 tHY+3KJZh4xRXDoRpkMjZghg3LCPlcGen/JUapCj9FRd+kz/jl0HZb7I5TKSPOYs2k
	 A3PbECVA+IJLqgrL/ZMeRjKGJf5yE4zb8FBKihMdmBhRcvGizjvEDdh4jCpN7sJdds
	 wMl3mTo235Mdw==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high level snapshot
Date: Fri, 12 Dec 2025 21:53:34 -0800
Message-ID: <20251213055334.51806-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC5izV51xSXFBBijVOCaffwimbmEe6YPk2AVJWXAK59t+w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Dec 2025 13:09:37 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Sat, 13 Dec 2025 at 12:21, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sat, 13 Dec 2025 10:10:38 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Sat, 13 Dec 2025 at 08:11, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Fri, 12 Dec 2025 22:20:04 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > >
> > > > > On Mon, 8 Dec 2025 at 15:35, SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > Now any DAMON API callers can report their observed access information.
> > > > > > The DAMON core layer is just ignoring those, though.  Update the core to
> > > > > > use the reported information at building the high level access pattern
> > > > > > snapshot.
> > > > >
> > > > > It seems inefficient to repeatedly access the damon_access_reports[1000] array
> > > > > using a for loop in the kdamond_check_reported_accesses() function.
> > > > > It is inefficient to for loop through the entire
> > > > > damon_access_reports[1000] array.
> > > > > When CONFIG_HZ and jiffies are increased as follows and
> > > > > damond sample_interval is 5000us (5ms), the time flow diagram is as follows.
> > > > >
> > > > > CONFIG_HZ 1000, jiffies == 1ms
> > > > > damond sample_interval == 5000us (5ms)
> > > > >
> > > > > reports_len(==): [0 ... 5]
> > > > >                                                      [*]
> > > > >         0    1    2    3    4    5     6    7    8    9        997    998     999
> > > > >         [====|====|====|====|====]-----|----|----|----|  ....  |------|-------|
> > > > > jiffies++    1    2    3    4    5     0    0    0    0        0      0       0
> > > > > damond_fn(sample interval)      -5[0<]
> > > > >
> > > > > reports_len(==): [997 ... 2]
> > > > >                                   [*]
> > > > >         0      1      2    3    4    5     6    7    8    9        997   998   999
> > > > >         [======|======]----|----|----|-----|----|----|----|  ....  [=====|=====]
> > > > > jiffies++   1001      1002 3    4    5     6    7    8    9        997   998   999
> > > > > damond_fn(sample interval)
> > > > >                             -5[997<]
> > > >
> > > > Please use fixed-length fonts for something like above, from next time.  I
> > > > fixed the diagram with my best effort, as above.  But I still fail at
> > > > understanding your point.  More clarification about what the diagram means
> > > > would be nice.
> > >
> > > Thank you for readjusting the font to fit.  The first diagram above is when
> > > reports_len is processed normally starting from 0 to reports_len.
> > > The second diagram shows the process where reports_len increases to its
> > > maximum values of 997, 998, 999, and then returns to 0.
> >
> > Thank you for adding this clarification.
> >
> > > The biggest problem here is that the latter part of the array is not processed.
> >
> > I don't get what "processed" is meaning, and what is the latter part of the
> > array that not processed, and why it is a problem.  Could you please clarify?
> 
> I'll just organize the code related to this issue as below.
> This applies when kdamond_check_reported_accesses() is executed
> when damon_access_reports_len becomes DAMON_ACCESS_REPORTS_CAP.
> 
> void damon_report_access(struct damon_access_report *report)
> {
>         ...
>         if (damon_access_reports_len == DAMON_ACCESS_REPORTS_CAP)
>                 damon_access_reports_len = 0;
>         ...
> }
> 
> static void kdamond_check_reported_accesses(struct damon_ctx *ctx)
> {
>         for (i = 0; i < damon_access_reports_len; i++) {
>                 ...
>         }
> }

Ok, so I understand that when damon_access_reports_len is reset, the reports
that stored at the end part of the array is simply ignored.  And your suggested
change can fix it.

> 
> >
> > >
> > > >
> > > > >
> > > > > It seems that only the section corresponding to the sample interval ([==|==])
> > > > > can be cycled as follows.  And, how about enjoying damon_access_reports[1000]
> > > > > as damon_access_reports[500]?  Even if it reduce the 1000ms to 500ms
> > > > > array space, it seems that it can sufficiently report and process within
> > > > > the sample interval of 5ms.
> > > >
> > > > Are you assuming the the reports can be made only once per 1 millisecond?  That
> > > > is not true.  The design assumes any kernel API caller could make the report,
> > > > so more than one report can be made within one millisecond.  Am I
> > > > missingsomething?
> > >
> > > jiffies 1ms is just to simply unfold the passage of time when
> > > CONFIG_HZ is set to 1000.
> > > This is a simplification to help it understand the flow of time.
> >
> > So I understand you are saying that only one report can be made per jiffy.  But
> > that doesn't answer my question because I'm saying that design allows any
> > report at any time.  Any number of reports can be made within one jiffy time
> > interval.
> 
> The input events are what you pointed out, but when reporting,
> it is processed in jiffies time with time_before/after().
> So we have to take everyone into consideration.

I don't get your point yet.  Can you please elaborate?

> 
> >
> > >
> > > >
> > > > >
> > > > >  static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
> > > > >  {
> > > > > -       int i;
> > > > > +       int i = damon_access_reports_len;
> > > > > +       unsigned int nr = 0;
> > > > >         struct damon_access_report *report;
> > > > >         struct damon_target *t;
> > > > >
> > > > > @@ -2904,16 +2905,18 @@ static unsigned int
> > > > > kdamond_check_reported_accesses(struct damon_ctx *ctx)
> > > > >                 return 0;
> > > > >
> > > > >         mutex_lock(&damon_access_reports_lock);
> > > > > -       for (i = 0; i < damon_access_reports_len; i++) {
> > > > > -               report = &damon_access_reports[i];
> > > > > -               if (time_before(report->report_jiffies,
> > > > > -                                       jiffies -
> > > > > -                                       usecs_to_jiffies(
> > > > > -                                               ctx->attrs.sample_interval)))
> > > > > -                       continue;
> > > > > +       report = &damon_access_reports[i];
> > > > > +       while (time_after(report->report_jiffies,
> > > > > +               jiffies - usecs_to_jiffies(ctx->attrs.sample_interval))) {
> > > > >                 damon_for_each_target(t, ctx)
> > > > >                         kdamond_apply_access_report(report, t, ctx);
> > > > > +               if (++nr >= DAMON_ACCESS_REPORTS_CAP)
> > > > > +                       break;
> > > > > +
> > > > > +               i = (i == 0) ? (DAMON_ACCESS_REPORTS_CAP - 1) : (i - 1);
> > > > > +               report = &damon_access_reports[i];
> > > > >         }
> > > > > +
> > > > >         mutex_unlock(&damon_access_reports_lock);
> > > > >         /* For nr_accesses_bp, absence of access should also be reported. */
> > > > >         return kdamond_apply_zero_access_report(ctx);
> > > > > }
> > > >
> > > > So I still don't get your points before the above code diff, but I understand
> > > > this code diff.
> > > >
> > > > I agree this is more efficient.  I will consider doing something like this in
> > > > the next spin.
> > >
> > > What I tried above is to process the current array [1000] as
> > > efficiently as possible.
> > > But, if I think again, It would be better to store it in a linked-list
> > > and process it
> > > in FIFO mode whenever requested in damon_report_page_fault(),
> > > damon_report_access(report)
> > > instead of storing it in an array.  I'm also analyzing the source code
> > > starting this week,
> > > so I'll organize it a bit more and get back to you with my opinion.
> >
> > I personally don't feel linked list is specially better than the current
> > ring-buffer like implementation at the moment.  But I would be happy to learn
> > new ideas.  Please feel free to revisit when you get a chance.
> 
> I agree that the ring-buffer you mentioned is good.
> However, if this is not well controlled, it is less efficient than FIFO,
> so I am analyzing your source code a bit more.

We consider not only efficiency but also simplicity.  Please keep that in mind.


Thanks,
SJ

[...]
