Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D22931D3
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781929; cv=none; b=g6maQDCoK2dyraVvrbq9xJy91z4EwJkQUqKExr+QjrcOM3YFtPZg0SRa65obszGVlnOo3eES/cIrFWzzqqfbfLwaxrTgxFOpWALmxxCopXHVlNg1sXYUoKDV9dy2Uj7KDsURzwFO55C7woWan6IlAKaJLI7vEfVrJLARzjcsE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781929; c=relaxed/simple;
	bh=3DpiRHmG5YeAkgNQXKDs/+YbsgPmtBzn+CxKzMO1N0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhNe81S3N1RufTSQc2lZZk6KEpSUqz7moU45aWpGSLDxHvmfXHix4Q07yfb4ikJ1hIuPEeZSNWLOf3N0yFlR60oUrCx6J9eBK8Rgl8MhfV/3E+qJgVewr4yXYuzZ7xlx7iJqxgW9Ur1/BPt7w55Bqn6GqYn1E4eIRTIhXYm/PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIoRM/S+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIoRM/S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEE71F000FF;
	Sat, 19 Sep 2026 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789781927;
	bh=QZ6OupXNyt902coKsKYx7U9Y2IRRFBcethda+ikm0Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIoRM/S+Ls1CftlhYHBOvOu7KPSKtexKxyvsSupT9TtOGnvkWdS7OOKWyhvxS3iXR
	 V10t2fcjAHXdm8fVaDbLHzZcdQkEotsoskysNpNX5AKtYghweBOce/etEt2XvBeCql
	 cAwP7Z8Rdke+X88tjO9g6xAj8hWUu15fl/EYGnRid7Nqzbp7fJwlLSrhfVrz97Mhxy
	 jZPGGwUap3dKW9nQefDZ1fBhoqUkkzXsd+xYkdYIRZSAdVKaijFIoqn+b1YQAP8Ybh
	 CuA+q4WlQrmnFsv/oxhHi+O6gh8v+mbQGRXunzkchaKMECNaGPi0E9BCblQplGRi8y
	 bTn3zj/DsX1pw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 7/7] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Fri, 18 Sep 2026 18:38:39 -0700
Message-ID: <20260919013840.89998-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919012322.2F2241F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 01:23:21 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: integer underflow in damos_set_quota_goal_current_value()
> --
> 
> commit f2de2d4493473c2c847f3ad213eaef640f0e1600
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damos_quota_goal->complement
> 
> Introduce damos_quota_goal->complement for specifying whether to use a
> complemented value of the given goal target metric. Add the field to
> the data structure and implement essential core support.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 2258b72da7a78..9fd08cbfacd8c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
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
> > +	if (goal->metric = DAMOS_QUOTA_USER_INPUT)
> > +		return;
> > +	if (goal->metric = DAMOS_QUOTA_SOME_MEM_PSI_US) {
> > +		goal->current_value = s->quota.reset_interval * 1000 -
> > +			goal->current_value;
> 
> [Severity: High]
> Does this unprotected subtraction in damos_set_quota_goal_current_value() risk
> an integer underflow?
> 
> If a user configures DAMOS_QUOTA_SOME_MEM_PSI_US with complement enabled via
> sysfs and sets a target_value greater than reset_interval * 1000, the initial
> round (where current_value = target_value) will immediately underflow.
> 
> Furthermore, if the kdamond thread is delayed by the scheduler beyond the reset
> interval, the measured PSI time can naturally exceed reset_interval * 1000,
> which would also trigger the underflow.
> 
> This underflow would result in a huge current_value (near ULONG_MAX), which is
> then fed into damos_quota_score(), producing an astronomically high tuning
> score that aggressively drops the effective quota to zero, breaking the quota
> regulation mechanism.

I will fix this in the next spin.

> 
> > +		return;
> > +	}
> > +	if (goal->current_value < 10000)
> > +		goal->current_value = 10000 - goal->current_value;
> > +	else
> > +		goal->current_value = 0;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260919011359.88921-1-sj@kernel.org?part=7
> 


Thanks,
SJ
