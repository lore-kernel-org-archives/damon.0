Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F252D373F;
	Fri, 12 Dec 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765581112; cv=none; b=EyADIQLBdki/ch9/941tLnGR33KSWJrTE1b36aixzgXETEG4ykOGkjBI8Pi3iMoZeyBYIfE90tIhmSHP7oLBQsTmhkdt61LvTnp81bcNN8IAdQJxtM1/I4JrQdE/RN4XoGjMhLqLcm24t8xh4YSVknMn72m4pjtXdI+XARx717I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765581112; c=relaxed/simple;
	bh=P3uU7ajhp4vqPPW35PSbg+rdWdrGLIQGgY65lb1tkc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MraC6Gw8p2ao3THCl54RtMu8k4vq/vsZRRac2FBeb/KDufxQPm8/SvIzbVqSUMvXEEJKDKRhf30jtz974G1dX7P+sdgRSRgECHejneDkZ604MOR74RCA2Rsc5ZXhecg9CkRmd9tFCPXxcRtuykJT60SP5p+G+c51z6ON/uHR5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4Or2xyS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4Or2xyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F09C4CEF1;
	Fri, 12 Dec 2025 23:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765581111;
	bh=P3uU7ajhp4vqPPW35PSbg+rdWdrGLIQGgY65lb1tkc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4Or2xySrQs91xkZYelAnLmWEzQ0ifu8RgboOCiScqQ2E8FpRgF5huJa9ljamuu5Q
	 vDbk/hCr2S+yMhWL/1onf+bZoRA+AaIAqZDjcpvEzx4JQbLADKJx8UfZscGmdqv1XH
	 RyGrc8b4w9zRl/vDEXBHfp8V0hkvBQaxjRvP3OuBJMFfGJsjtKxx8sAI+zU5oLGNgv
	 zgK/hlW+8TGLHJ/pvv6Dl0UOHTiqFfVf6MFH86iDKmbPXF/EMvquCbEY+rsDumCUu4
	 R+6XabQ/RRf0UIPX6HhajYlGOGsG26HQrwVSby2MbGrXhMOp3v4f6kStYYG70VouC6
	 0xugyYaCkp5Ew==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high level snapshot
Date: Fri, 12 Dec 2025 15:11:47 -0800
Message-ID: <20251212231148.49843-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC4WQPo5HrCJ+958t1ab2NDzbg493XYarqACARTpYskVzQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Dec 2025 22:20:04 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Mon, 8 Dec 2025 at 15:35, SeongJae Park <sj@kernel.org> wrote:
> >
> > Now any DAMON API callers can report their observed access information.
> > The DAMON core layer is just ignoring those, though.  Update the core to
> > use the reported information at building the high level access pattern
> > snapshot.
> 
> It seems inefficient to repeatedly access the damon_access_reports[1000] array
> using a for loop in the kdamond_check_reported_accesses() function.
> It is inefficient to for loop through the entire
> damon_access_reports[1000] array.
> When CONFIG_HZ and jiffies are increased as follows and
> damond sample_interval is 5000us (5ms), the time flow diagram is as follows.
> 
> CONFIG_HZ 1000, jiffies == 1ms
> damond sample_interval == 5000us (5ms)
> 
> reports_len(==): [0 ... 5]
>                                                      [*]
>         0    1    2    3    4    5     6    7    8    9        997    998     999
>         [====|====|====|====|====]-----|----|----|----|  ....  |------|-------|
> jiffies++    1    2    3    4    5     0    0    0    0        0      0       0
> damond_fn(sample interval)      -5[0<]
> 
> reports_len(==): [997 ... 2]
>                                   [*]
>         0      1      2    3    4    5     6    7    8    9        997   998   999
>         [======|======]----|----|----|-----|----|----|----|  ....  [=====|=====]
> jiffies++   1001      1002 3    4    5     6    7    8    9        997   998   999
> damond_fn(sample interval)
>                             -5[997<]

Please use fixed-length fonts for something like above, from next time.  I
fixed the diagram with my best effort, as above.  But I still fail at
understanding your point.  More clarification about what the diagram means
would be nice.

> 
> It seems that only the section corresponding to the sample interval ([==|==])
> can be cycled as follows.  And, how about enjoying damon_access_reports[1000]
> as damon_access_reports[500]?  Even if it reduce the 1000ms to 500ms
> array space, it seems that it can sufficiently report and process within
> the sample interval of 5ms.

Are you assuming the the reports can be made only once per 1 millisecond?  That
is not true.  The design assumes any kernel API caller could make the report,
so more than one report can be made within one millisecond.  Am I
missingsomething?

> 
>  static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
>  {
> -       int i;
> +       int i = damon_access_reports_len;
> +       unsigned int nr = 0;
>         struct damon_access_report *report;
>         struct damon_target *t;
> 
> @@ -2904,16 +2905,18 @@ static unsigned int
> kdamond_check_reported_accesses(struct damon_ctx *ctx)
>                 return 0;
> 
>         mutex_lock(&damon_access_reports_lock);
> -       for (i = 0; i < damon_access_reports_len; i++) {
> -               report = &damon_access_reports[i];
> -               if (time_before(report->report_jiffies,
> -                                       jiffies -
> -                                       usecs_to_jiffies(
> -                                               ctx->attrs.sample_interval)))
> -                       continue;
> +       report = &damon_access_reports[i];
> +       while (time_after(report->report_jiffies,
> +               jiffies - usecs_to_jiffies(ctx->attrs.sample_interval))) {
>                 damon_for_each_target(t, ctx)
>                         kdamond_apply_access_report(report, t, ctx);
> +               if (++nr >= DAMON_ACCESS_REPORTS_CAP)
> +                       break;
> +
> +               i = (i == 0) ? (DAMON_ACCESS_REPORTS_CAP - 1) : (i - 1);
> +               report = &damon_access_reports[i];
>         }
> +
>         mutex_unlock(&damon_access_reports_lock);
>         /* For nr_accesses_bp, absence of access should also be reported. */
>         return kdamond_apply_zero_access_report(ctx);
> }

So I still don't get your points before the above code diff, but I understand
this code diff.

I agree this is more efficient.  I will consider doing something like this in
the next spin.


Thanks,
SJ

[...]
