Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409EB67E
	for <damon@lists.linux.dev>; Sat, 13 Dec 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765588252; cv=none; b=lZcK2u94zogaWGZ+9RIWgyb8JBFy8co48CkLwVKOz6JuwQ+NEA1gK5Kf8gk7Unx56AlquCgiIeDWrDlUexxT8IYeKWEcLPqDd5SmP/5XDVf+EeeqQg0czIXhaipbvmeOJ/YWquGeKReZtE67WL//bFKsFtghSzvJpQ2k+PJlwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765588252; c=relaxed/simple;
	bh=Z0hITbgab0NjL9CfQOBY1rdkjw21DUmq0JPShIFpQ90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3+xcjx7zHwVQ5y7Mnu1ypEHKv18hH0r23FVVdr4Xu9fly/FC/9RbCQTEh7JZjlm5+Hdhi69dRcEyZf5wb29sYkj9IM/711Pk0l3UrrqEoqwfzHu54Z3ct5OZDQci9BVwRig5W2kWDIT1k50drw9NCJ7Z9EaIGh6XfdDvGYz74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkFkMlGg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkFkMlGg"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78a6a7654a4so18456597b3.0
        for <damon@lists.linux.dev>; Fri, 12 Dec 2025 17:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765588250; x=1766193050; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H69U5CDYHq4197VbTLKqjL8FPFMWb4JhR7VTb4JaM7g=;
        b=SkFkMlGgirx+UrzPkV56/TydaY81xBUAoQDhyJfJIYJghhxh1DCUdiOVCecRfGnwfh
         AemyoBWoaI6VbiiLo78mi3ws+AoIY117IrtwQnaOAxTzlaCz8UyovLk12MEvzU35hr3d
         n+LvOgXqgExK0FZowjPSISrGAaRVxUSWjdM8hq0uOtLUxk97SvkIIA8S95avx4lj9k9D
         GEKRVur+x+JU7MMgML2tZ7cavO7MpirqvklO2VuudCFRn1q0RqmnYRLxnSIEYiLbTdGV
         rLT5E+xHdd6p7zTAFVC8k4ePfh3WiA9N9Bw/tV0lKQYh3NwFTiefUIoTpeKXSSN+lt5v
         HfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765588250; x=1766193050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H69U5CDYHq4197VbTLKqjL8FPFMWb4JhR7VTb4JaM7g=;
        b=rJ3YbAPUSBEBwaAmPBEqQMdrY9drdrc2drCCbEit2ci3aKSKRA/fUacTqkPUJeT6hz
         CirXBwkQF9nPEeDYXU3MzbGTpxLyWpoyvIE79UYBi3664NpPo8RtpJ9wwJr5Y0xUgipr
         bM0YKmV8jDG15dvWAjP98E8ho5Um6J0lhMrFTZHtADCC/cLHtmcBFMLdZLitiMbkNBzK
         pfL0xnKfvh2hOlVeErIo04oasMGjFuKEEKj5IMKMJm0jwJMZltNv6Gxjw0g0I72qHabl
         j6URxkEKiPLTHvDZE5LviPX8K9n9uXEVzmvUuSe0P74wXR/EVoOZCI/rnB1iU+pgPnuD
         w7rA==
X-Forwarded-Encrypted: i=1; AJvYcCVyftGdtc9R3I6iC7YqLWI/Dobes16QS/x7Gg0zfk4Sp0NP9GHklt3+BIXIMAyvdA24shM7Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/447vd5S0yySuAVyw/rso0XrzNF0V8KnnuD9THrhskrwYW5QM
	WQIyQ/KG7wznlr3z2isR7URAIIQ7XySXk3dxCMcmp+Od+gU8Zw5pNV/IHRCe/Y2y+/kttBtNTWb
	E74ekhOQdl+GIEXl37jtwHQOwQnfr9fg=
X-Gm-Gg: AY/fxX4tp3N+ijFYDgpwZVa9f9Y6RqmE9+x1syVhhJFb94K6Y9sdd+rrp0n3oT9+3Em
	horpNfF/Bv7/afESOjL/4BnCTscSGTbZqgaJbS8hS16SzeIyXjCoiG3UsXfZXjmDoY71o1E6MLu
	KwraNhgkJHLpEJjWBSFlwlxDzoDo4zfnSMZsawvt0ewDPs5u+B5Xla7bnDiPJy0lNDxc2jtaJmR
	xk5KTYWeXZx56ld0z9Olcxc/H2BZs4SSaPVBgrn9wbS4YOecyapTq1sPhzJ/adcgu/1jAMn
X-Google-Smtp-Source: AGHT+IFh0yCO4DCvhJF/e90OOfihjwNmvglPMYyupmK4fLMSTIYYCvDFBzxXiOXo0lY9wEjXztUxJ/qb/Fbqsvn99NM=
X-Received: by 2002:a05:690c:62c9:b0:784:883c:a88d with SMTP id
 00721157ae682-78e66e75022mr28160487b3.52.1765588249806; Fri, 12 Dec 2025
 17:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC4WQPo5HrCJ+958t1ab2NDzbg493XYarqACARTpYskVzQ@mail.gmail.com>
 <20251212231148.49843-1-sj@kernel.org>
In-Reply-To: <20251212231148.49843-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sat, 13 Dec 2025 10:10:38 +0900
X-Gm-Features: AQt7F2ozNy49he0FHbezx-HKAtCT9iN5jmwm0-PfIpuyrs8ubUzntd6g14IB0t8
Message-ID: <CAHOvCC6TXo=7svC2Ka=+rf_YLTMnaF8QUV_nNvuef20XMZ=+pA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high
 level snapshot
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Dec 2025 at 08:11, SeongJae Park <sj@kernel.org> wrote:
>
> On Fri, 12 Dec 2025 22:20:04 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Mon, 8 Dec 2025 at 15:35, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Now any DAMON API callers can report their observed access information.
> > > The DAMON core layer is just ignoring those, though.  Update the core to
> > > use the reported information at building the high level access pattern
> > > snapshot.
> >
> > It seems inefficient to repeatedly access the damon_access_reports[1000] array
> > using a for loop in the kdamond_check_reported_accesses() function.
> > It is inefficient to for loop through the entire
> > damon_access_reports[1000] array.
> > When CONFIG_HZ and jiffies are increased as follows and
> > damond sample_interval is 5000us (5ms), the time flow diagram is as follows.
> >
> > CONFIG_HZ 1000, jiffies == 1ms
> > damond sample_interval == 5000us (5ms)
> >
> > reports_len(==): [0 ... 5]
> >                                                      [*]
> >         0    1    2    3    4    5     6    7    8    9        997    998     999
> >         [====|====|====|====|====]-----|----|----|----|  ....  |------|-------|
> > jiffies++    1    2    3    4    5     0    0    0    0        0      0       0
> > damond_fn(sample interval)      -5[0<]
> >
> > reports_len(==): [997 ... 2]
> >                                   [*]
> >         0      1      2    3    4    5     6    7    8    9        997   998   999
> >         [======|======]----|----|----|-----|----|----|----|  ....  [=====|=====]
> > jiffies++   1001      1002 3    4    5     6    7    8    9        997   998   999
> > damond_fn(sample interval)
> >                             -5[997<]
>
> Please use fixed-length fonts for something like above, from next time.  I
> fixed the diagram with my best effort, as above.  But I still fail at
> understanding your point.  More clarification about what the diagram means
> would be nice.

Thank you for readjusting the font to fit.  The first diagram above is when
reports_len is processed normally starting from 0 to reports_len.
The second diagram shows the process where reports_len increases to its
maximum values of 997, 998, 999, and then returns to 0.
The biggest problem here is that the latter part of the array is not processed.

>
> >
> > It seems that only the section corresponding to the sample interval ([==|==])
> > can be cycled as follows.  And, how about enjoying damon_access_reports[1000]
> > as damon_access_reports[500]?  Even if it reduce the 1000ms to 500ms
> > array space, it seems that it can sufficiently report and process within
> > the sample interval of 5ms.
>
> Are you assuming the the reports can be made only once per 1 millisecond?  That
> is not true.  The design assumes any kernel API caller could make the report,
> so more than one report can be made within one millisecond.  Am I
> missingsomething?

jiffies 1ms is just to simply unfold the passage of time when
CONFIG_HZ is set to 1000.
This is a simplification to help it understand the flow of time.

>
> >
> >  static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
> >  {
> > -       int i;
> > +       int i = damon_access_reports_len;
> > +       unsigned int nr = 0;
> >         struct damon_access_report *report;
> >         struct damon_target *t;
> >
> > @@ -2904,16 +2905,18 @@ static unsigned int
> > kdamond_check_reported_accesses(struct damon_ctx *ctx)
> >                 return 0;
> >
> >         mutex_lock(&damon_access_reports_lock);
> > -       for (i = 0; i < damon_access_reports_len; i++) {
> > -               report = &damon_access_reports[i];
> > -               if (time_before(report->report_jiffies,
> > -                                       jiffies -
> > -                                       usecs_to_jiffies(
> > -                                               ctx->attrs.sample_interval)))
> > -                       continue;
> > +       report = &damon_access_reports[i];
> > +       while (time_after(report->report_jiffies,
> > +               jiffies - usecs_to_jiffies(ctx->attrs.sample_interval))) {
> >                 damon_for_each_target(t, ctx)
> >                         kdamond_apply_access_report(report, t, ctx);
> > +               if (++nr >= DAMON_ACCESS_REPORTS_CAP)
> > +                       break;
> > +
> > +               i = (i == 0) ? (DAMON_ACCESS_REPORTS_CAP - 1) : (i - 1);
> > +               report = &damon_access_reports[i];
> >         }
> > +
> >         mutex_unlock(&damon_access_reports_lock);
> >         /* For nr_accesses_bp, absence of access should also be reported. */
> >         return kdamond_apply_zero_access_report(ctx);
> > }
>
> So I still don't get your points before the above code diff, but I understand
> this code diff.
>
> I agree this is more efficient.  I will consider doing something like this in
> the next spin.

What I tried above is to process the current array [1000] as
efficiently as possible.
But, if I think again, It would be better to store it in a linked-list
and process it
in FIFO mode whenever requested in damon_report_page_fault(),
damon_report_access(report)
instead of storing it in an array.  I'm also analyzing the source code
starting this week,
so I'll organize it a bit more and get back to you with my opinion.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
