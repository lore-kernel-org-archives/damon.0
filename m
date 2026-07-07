Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930437F73E
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400852; cv=none; b=LIfLszpv+bBEo4u8Uu3rkQXHzviB4x2VorWyzLuclJ5T3kz8SKfJvpj7Eu+Th3zjm4MJVAa+5ZYpte4YLbwF+H4F94rIcPbH1xeqIO0UsQBwkzhXGRZhGpqtAfano6mGTvlxQ34xEqn/daVv/RZ0q8+IBdeRvImKGz4l76sPSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400852; c=relaxed/simple;
	bh=74emh/AZAadkw+t4z7B9OyUEI0cbSUvHxoXaYCSCBeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wl2MTvUZ1zQEV67qZZ8xEKlb4Z8dURjGhm/cKBQ9ZNDMSiIJZWm87ltJFhyvY8/8A1XCxN4ys4J2CFHlyB97H/zEVK2w7+wxtavtFmTYPTyqvJu0/IsCWXITGvT2PPcvQK9Kvtx9hWVD1JgPuTy2KykQuSXIL57LDfou3N4/vlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLj+njkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLj+njkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9021F000E9;
	Tue,  7 Jul 2026 05:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783400849;
	bh=69lwPdy1TbxUTK2Pxgr6EnO6y+Q4bdn22KHpGD+vmjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLj+njkxJcNgpEt8/v5uRO56Hg0KAmU0ofYyOoxWjLlVsYJ80TO1QMVi4Y1jnjBiE
	 7Y75iXADt5xqMzmlW5GTa5X5LALez/Jgmo/cPSSOqsKKIC0c9cT6e6p7Zj7GLuf1eR
	 BXK9eFSYA8AxwEUaghdxjXJSjBTpGvUDz5siOctuUeolGeK4X/smkoGmvvMoyG1IKj
	 7MRREA5z9rYGZA/WXvfeoDVcnpKFDvkjWmNUA6A3GdhfC1dlu8frZjaqTSelGwo84Z
	 HQYtqLBDdkoJH8TPZ4UbikdOtyQsv2OBY3wPj9zsT2ny3K74RxMkBUvFw9YbDix2Rp
	 duBg0xXZtaYAg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/6] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Mon,  6 Jul 2026 22:07:22 -0700
Message-ID: <20260707050725.102441-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707044544.42E3D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 04:45:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Obsolete divide-by-zero comment and skip logic were not removed in the KUnit test, contradicting the commit message and core code.
> --
> 
> --- Patch [3]: [RFC PATCH 3/6] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/ ---
> commit aaafc980a7ea0e3c63783a3dbd0d43aab65ff523
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
> 
> This commit renames damon_nr_accesses_to_accesses_bp() to
> damon_sample_count_to_bp() to better describe its functionality. It also
> mentions removing obsolete comments regarding a division-by-zero bug that
> was previously fixed.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 0124f83b39b83..86eae3a590354 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
> > @@ -585,7 +585,7 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> >  	/*
> >  	 * In some cases such as 32bit architectures where UINT_MAX is
> >  	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
> > -	 * damon_nr_accesses_to_accesses_bp() in the case will cause
> > +	 * damon_sample_count_to_bp() in the case will cause
> >  	 * divide-by-zero.  Such case is prohibited in normal execution since
> >  	 * the caution is documented on the comment for the function, and
> >  	 * damon_update_monitoring_results() does the check.  Skip the test in
> > @@ -594,7 +594,7 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> >  	if (!attrs.aggr_interval)
> >  		kunit_skip(test, "aggr_interval is zero.");
> 
> [Severity: Medium]
> The commit message mentions that the obsolete comment about division-by-zero
> is removed because damon_nr_samples_per_aggr() now always returns non-zero.
> 
> Should this comment and the associated kunit_skip logic also be removed
> from damon_test_sample_count_to_bp()? 
> 
> It appears to still reference the caution comment that was removed from the
> core code, and it continues to guard against a divide-by-zero that can no
> longer happen.

Good finding.  I will do so in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707043828.97900-1-sj@kernel.org?part=3


Thanks,
SJ

[...]
