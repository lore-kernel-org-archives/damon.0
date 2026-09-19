Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29022BFC60
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781279; cv=none; b=Pdv0Sc07Dy9r3a47to86EnsxCcz6OksyLYpAMHN/oSa5gfIyAL+3gUvyaW3yy9pfwxIW5BS1hDwiNRYAolLnnEmvvXvrKm8zleM4xDh14YtpeHucHKAOkvVslkapf0yLQlQqjCyHg8mu5xRfc8guYX8t0VborDLeMOc4pRqn86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781279; c=relaxed/simple;
	bh=iLNROn9KBrzGmR9Uo5fX2p78C4fx9ARAiGyeHPJOg+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXN89Usa/MS20OV2AIgMolLu0bFXQQEnJz0HMVSQe/wUcKC4h457hpR2K/wIT4vbaCW1UTStPpGD5FSW2oGg6FtOKDtmt9MpJQ/zI7TUsIB87hM0adwFaneuBGGPfYmPcuxx95hcqa48SzkCJucqsgKkjiXWXpGsgqMJjKNpBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y573RNEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y573RNEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774AA1F000FF;
	Sat, 19 Sep 2026 01:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781277;
	bh=rkUzwboCnAEP2sWB3AZtLvCbvW8lfr8WBF1wLwQ1xBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y573RNEng5Wjj+CB9rVjHf/+FID20WTi3qNIUSY0K2nn1TXinRaakJ3J3qfqAOjqX
	 lLULXem9Gx3friWZVwMVPR4IQbR7MUFqfI7cyURehtk+QsNru8GJTkLfFsv5FNvDw+
	 xFxx9/Oi4BwKCacxnvEqfLKCNYeCTTDHHkQxSXp/qtRVW3rIyzLP9WCYwvy3CfqF0U
	 623v1RoFNLWjlFht0ngbvjbXO1+gAjuY/PBcwCWqX9ghDYXdh0+SlfFD3wTZjL8BAA
	 IjplMLSX3JiSzrQX9X3k0WiSRsH7rBmbhGfNIBQmLAEU2wOytyhnPizKImhNU4QvD9
	 aBtCWGaJmQRxQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Fri, 18 Sep 2026 18:27:47 -0700
Message-ID: <20260919012750.89211-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919012510.22CD61F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 01:25:09 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: Integer underflow in DAMOS_QUOTA_SOME_MEM_PSI_US complement calculation
> --
> 
> commit f2de2d4493473c2c847f3ad213eaef640f0e1600
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damos_quota_goal->complement
> 
> Introduce damos_quota_goal->complement for specifying whether to use a
> complemented value of the given goal target metric. Add the field to
> the data structure and implement essential core support. Handle the
> flag in the quota goal commit and current quota goal metric value
> retrieval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 2258b72da7a78..9fd08cbfacd8c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3238,6 +3239,23 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
> >  	default:
> >  		break;
> >  	}
> > +	if (!goal->complement)
> > +		return;
> > +
> > +	/* updte current_value to complemented value */
> > +
> > +	/* for user_input, users set complemented value on their own */
> > +	if (goal->metric == DAMOS_QUOTA_USER_INPUT)
> > +		return;
> > +	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US) {
> > +		goal->current_value = s->quota.reset_interval * 1000 -
> > +			goal->current_value;
> 
> [Severity: High]
> Does this unsigned subtraction underflow if goal->current_value exceeds
> s->quota.reset_interval * 1000?
> 
> If goal->current_value exceeds the nominal reset interval, which can happen on
> the first iteration when initialized to an arbitrarily large user-provided
> target_value, or on subsequent iterations if kernel scheduling delays cause the
> actual elapsed time between callbacks to exceed the nominal reset_interval,
> this subtraction will underflow and produce a massive current_value near
> ULONG_MAX.
> 
> This large value is then passed to damos_quota_score(), which computes a
> normalized score that maxes out the feedback loop, forcing the tuned quota
> limit to drop aggressively.

It's an unlikely corner case.  But I agree it would be nice to handle it.  I
will do so in the next revision.

> 
> > +		return;
> > +	}
> > +	if (goal->current_value < 10000)
> > +		goal->current_value = 10000 - goal->current_value;
> > +	else
> > +		goal->current_value = 0;
> >  }
> >  
> >  /* Return the highest score since it makes schemes least aggressive */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260919011359.88921-1-sj@kernel.org?part=1


Thanks,
SJ
