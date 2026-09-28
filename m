Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BA494828
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588867; cv=none; b=tDjHcR/NoZcz54/FSjC6G87+d74V+o9DJ7VepRlFtzsXoK/PSNanZATaRdhnzydFBp92fHPPKyRY2S9o7QjihzaQP0mU7IgRi/XaG7LmQqypo/FzW+ngH3ZDjsX80sL1LQ4mKZwhCDt+vChrBSjQzjlj6uS71pux6gPlwMH1Azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588867; c=relaxed/simple;
	bh=qToRVtAYKWHGCKfWqmKx/DLn/aQFENux28RHx25z3Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNh1rA+W7ggbyC0ghuWdS5Z+hsuuS+alvQOUGAGy+6tL0r1HElg7D6WQle9i+y0AqvOf66q3vzhNkBdb4VegqenxBfAnM9MkMe6si4SHSRFI5FYyjJgL/1ToLkfsgHDUxBp1Ht5w73Zf6AD8ogRYpZMTokDmu7kQqBlSS4BF/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXlIhG5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXlIhG5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C67D1F000FF;
	Mon, 28 Sep 2026 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588861;
	bh=0EK5FaMoGH0yMxl5h26XZPGixXV0nheM98/5nsH/Llw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXlIhG5Moh8t6mkMKACByvkaJtxdwaQmkxmISxDg+rLTSaIfyxius6W/4TVnwf4vT
	 xodeTR4oJKSt91MaHvgMOaZr4dkp8/t0B0CQU9ffGfqzLuF2vJV03Wphfnnt2A2dIS
	 MZGQ4YQ34rHb5fbFHfwQTrl08gjXB8xcPwk/dADj96mH1OEIKGnFpQntLKSgz2+kSU
	 Yq5Vie7bKSWCQ+MLGxO0ugUAX3q18bsdkRQ2qlqQeAhfoK0mUMgA2MQCb17TagCzGK
	 X/kVWP2dlq5J5aWUy+hNSWs1hQcXfhxVCoij8554zU5o3/1wMTFei9W0jgmKjbPWYO
	 4uoSDOUQWeiTw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v5 1/8] mm/damon/core: introduce damos_quota_goal->complement
Date: Mon, 28 Sep 2026 02:47:35 -0700
Message-ID: <20260928094737.17117-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928094441.108CE1F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 09:44:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] mm/damon: integer overflow in damos_set_psi_current_val on 32-bit systems
> --
> 
> commit 2c98b9664c0f8cdd559874386842cae96a9ea8cb
> Author: SJ Park <sj@kernel.org>
> mm/damon/core: introduce damos_quota_goal->complement
> 
> This commit introduces the complement flag to damos_quota_goal, allowing the
> system to use the complemented value of a target metric. It adds the field
> to the data structure and implements support for it during quota goal commits
> and metric value retrievals.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 733025b367457..270ce9c85a2ce 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi_total,
> >  		struct damos_quota_goal *goal, struct damos *s)
> >  {
> >  	u64 last_psi_total = goal->last_psi_total;
> > +	unsigned long val;
> >  
> >  	goal->last_psi_total = now_psi_total;
> >  	if (last_psi_total != U64_MAX) {
> > -		goal->current_value = now_psi_total - last_psi_total;
> > +		val = now_psi_total - last_psi_total;
> > +		if (goal->complement) {
> > +			if (val < s->quota.reset_interval * 1000)
> > +				val = s->quota.reset_interval * 1000 - val;
> 
> [Severity: Low]
> Does this multiplication risk an integer overflow on 32-bit systems?
> 
> On 32-bit systems, unsigned long is 32 bits, with a maximum value of ~4.29
> billion. If a user configures reset_interval via sysfs to a value larger
> than 4,294,967 (about 71.5 minutes), the multiplication
> s->quota.reset_interval * 1000 will overflow unsigned long.
> 
> This causes the auto-tuning goal complement metric to evaluate with a
> truncated, incorrect value. While 32-bit systems running DAMON with 71+ 
> minute intervals are extremely rare, could this cause unexpected behavior
> when long intervals are configured?

Yes, that's extremely rare.  Also sane users would use the new feature after
testing.  Not a blocker of this series in my opinion.

> 
> > +			else
> > +				val = 0;
> > +		}
> > +		goal->current_value = val;
> >  		return;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260928093342.16584-1-sj@kernel.org?part=1
> 


Thanks,
SJ
