Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8863E6385
	for <damon@lists.linux.dev>; Wed, 20 May 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286125; cv=none; b=ARJ8GBTLPx6zPh9sAXWmoo36Uf3PinRkIfvihy/aKpDE7HDjryBJMsF2eWJGWfNANi9ezJPdf8Do+Nlh6KnqhzqatWd9xTq3AneoqSjUS9VkqK2jCVgd/0VikJgS4bzqz+BDRbW3+9EJbYvK4ISWqQlac/D/1TgSwnt3bcV/TC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286125; c=relaxed/simple;
	bh=lQurJqAbQI3hRer1x8KrYTkBL/ZV2E+R9BKIrmY2tWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ih1yXCuUUHN31RAV1CWFhdFzV1QrPamVVEqF4kz3qYxvZQxjZiD0lRFIeIbjxUvxc4AAvF0++6hohcFkLUgssUaTQ6crpxKxC6LEHCCerDCsUqUlKSjT1HdlOSFd2oqW64hzcWHhNQQ1/BeaYrOLuPeAXeAlott573VHchTTUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI+XBG6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI+XBG6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C381F000E9;
	Wed, 20 May 2026 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779286123;
	bh=yYZDPXtG2OnMivizJb8zw8yXPrUKVqw3fL+muPFo2cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KI+XBG6cJIveOCL0T4eciKNqWG6NTaUrOwj4uCSzAbWwllIsWrNKHDNVxe+V2HmqL
	 b0545mFCAO5P6n72knydnl41l/qwPHnNO1KzAy0Sd7jLKpNG6WhQWrDjN831y1ghkQ
	 6znojas4XL7DJa9j1dB8OwNnqQszDiFUK0Tu6qP6rN4Mim0a++UAt88s9z8/WiXPar
	 FnPsEOHcI+09jHRBE/E5Lv+r7mLwVaOSD8lF4N82NvXRx7wkLutY4++7Mp0zUHEDbd
	 /dEq9t79ZyC1KMm+aXD1WAK4dfbntWJtFgJu2I15doE8g3JYAwqILtj7Cru/qFuOIU
	 sXzr54bTDFT1Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 13/14] selftests/damon/sysfs.sh: test addr_unit file existence
Date: Wed, 20 May 2026 07:08:17 -0700
Message-ID: <20260520140819.169963-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520064157.4F94F1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 06:41:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added test for the `addr_unit` sysfs file incorrectly passes 'exit' instead of 'exist' to `ensure_file()`, causing the test check to be silently skipped.
> --
> 
> commit a9bc6162fe06c0405081aeb68c3f5e9a54287e20
> Author: SeongJae Park <sj@kernel.org>
> 
> selftests/damon/sysfs.sh: test addr_unit file existence
> 
> This commit adds a test to verify the existence of the addr_unit sysfs
> file in the DAMON selftests.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> > index b3418214ed358..1e10881afabb6 100755
> > --- a/tools/testing/selftests/damon/sysfs.sh
> > +++ b/tools/testing/selftests/damon/sysfs.sh
> > @@ -365,6 +365,7 @@ test_context()
> >  	ensure_dir "$context_dir" "exist"
> >  	ensure_file "$context_dir/avail_operations" "exit" 400
> >  	ensure_file "$context_dir/operations" "exist" 600
> > +	ensure_file "$context_dir/addr_unit" "exit" 600
> 
> [Severity: Medium]
> Is "exit" a typo for "exist" in this new test?
> 
> If ensure_file() expects "exist" or "not_exist" as its second argument,
> passing "exit" might cause the function to return immediately without
> performing any file existence or permission checks, which would silently
> skip the intended test coverage.

Good catch.  The ensure_file() expects "not_exist" or anything else for the
second argument, so this test is working as intended.  But definitely "exit" is
a typo.  I will fix this in the next revision.

> 
> >  	test_monitoring_attrs "$context_dir/monitoring_attrs"
> >  	test_targets "$context_dir/targets"
> >  	test_schemes "$context_dir/schemes"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520062858.167011-1-sj@kernel.org?part=13


Thanks,
SJ
