Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D32F872
	for <damon@lists.linux.dev>; Fri, 26 Dec 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766774479; cv=none; b=CxIba4rjowlyz1DlUs+8PWG69uQ43iMm+OB0+TSaLM9lIKQUyJrbqS2bWNu2qqxW2j6ifeJFnenAzy2+eby9rSA2yXZb7b3CX3mbKo8ZgpVG8I4+hapbbTI30RbfwcgqJAVmXZ4SrXJEId7VtsZ+IGPBkZ0YcOeGhR+bcRE7Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766774479; c=relaxed/simple;
	bh=mEp6J4yadIUdsHFqxS1/gcxPf7v5MNQ8+PlP8jNRAUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpSkV6GvnyMOfhqKHUtaPDFlqxZSnbZFIHuPUBG/Qi+mmp8A7bm4rZ1/PM/ONBUkC2xKQMIo4BWlIYPji4WX9y3kKTZNrC3x72lVLguhQ1qNScker6uoRfaW/E4TN3XRSDqblzWZRqsaAnpNuzeyUfDExBftbzifeWx+BrWYckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUiWm749; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUiWm749"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E943C4CEF7;
	Fri, 26 Dec 2025 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766774478;
	bh=mEp6J4yadIUdsHFqxS1/gcxPf7v5MNQ8+PlP8jNRAUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUiWm7497uoFIXzelm48+mbsYVw9oIQlO3ejG39jnW1uy6FFEP4gle7ZApnB0K/Rt
	 kek3fMRUveNxzBRP+z8/3FPYgo3s4oLZ070PItPv3/kuwa7iOGFKLplh6vlVvUx368
	 gvOJo4ZkZzKoob5LkVeOrqBiExXuI3XqK1CT3KelDZ97Yjv6D21qHqvtZwXxu/n8MN
	 E2UXshFHT3KCrEF4b5e9vvODgtodLlHrwzFabVAgK8FO8CWk83ER5bTbaxcKPhsJI/
	 gyuNOi7GsMvJ5hnMaxus7BbPDjQXTrVe7zR88titGy31wEfo9nCBcmeuAFgawbyGY1
	 Qz02b1O8YlZmA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at the damon_call()
Date: Fri, 26 Dec 2025 10:41:09 -0800
Message-ID: <20251226184111.254674-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6PQKAK5WojmVFqBw0V-TZ+11CM_2uq4z8TxsyEu3gLVQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Dec 2025 10:48:31 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Fri, 26 Dec 2025 at 04:50, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 25 Dec 2025 11:35:33 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> >
> > > On Thu, 25 Dec 2025 at 09:32, SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Hello JaeJoon,
> > > >
> > > > On Wed, 24 Dec 2025 18:43:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
[...]
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index babad37719b6..2ead0bb3c462 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -1462,6 +1462,9 @@ bool damon_is_running(struct damon_ctx *ctx)
> > >   */
> > >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> > >  {
> > > +       if (!damon_is_running(ctx))
> > > +               return -EINVAL;
> > > +
> > >         if (!control->repeat)
> > >                 init_completion(&control->completion);
> > >         control->canceled = false;
> > > @@ -1470,8 +1473,6 @@ int damon_call(struct damon_ctx *ctx, struct
> > > damon_call_control *control)
> > >         mutex_lock(&ctx->call_controls_lock);
> > >         list_add_tail(&control->list, &ctx->call_controls);
> > >         mutex_unlock(&ctx->call_controls_lock);
> > > -       if (!damon_is_running(ctx))
> > > -               return -EINVAL;
> > >         if (control->repeat)
> > >                 return 0;
> > >         wait_for_completion(&control->completion);
> >
> > Let's assume DAMON is terminated between the damon_is_running() and
> > list_add_tail().  In the case, the control->fn() will never be called back.  If
> > control->repeat is false, this function will even inifnitely wait.
> 
> As you said, there are cases where kdamond is terminated(stopped) in
> damon_is_running() and list_add_tail().  It may be a very rare case, but
> I missed this case.
> 
> >
> > I think we should keep the damon_is_running() as is, but further check if it
> > was terminated without handling the control object, and remove it from the list
> > in the case.  Like below.
[...]
> However, the damon_call_handle_inactive_ctx() function is to post-process
> the duplicate addition of control->list.  Rather, it is more efficient to
> prevent duplicate additions in advance, as follows:
> I have tested the following and it works fine.
> 
> @@ -1467,11 +1496,14 @@ int damon_call(struct damon_ctx *ctx, struct
> damon_call_control *control)
>         control->canceled = false;
>         INIT_LIST_HEAD(&control->list);
> 
> -       mutex_lock(&ctx->call_controls_lock);
> -       list_add_tail(&control->list, &ctx->call_controls);
> -       mutex_unlock(&ctx->call_controls_lock);
> -       if (!damon_is_running(ctx))
> +       if (damon_is_running(ctx)) {
> +               mutex_lock(&ctx->call_controls_lock);
> +               list_add_tail(&control->list, &ctx->call_controls);
> +               mutex_unlock(&ctx->call_controls_lock);
> +       } else {
> +               /* return damon_call_handle_inactive_ctx(ctx, control); */
>                 return -EINVAL;
> +       }
>         if (control->repeat)
>                 return 0;
>         wait_for_completion(&control->completion);

I think this is not differnt from your previous suggestion, and thus it has the
same issue.  What if DAMON is terminated between damon_is_running() and
list_add_tail() call?  Please let me know if I'm missing something.

> 
> > If you don't mind, I'll post the above diff as a patch, adding a 'Reported-by:'
> > tag for you.
> 
> 'Reported-by:' is OK.  However, please check the above again.

Thank you!


Thanks,
SJ

[...]
