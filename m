Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D570818;
	Tue, 24 Mar 2026 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325244; cv=none; b=rIL0O2eQok1TtxpPBweg3cBzuA8PtpxigcWAJVeJRHDsWAZNYAZKB8VZvAnegq4/W+3qDEG/X+wmg/A9Wd4BNqpV4AJHtk5w8y8ovPsziiFzOKAyJeyZkBpoYHoGHmspm97K7oP8WKTemh7k59ACOt2ijHHXTIYak6Ke7Nr9lYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325244; c=relaxed/simple;
	bh=WixgUXX1lfvmvG11uU5T6ehB/p6uAs83QpYTsLmE6Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qun4JuD2G9ClsKjwefGayVvELp+hXAg0IMWCHFxMVHig6iYM5ea2e372TCFoWxZAqDTMGqSPpWQSqUAbs8Jfk1VD8WhuyPNGRq6h7/Vh+9SDLgp885ixGwCQlLWxQddcsjePq+ScounpQFcLiL98tw2pM1P1aduddBcRnnOERxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMx6PC1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMx6PC1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF7EC19424;
	Tue, 24 Mar 2026 04:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774325243;
	bh=WixgUXX1lfvmvG11uU5T6ehB/p6uAs83QpYTsLmE6Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMx6PC1cHdZUo0j0Azh+oLPsTp7fGo0ySi6hOj50uqRG9LHhT79zchZf+Qg2IKRM0
	 Gi4v/h6SLV4t4Rz+bijrU9mUJMIl/PIx6ayOpGs/NGoj/0T7tNdQniCB13S0kSOCpZ
	 A+fY8o39wzb7yGFVwCnBU9BA1IXhreMxlzuoIAYa3fc+vw1vLv+3wS5p0Iv2staq9S
	 jHL/2lYFuWQ3TmJLUxJe5d6IQ5B7ZQ3Qqq8kpNhEXLT6iptq2zwbb3muwIZCz6E+TJ
	 OoB6IA7u36WFRUhZ3ZjpHG8MhSin5Iw06vDon7Yky24gS3mOgWkx0CBG/aDbWSXZYH
	 /tfwlphlxr0Hg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Mon, 23 Mar 2026 21:07:21 -0700
Message-ID: <20260324040722.57944-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324012801.42930-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 18:28:00 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260323231538.84452-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 011f7b451b6e4a657677ee09eada15a7980e8480
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_ctx->paused
> 
> This commit introduces a pause parameter to the DAMON context, allowing
> the kdamond main loop to be paused and resumed without losing its
> self-trained internal data.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..0ab2cfa848e6 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
> >  		kdamond_call(ctx, false);
> >  		if (ctx->maybe_corrupted)
> >  			break;
> > +		while (ctx->pause) {
> > +			damos_walk_cancel(ctx);
> > +			kdamond_usleep(ctx->attrs.sample_interval);
> > +			/* allow caller unset pause via damon_call() */
> > +			kdamond_call(ctx, false);
> > +			if (kdamond_need_stop(ctx) || ctx->maybe_corrupted)
> > +				goto done;
> > +		}
> 
> Since this loop is located after ops.prepare_access_checks(), kdamond_usleep(),
> and ops.check_accesses(), does this unconditionally perform a full monitoring
> cycle before honoring the paused state?
> 
> If a context is started with pause set to true, or if pause is enabled while
> waiting in kdamond_wait_activation(), it appears it will still execute one
> complete active sampling cycle. Could this cause unexpected disruption, such
> as clearing PTE accessed bits, when the context is explicitly configured to
> be paused?

Yes, DAMON would behave in the way.  And having one more sampling work doesn't
cause a real issue.

> 
> Additionally, when the context is paused, kdamond_fn remains in this sleep
> loop and skips calling damos_adjust_quota(), which means quota->charged_from
> is frozen.
> 
> If the pause lasts for more than LONG_MAX jiffies (e.g., about 24.8 days on
> a 32-bit system with HZ=1000), will system jiffies wrap past the half-range
> limit of the unsigned long type relative to the frozen timestamp?
> 
> If this wraparound occurs, time_after_eq(jiffies, quota->charged_from +
> interval) would evaluate to false when unpaused. Would this cause the quota
> window to not reset for another 24.8 days, accumulating charged_sz and
> blocking the scheme from being applied?

That's a wild corner case, but I agree it is better to avoid the problematic
case.  I'm still thinking about the good way for that.  Anyway, I will address
this in the next spin.



Thanks,
SJ

[...]
