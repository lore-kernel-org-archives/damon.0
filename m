Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B0367F3A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321849; cv=none; b=hvvMonNpZtAmPO3lNZ+igMR3xjX0BloKppKBLlgNZjBrCuuDYb0T5b/wH6nnTPb7UGSjIQTHXLNuMWfLG9tXmlZqODlGh8EtLvXAM3xkGBmKZYZIgSnTRrZuqSMq06snJi9akG7NzVeUg2dEv57N/lr4/tIGn2pzBwuFGeVRYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321849; c=relaxed/simple;
	bh=q69tMkLAO/SE9iLR5/XErQS/cuRoV7P9YNNIQ3k8wQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m894pBhgerkPUQna5CkGGzeP1FIYFdK6ERyyd4KTHcKrBC2Zn+AU0dL235YvaZM0wV5PjFShZFm/GauDMehsSBmUQAfK58jrcQ86Tz8TOwxbR+z0IgLa/ZHdDc1298QGPN7+2vbqmxAk/l+kH6bdcrATZLLdz3uKhf5ijJsl3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdcOG1wT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdcOG1wT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1B31F000FF;
	Sun, 13 Sep 2026 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789321847;
	bh=gxJ8yyQApclcjvFMCSHoc225jxfm7ulxlgtPbgKvXGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdcOG1wTjgRUv5/v1OEP1cxsN44Sca+TTj7cR4rUywkUExd56LiYjWyiHPA1qFz2O
	 RzzGa8LkXe+WnuunXHgtOlyoNIBMDf18f7LvcukWruVeHuN86qbPMe/Z8oIVfwR9TT
	 PbnuukBKpWsLiH50UhAFz/S3N1Pz4xkIT/2tXdZcgkHmtBsOVPst6EXBBNogTx9LcF
	 NhBtc8RfUCpLqLAEc3F48CUS7wQfqlBYUi+eMWnqrT3h0PjzY+R1r6E1S8rH2tLBdI
	 BeSatIv+DikSiKafs3gGR2F1p+FTE73AXU1f16c4+RKNWrspdeeP9hOIKWWjuJvcju
	 dLXenUGFtl76w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Sun, 13 Sep 2026 10:50:39 -0700
Message-ID: <20260913175040.106178-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913172801.C0B131F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 17:28:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete implementation: missing test coverage for DAMOS_FILTER_TYPE_PROBE_HITS_WSUM invalid commits.
> --
> 
> commit d95c459dddaa5a1cc3be54d53b10942b9bd9ba9f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: test invalid damos filter commits
> 
> This commit adds KUnit test cases to verify the validation of damos filter
> arguments at commit time.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 2b0931cf6fb32..527abc2570616 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit *test)
> >  			.allow = false,
> >  			.sz_range = {.min = 234, .max = 345},
> >  			}, false);
> > +	damos_test_commit_filter_for(test, &dst,
> > +			&(struct damos_filter){
> > +			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> > +			.matching = false,
> > +			.allow = false,
> > +			.sz_range = {.min = 456, .max = 123},
> > +			}, true);
> >  	damos_test_commit_filter_for(test, &dst,
> >  			&(struct damos_filter){
> >  			.type = DAMOS_FILTER_TYPE_UNMAPPED,
> > @@ -1197,6 +1204,13 @@ static void damos_test_commit_filter(struct kunit *test)
> >  			.allow = false,
> >  			.addr_range = {.start = 456, .end = 567},
> >  			}, false);
> > +	damos_test_commit_filter_for(test, &dst,
> > +			&(struct damos_filter){
> > +			.type = DAMOS_FILTER_TYPE_ADDR,
> > +			.matching = false,
> > +			.allow = false,
> > +			.addr_range = {.start = 567, .end = 456},
> > +			}, true);
> 
> [Severity: Medium]
> Is a test case for DAMOS_FILTER_TYPE_PROBE_HITS_WSUM missing here?
> 
> Previous changes introduced range validation (max < min) for ADDR,
> HUGEPAGE_SIZE, and PROBE_HITS_WSUM. While ADDR and HUGEPAGE_SIZE are being
> tested for invalid commits, PROBE_HITS_WSUM seems to be omitted.
> 
> Additionally, if a test for PROBE_HITS_WSUM is added, does
> damos_test_commit_filter_for() also need an update? The switch statement
> verifying copied filter fields lacks a case for it and would fall through to
> default, failing to verify the range arguments:
> 
> damos_test_commit_filter_for() {
> 	...
> 	switch (src->type) {
> 	case DAMOS_FILTER_TYPE_MEMCG:
> 		...
> 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
> 		...
> 	default:
> 		break;
> 	}
> }

I will add that as a followup in future.

> 
> >  	damos_test_commit_filter_for(test, &dst,
> >  			&(struct damos_filter){
> >  			.type = DAMOS_FILTER_TYPE_TARGET,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913171706.103052-1-sj@kernel.org?part=8
> 


Thanks,
SJ
