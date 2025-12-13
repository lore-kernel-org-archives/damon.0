Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD21D6188
	for <damon@lists.linux.dev>; Sat, 13 Dec 2025 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765598991; cv=none; b=jEvVyldRis25QDVtgaz7QeBGaOsgg+3oeA1PoeSEYsZ0N8f9cuhOw5BIkuirxyVT3ttRryGGoHYoNsIQ1L/6faVfBg9AysfMikfBS0onXDp4Z06pUMcHyDf1pE5e5tWePwvJhdSh0KL71sSGG8k6njqpAOaLi1G6iGsDNSbTF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765598991; c=relaxed/simple;
	bh=StqRwWDGHjgkGspiWxnGYLlCG93YfHCyAoUTDt3/xVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgqJ1rt95A/cZque0okiDP7pTTwg3YXm10GVQo5m1oNYuO5/wagBKzs9atMpS0WBkPXsdlPsxV5G/WD22B9NrMQqRF0FUdnN3WEEk6S7A9ZfjI3eterB8oG/yMK/cSlXr7kytNe2BoKirWaWEo0Q/YgpE1l3ok068uO5WhT53dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz/Reyto; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz/Reyto"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78c64370309so18107067b3.2
        for <damon@lists.linux.dev>; Fri, 12 Dec 2025 20:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765598989; x=1766203789; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/HAsPyxpOwek2zebDAB6m9a/MhhIhddpY3TGGSAO0A=;
        b=lz/ReytoMZTaDy5u+53fTKfsmuogmK2HU+/QpwjvfHe67S3gghEzYQCW8ehL+bZLEw
         TjAvnxcmNI+kl96julUbtun5wB9wT1JQUQg6s3sNgtTeHOxC/CgCwz9s1sl2cuF6Kfgk
         5JwUybIqkX4DD9zMtBz/xaGIeaVy9l8Cd7tZrEWjK9cyDlQa+kv5yA9QyBcNYaJBD4sQ
         bzreBf0nWixv/Q6xSvL7Ie21F4jyNp+pysdlFnYh9AGE5SIwY4+cqRHL19401wJe8TBK
         KTSiaMBXSE7AtNdDu1yNKeg2fUGsLWKfFyDeMn9rpCJl35PUSyP9rF67VEtCEla6i9eZ
         SoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765598989; x=1766203789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/HAsPyxpOwek2zebDAB6m9a/MhhIhddpY3TGGSAO0A=;
        b=axu66UEPYyjwDGejRz5WIw08+cF2uaH11nPZKekQosQOtIIfLguFehXvKYaOn44eQs
         WKOPBlQ/Fcj1oudzheFYLrnE27sUduY6FBCXpk4x+w8LJNk+15xy9r5j/FpDJrOF02FC
         1jo/udD0r7/nHhBjebVoHxt06aZZEA9ekNHkjefuT8vdtX/tBBnyK1CmjLCtaNBlZY5P
         nR41nohDYsJFNnji+sQ/BBXFJjL1CNZlfcnxyUYhi3BLWFW19dy45HYNQEl/ULNyn3cY
         Pxx+X4PZ/AIIhq1Aq3u9WWSmXYA/X43WZGmd3VxDwr0IHXvsgOHN3gTG3FroKihxW/f8
         2IwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXllvr+4kemoMEvVDi3c1yOxKJNaIiZMMxtMIxmWXtV05N58bKBQM+q8i1Ea3oaMY00NuO+TA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxwc8GJOe2pKrqcpEL540eXn81Vp8GywR1auz69mUdjoRqRjMU
	WM0iiJ1P6yoeJwh7z+uKMOwyjUpu3N6sSUP+7vsFqnOvIuCU89rIQ8ax/XxdpRzVQQrX43mPODV
	m7ntkAmPnS9+uhkN7x9JwOkfCPi7fGS/9a8D6Wu4=
X-Gm-Gg: AY/fxX4igyF18RIt3QJe4k376jgrWQV4moy70ZGMD5R5JIVn0zPwtYuo65WY4KEnVI6
	mSmIuf0b2O10bUufXWnNsyLUXIkHEXSCu7OO1bWvwU+ijhDmZk/BvcCMZ/SGA92ZuLDg8tnaUUU
	EaEnk7SWp4Q/xtqTn/wJASXokvEUl05/K3HUSWDpk395CWYQY7HrVxPJrvdKtnoMHenpwN4eEOc
	ActXn1QGgV1pAoHbetr+c02iu7QzJozj0TabzPastzyBgDK3K/6nH0PKnA2XcVufNtXu/QR/bwu
	SlxzqWw=
X-Google-Smtp-Source: AGHT+IE2Dkk6szXkQqiUNR6kSrSKxVH9bxB3s7bq/ieDF4UsmcTJCdBoslNFsgvt8an/r6v/t6O+dAihPlvBHvyePw4=
X-Received: by 2002:a05:690c:6306:b0:787:f5c5:c639 with SMTP id
 00721157ae682-78e66ce5a98mr36274727b3.3.1765598988879; Fri, 12 Dec 2025
 20:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6TXo=7svC2Ka=+rf_YLTMnaF8QUV_nNvuef20XMZ=+pA@mail.gmail.com>
 <20251213032128.50837-1-sj@kernel.org>
In-Reply-To: <20251213032128.50837-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 13 Dec 2025 13:09:37 +0900
X-Gm-Features: AQt7F2rolIJNfJ6j7j90N3dzK-4Yx1gdSt7UneU1YzoG00xWzcI9BRDmandvwc8
Message-ID: <CAHOvCC5izV51xSXFBBijVOCaffwimbmEe6YPk2AVJWXAK59t+w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high
 level snapshot
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Dec 2025 at 12:21, SeongJae Park <sj@kernel.org> wrote:
>
> On Sat, 13 Dec 2025 10:10:38 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Sat, 13 Dec 2025 at 08:11, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Fri, 12 Dec 2025 22:20:04 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Mon, 8 Dec 2025 at 15:35, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > Now any DAMON API callers can report their observed access information.
> > > > > The DAMON core layer is just ignoring those, though.  Update the core to
> > > > > use the reported information at building the high level access pattern
> > > > > snapshot.
> > > >
> > > > It seems inefficient to repeatedly access the damon_access_reports[1000] array
> > > > using a for loop in the kdamond_check_reported_accesses() function.
> > > > It is inefficient to for loop through the entire
> > > > damon_access_reports[1000] array.
> > > > When CONFIG_HZ and jiffies are increased as follows and
> > > > damond sample_interval is 5000us (5ms), the time flow diagram is as follows.
> > > >
> > > > CONFIG_HZ 1000, jiffies == 1ms
> > > > damond sample_interval == 5000us (5ms)
> > > >
> > > > reports_len(==): [0 ... 5]
> > > >                                                      [*]
> > > >         0    1    2    3    4    5     6    7    8    9        997    998     999
> > > >         [====|====|====|====|====]-----|----|----|----|  ....  |------|-------|
> > > > jiffies++    1    2    3    4    5     0    0    0    0        0      0       0
> > > > damond_fn(sample interval)      -5[0<]
> > > >
> > > > reports_len(==): [997 ... 2]
> > > >                                   [*]
> > > >         0      1      2    3    4    5     6    7    8    9        997   998   999
> > > >         [======|======]----|----|----|-----|----|----|----|  ....  [=====|=====]
> > > > jiffies++   1001      1002 3    4    5     6    7    8    9        997   998   999
> > > > damond_fn(sample interval)
> > > >                             -5[997<]
> > >
> > > Please use fixed-length fonts for something like above, from next time.  I
> > > fixed the diagram with my best effort, as above.  But I still fail at
> > > understanding your point.  More clarification about what the diagram means
> > > would be nice.
> >
> > Thank you for readjusting the font to fit.  The first diagram above is when
> > reports_len is processed normally starting from 0 to reports_len.
> > The second diagram shows the process where reports_len increases to its
> > maximum values of 997, 998, 999, and then returns to 0.
>
> Thank you for adding this clarification.
>
> > The biggest problem here is that the latter part of the array is not processed.
>
> I don't get what "processed" is meaning, and what is the latter part of the
> array that not processed, and why it is a problem.  Could you please clarify?

I'll just organize the code related to this issue as below.
This applies when kdamond_check_reported_accesses() is executed
when damon_access_reports_len becomes DAMON_ACCESS_REPORTS_CAP.

void damon_report_access(struct damon_access_report *report)
{
        ...
        if (damon_access_reports_len == DAMON_ACCESS_REPORTS_CAP)
                damon_access_reports_len = 0;
        ...
}

static void kdamond_check_reported_accesses(struct damon_ctx *ctx)
{
        for (i = 0; i < damon_access_reports_len; i++) {
                ...
        }
}

>
> >
> > >
> > > >
> > > > It seems that only the section corresponding to the sample interval ([==|==])
> > > > can be cycled as follows.  And, how about enjoying damon_access_reports[1000]
> > > > as damon_access_reports[500]?  Even if it reduce the 1000ms to 500ms
> > > > array space, it seems that it can sufficiently report and process within
> > > > the sample interval of 5ms.
> > >
> > > Are you assuming the the reports can be made only once per 1 millisecond?  That
> > > is not true.  The design assumes any kernel API caller could make the report,
> > > so more than one report can be made within one millisecond.  Am I
> > > missingsomething?
> >
> > jiffies 1ms is just to simply unfold the passage of time when
> > CONFIG_HZ is set to 1000.
> > This is a simplification to help it understand the flow of time.
>
> So I understand you are saying that only one report can be made per jiffy.  But
> that doesn't answer my question because I'm saying that design allows any
> report at any time.  Any number of reports can be made within one jiffy time
> interval.

The input events are what you pointed out, but when reporting,
it is processed in jiffies time with time_before/after().
So we have to take everyone into consideration.

>
> >
> > >
> > > >
> > > >  static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
> > > >  {
> > > > -       int i;
> > > > +       int i = damon_access_reports_len;
> > > > +       unsigned int nr = 0;
> > > >         struct damon_access_report *report;
> > > >         struct damon_target *t;
> > > >
> > > > @@ -2904,16 +2905,18 @@ static unsigned int
> > > > kdamond_check_reported_accesses(struct damon_ctx *ctx)
> > > >                 return 0;
> > > >
> > > >         mutex_lock(&damon_access_reports_lock);
> > > > -       for (i = 0; i < damon_access_reports_len; i++) {
> > > > -               report = &damon_access_reports[i];
> > > > -               if (time_before(report->report_jiffies,
> > > > -                                       jiffies -
> > > > -                                       usecs_to_jiffies(
> > > > -                                               ctx->attrs.sample_interval)))
> > > > -                       continue;
> > > > +       report = &damon_access_reports[i];
> > > > +       while (time_after(report->report_jiffies,
> > > > +               jiffies - usecs_to_jiffies(ctx->attrs.sample_interval))) {
> > > >                 damon_for_each_target(t, ctx)
> > > >                         kdamond_apply_access_report(report, t, ctx);
> > > > +               if (++nr >= DAMON_ACCESS_REPORTS_CAP)
> > > > +                       break;
> > > > +
> > > > +               i = (i == 0) ? (DAMON_ACCESS_REPORTS_CAP - 1) : (i - 1);
> > > > +               report = &damon_access_reports[i];
> > > >         }
> > > > +
> > > >         mutex_unlock(&damon_access_reports_lock);
> > > >         /* For nr_accesses_bp, absence of access should also be reported. */
> > > >         return kdamond_apply_zero_access_report(ctx);
> > > > }
> > >
> > > So I still don't get your points before the above code diff, but I understand
> > > this code diff.
> > >
> > > I agree this is more efficient.  I will consider doing something like this in
> > > the next spin.
> >
> > What I tried above is to process the current array [1000] as
> > efficiently as possible.
> > But, if I think again, It would be better to store it in a linked-list
> > and process it
> > in FIFO mode whenever requested in damon_report_page_fault(),
> > damon_report_access(report)
> > instead of storing it in an array.  I'm also analyzing the source code
> > starting this week,
> > so I'll organize it a bit more and get back to you with my opinion.
>
> I personally don't feel linked list is specially better than the current
> ring-buffer like implementation at the moment.  But I would be happy to learn
> new ideas.  Please feel free to revisit when you get a chance.

I agree that the ring-buffer you mentioned is good.
However, if this is not well controlled, it is less efficient than FIFO,
so I am analyzing your source code a bit more.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
