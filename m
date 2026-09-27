Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C837E5D2
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512655; cv=none; b=B4sZXQAGbSQPYp/tOyVBESUbtQG4fBLSc379xV9VHzRsJ/D8QChGaKtoEifibzbevE/WS6lKM7jmDpXVVSuwvcZ3DOVDLmWm6wX5aUKalYZ6cOE5oa0rkYkosD3F5IA7GS0qsNJkrbv5Ta+HsEtM+yMK+9NSF+Pgov1yv9J2cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512655; c=relaxed/simple;
	bh=jFKdaJZGQWHCzT6IZ3EWwD51Gx3Ym12IdYmuQvDTHAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ji/stxlvuQf72K1m31vLeknIlyGodnMq6yRYrTt7+E40TNxzDqJ6G6/C5raDwHe3/FJpIkLFhhpkNTPmGRQKK0fkLA3BR00AroNboHwNGTssGAe+cYskth3hVCmrPKVpLkgu2iKJ6e6rM0rE8Th/pw/+JZnR+K6XeAsCGDbR1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaoCgTlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaoCgTlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF281F00898;
	Sun, 27 Sep 2026 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512654;
	bh=0EaFSdTFrfjRoxsbawqE3pHEt+4x5kCYxOQobsuhAWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MaoCgTlmytj5PvCN6+aXnunPlEcaj/taW20DpE5gnmEXYAk8RtYPS1nuU04nChEUy
	 lxF3zUTE3fjmNn3KiUDoB2kkYKWbfM7zMGKxq+ASI51KGZ+s17FzW7yNjbP/XzcALg
	 eqkfSM2wl5MKb2B5CWgKxsqb4N7qejhXH0pmg1gIUe280FWfnxBdr6Uwg3fiN/6yLh
	 7dXYrX7FNRurDWqXLVz2muJ6loWrRJ9kSsPHCflV51Lcrtqt7ANRcOldQu0Orwt9t2
	 g43XBHyXDNhsjjAwbQr0PyXg3Gv1UddYqoIqeNks6knAPV5TQnPbVmpfyxC8A/cPDv
	 RaI8zE1AdGUeg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v4 7/7] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Sun, 27 Sep 2026 05:37:30 -0700
Message-ID: <20260927123731.59099-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927121452.ED7A21F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 12:14:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] mm/damon: build failure due to typo 'complementfalse' in tests
> --
> 
> commit c13d1579fc49797d69a40d8e22286757e16cdd20
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: add complement argument to damos_new_quota_goal()
> 
> This commit extends the damos_new_quota_goal() constructor to receive and
> set a complement flag argument. It updates all API callers to use the new
> signature to prevent manual assignment mistakes.
> 
> [ ... ]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index df84d9cc7d204..20bba7421a406 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -930,6 +930,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
> >  		 * Make it kfree()-able.
> >  		 */
> >  		goal = damos_new_quota_goal(dst_goals[i].metric,
> > +				dst_goals[i].complementfalse,
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: Low]
> Does this code cause a build failure when CONFIG_DAMON_KUNIT_TEST=y is
> enabled?
> 
> The struct damos_quota_goal does not have a member named complementfalse,
> so accessing dst_goals[i].complementfalse in
> damos_test_commit_quota_goals_for() fails to compile. Should this be
> dst_goals[i].complement instead?

I will fix it in the next spin.

> 
> >  				dst_goals[i].target_value);
> >  		if (!goal)
> >  			goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260927120533.50484-1-sj@kernel.org?part=7
> 


Thanks,
SJ
