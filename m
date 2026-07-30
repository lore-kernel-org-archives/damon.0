Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137910F1
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369898; cv=none; b=sco7rcXXookzoO1k3mHFaXuVWbHlmGE1iC4Rw3ljlT95XSata5Ze/PnJcjJU20jDhD0+fiFu1o+dTKPiYIJCP6K866cNt+irNfXDMxfMliPelIcLNmyjEMLvjybdj9KaGSWSBib3G7PGQX53YlIll31QWxP1+Nze70cEO7kGzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369898; c=relaxed/simple;
	bh=jN/etGZfMzYt7NVIWlMnqSo40uAjoyYnQQbJTpL0maI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skkS8CrF5+se3cxYsNkJ351FSSmxcfPq6T+AVn9bP4x5/sOWukQ4Zv6/W6mJAlPUXVSnEl5qkuuxMslKPw0Ljs7K626pvmuWcwNKiGQT+6tQOqSmn7jmcLls/bL4gKhWhlhKynFzkc6/+x14CssBy7A7k428AqaFbh6QgQM92sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKA1v8ee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKA1v8ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03371F000E9;
	Thu, 30 Jul 2026 00:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369897;
	bh=xWL2tnDgLUFVL5NH81kFI3kBX3qs2E7dlRvzdybDPxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKA1v8eev/NyuyC5s7iod/HxBec3Ay/wKya/9ocIfX2LTDc1Fkgh6NMMuiTBDIlt4
	 ddE4hUU+lDC+MSQqr1LAJ2ks5fgVM+RHOM2vfAbiVPnQ1vyPRG6Bbq8IsaDRou4mS1
	 mtmMYqVh1BcRiE4mKHwtdwlj/oc7xMR4bXg74zLzqDpqdtLCKjh2fGSTm8k+gb6zcY
	 wykfY1dhhGmlB+uMFQx1OMIrJA//9zAacUADDoMTyztbQelJpCk9x4WhFpRcixAKgI
	 s0PBKM3tXcPA+mHsrOBmQco1neG7UNG+h3O8XfPM5cL8rhi4fIW6uXRSxV8vCojRJT
	 tanHFMc573EzA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/6] mm/damon/tests/core-kunit: add damon_commit_probes() test
Date: Wed, 29 Jul 2026 17:04:48 -0700
Message-ID: <20260730000450.99766-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729150027.B57B61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 15:00:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing cleanup in the error path of `damon_test_commit_probes_for` causes a memory leak of dynamically allocated test structures.
> - [Medium] Missing bounds check in `damon_test_commit_probes_for` can lead to a NULL pointer dereference when a test assertion fails.
> --
> 
> --- Patch [2]: [RFC PATCH 2/6] mm/damon/tests/core-kunit: add damon_commit_probes() test ---
> commit 490c9d2d6b4090811aaa428df3f6d9ce89e2d406
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: add damon_commit_probes() test
> 
> Add kunit test to ensure damon_commit_probes() updates destination DAMON
> context with source probes as expected.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 6cbe22accabfb..6577410ace3da 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> 
> [ ... ]
> 
> > +static void damon_test_commit_probes_for(struct kunit *test,
> > +		unsigned int dst_weights[], int nr_dst_probes,
> > +		unsigned int src_weights[], int nr_src_probes)
> > +{
> > +	struct damon_ctx *dst, *src;
> > +	int err;
> > +	struct damon_probe *dst_probe, *src_probe;
> > +
> > +	dst = damon_test_help_setup_probes(dst_weights, nr_dst_probes);
> > +	if (!dst)
> > +		kunit_skip(test, "dst alloc fail");
> > +	src = damon_test_help_setup_probes(src_weights, nr_src_probes);
> > +	if (!src) {
> > +		damon_destroy_ctx(dst);
> > +		kunit_skip(test, "src alloc fail");
> > +	}
> > +
> > +	err = damon_commit_probes(dst, src);
> > +	KUNIT_EXPECT_EQ(test, err, 0);
> > +	if (err)
> > +		return;
> 
> [Severity: Medium]
> Does this error path leak the dst and src context structures?
> 
> If damon_commit_probes() returns an error, the early return here skips the
> cleanup calls to damon_destroy_ctx(dst) and damon_destroy_ctx(src) at the end
> of the function.

Good catch, I will fix.

> 
> > +	nr_dst_probes = 0;
> > +	damon_for_each_probe(dst_probe, dst)
> > +		nr_dst_probes++;
> > +	nr_src_probes = 0;
> > +	damon_for_each_probe(src_probe, src)
> > +		nr_src_probes++;
> > +	KUNIT_EXPECT_EQ(test, nr_dst_probes, nr_src_probes);
> > +	nr_dst_probes = 0;
> > +	damon_for_each_probe(dst_probe, dst) {
> > +		src_probe = damon_nth_probe(nr_dst_probes, src);
> > +		KUNIT_EXPECT_EQ(test, src_probe->weight, dst_probe->weight);
> 
> [Severity: Medium]
> Could this result in a NULL pointer dereference if the destination context ends
> up with more probes than the source context?
> 
> KUNIT_EXPECT_EQ() does not abort test execution if the previous check for
> nr_dst_probes = nr_src_probes fails. If dst has more probes, damon_nth_probe()
> will return NULL, and the next line accessing src_probe->weight will crash the
> test runner.

Good catch, I will fix.

> 
> > +		nr_dst_probes++;
> > +	}
> > +	damon_destroy_ctx(dst);
> > +	damon_destroy_ctx(src);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729144738.90895-1-sj@kernel.org?part=2
> 


Thanks,
SJ
