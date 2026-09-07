Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A8288C2D
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802063; cv=none; b=BbAouM5YPQ5IAAoD5+isyOO/1HU5P7gaIiXxdWbu886pWFdjSNmIdsvJyc2Ku3GdRhmwtRoSH985BTFeNI8zaynz33ijYHU8F/CeUUJBc8ZnSuglzGq1YjmFn2FnLqpcneK8BfiBvv4N0VGmWRlx3F2Ye2u6CV/94Y3HJaXb8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802063; c=relaxed/simple;
	bh=1Q+kswFFpeW0ZOxAaa3jY06CP66s/iag/Rd6bVKldt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLHU3LA1FBWEclQCDTyMZDZrnPP671g8YP9vHRKcYvy2gzYWlwDZw1eJapTWJn8+XTcnswCxSJD0hG106JInPPV5UnT3eRdrozOrt1Uye6vZf09/deWlNRsOaCtPA3GT6BE9d8h1m5AZhpL1hcjN9lybdu2zUW2RNQxLasyq3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0dD3/4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0dD3/4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A21F00A3A;
	Mon,  7 Sep 2026 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788802062;
	bh=Q6YrkXr/3FXXrH3UqW/aw/UXhavx+q5JQzDg0jcelVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0dD3/4RXFphcgJYpoB3Jts6VHZ3ZfEKz+h63W5XjCNfpPngJ1dQGhCA6F/haMao6
	 RMytYkR4Qsl/NtkTtzxQwAZiy5Zddh/jHjbXFxrOHdtr8sqNPYmUW3Hj/UkJETOM9K
	 Bs06HRxtRoshG5vgV0TYaIfNgrLRwPmxMPyUgMNd4rS4DNRMfPVDfqo/Jq+taYKhY/
	 yG3G9vmIHe2wgkKz3FYKIpYbDXDdXDFNU9nxT+S9HbH2PumHtIkXMWAq5Ouf0KWH5Q
	 6QcRseL8rcYZ77R7jtHuGIb4VNhv2gY3R8kp9YSVmJ90tg64lE3Cb6AO14AJ+x3lDE
	 hFt7oX2RAvHGQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: reset invalid quota->charge_target_from
Date: Mon,  7 Sep 2026 10:27:33 -0700
Message-ID: <20260907172735.102248-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171346.9A93F1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026 17:13:46 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The newly added fix for invalid `charge_target_from` pointers is bypassed if a scheme's quota is dynamically disabled, leaving the scheme permanently broken.
> --
> 
> commit f88287bb2670346a5987d086e0731c7ba6d0b19e
> Author: SJ Park <sj@kernel.org>
> 
>     mm/damon/core: reset invalid quota->charge_target_from
>     
>     DAMOS can suddenly stop working if a target process that quota just
>     fully charged in it is terminated.  Fix by catching and processing the
>     corner case.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ce8c6f99106ed..2c58be9edbde4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3318,6 +3334,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >  			damos_trace_esz(c, s, quota);
> >  	}
> >  
> > +	damos_reset_invalid_charge_target_from(quota, c);
> > +
> >  	if (!c->ops.get_scheme_score)
> >  		return;
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but does this bypass the newly added reset if a
> scheme's quota is dynamically disabled?
> 
> If a user hits the corner case where charge_target_from becomes invalid, and
> then dynamically disables the scheme's quota via sysfs (setting ms=0 and
> sz=0), damos_adjust_quota() will return early before the reset is reached:
> 
> mm/damon/core.c:damos_adjust_quota() {
> 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> 		return;
> 	...
> }
> 
> Because damos_skip_charged_region() does not check if the quota is enabled
> before evaluating charge_target_from, it will continue to skip all regions
> forever:
> 
> mm/damon/core.c:damos_skip_charged_region() {
> 	...
> 		if (t != quota->charge_target_from)
> 			return true;
> 	...
> }
> 
> Could the pointer reset be moved before the early return in
> damos_adjust_quota(), or could the skipping logic be updated to handle
> disabled quotas?

Good catch.  I think we should unset the charge_{target,addr}_from in
damos_commit_quota().  I will do so in the next version.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907165529.98874-1-sj@kernel.org?part=1


Thanks,
SJ
