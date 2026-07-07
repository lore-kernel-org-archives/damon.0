Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289841DEDE
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433983; cv=none; b=LvSrPCu4FMN4QltWa4CnctQwgDeJcrNPvMB2Tp+oBHXTWW2xKU4SauBC4xwzIRV5chE9bxsnULqqYFd2Z7dwFF/hmRN+lIXDJvUlUlYlooIZ93Em9F/TzsAeSU5SkXoXmAvW0NLTOhYUmAebStdzDdgzTCZ75AJrAqVzszajkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433983; c=relaxed/simple;
	bh=OPhH2GJY86tekV55dHmIlQWscWxUlo15qGY9+H7FpOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY18ugGEXqq47egO4eMUUsRYW0b7nfp4JJ720WeKGwcHsx/wJoSXsogq/wrgHfnQ8zmLr3jVT9j3g+rEBV1MTELM60EZQ66MF3VelpbihKnOrIH8LTgtfhWsAvxj4CabASgrxMj1WKDqFaTpAgpwEKrRdV+KPirgxV0uM10R608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXVmpG1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXVmpG1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D23B1F000E9;
	Tue,  7 Jul 2026 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433982;
	bh=MHVgKFlSQEVf9TOOtkswPTugznq3OzUsEknSbxf9GS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXVmpG1nMGhEfs+41VCRwSlc1IuMijeuK0hiwGZZvP2TZk1sKznrUbLXSoeGDcRzU
	 LGyT//5wK5JSnprkgj1wFQu2xzlr7KV4OzvBvSDF+Cb83Q9Jr0aSmxPhshZfTrEarm
	 3wFnAn1wfTi7hsJlYRfuMgAYOINR6ksQ8xwvQ9eeu/h5IQokwzNdA8CkLJTlzuaXKm
	 oOBIs/Gl7j3NNM0uMinTcDAM3VMvTaWeTSjA5cVXhahRgnzDCh7vZxBFf180RXBpKe
	 Gfg8VcX3O80MYuCuH+Gg4lwG0t+jMGtBGnD4AbMH9vLH2q+QI/larZvNqq8V4zjNwf
	 ekksEOxmdg6TA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/7] mm/damon/core: remove obsolete comment for nr_to_bp() divide-by-zero
Date: Tue,  7 Jul 2026 07:19:32 -0700
Message-ID: <20260707141934.91301-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135750.DD21B1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 13:57:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing the `!attrs.aggr_interval` skip guard causes `damon_test_nr_accesses_to_accesses_bp` to fail deterministically on 32-bit architectures.
> --
> 
> --- Patch [1]: [RFC PATCH v1.1 1/7] mm/damon/core: remove obsolete comment for nr_to_bp() divide-by-zero ---
> commit a31fcddef9e05dc323b42f64143ffe58dc702dee
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove obsolete comment for nr_to_bp() divide-by-zero
> 
> This commit removes obsolete comments about division-by-zero in
> damon_nr_accesses_to_accesses_bp() and its related test code. A previous
> commit modified the underlying calculation to always return a non-zero value,
> preventing the division-by-zero issue.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 0124f83b39b83..224a3ecaa0701 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
> > @@ -582,18 +582,6 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> >  		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
> >  	};
> >  
> > -	/*
> > -	 * In some cases such as 32bit architectures where UINT_MAX is
> > -	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
> > -	 * damon_nr_accesses_to_accesses_bp() in the case will cause
> > -	 * divide-by-zero.  Such case is prohibited in normal execution since
> > -	 * the caution is documented on the comment for the function, and
> > -	 * damon_update_monitoring_results() does the check.  Skip the test in
> > -	 * the case.
> > -	 */
> > -	if (!attrs.aggr_interval)
> > -		kunit_skip(test, "aggr_interval is zero.");
> > -
> >  	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
> 
> [Severity: Medium]
> Will removing this skip guard cause a deterministic test failure on 32-bit
> architectures?
> 
> When the test runs on a 32-bit architecture, attrs.aggr_interval is initialized
> to ((unsigned long)UINT_MAX + 1) * 10, which overflows to 0. With the division
> by zero fix in place, damon_max_nr_accesses(&attrs) will return 1 instead of 0.
> 
> This causes damon_nr_accesses_to_accesses_bp(123, &attrs) to evaluate to
> (123 * 10000) / 1 = 1230000. Since the test unconditionally expects the result
> to be 0, the KUNIT_EXPECT_EQ assertion will fail.

Good point.  Actually, this test was only for division by zero, and now it
seems it is just broken.  Maybe a better way is testing if
damon_max_nr_accesses() returns zero or not in the extreme cases.

I will simply drop the entire test from the next revision.

> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707135038.90068-1-sj@kernel.org?part=1

Thanks,
SJ
