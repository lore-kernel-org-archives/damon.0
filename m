Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAD41B8CA
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190764; cv=none; b=Hyfc96uz1nCw0KOaJOD3t8VvPzjUKYLc6r0wc5r7WJbllc4s6eSvPjRzYc4ZcqVG0rwaHsQDNpmR1b9ZLxkbSFqLLPqtF0rWu0tc//XwzVHX15RN4BmQ0Xe41j7gNQmmpc2V+QAcsKhAah/92DB3w6mfxhV7i285a0tqrFbCIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190764; c=relaxed/simple;
	bh=vDUeN28V4M10nfz8VGvbUMVp0pIxlju/h8hvnuqOm6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhzQSwNXiUV8lj2SyQqNPbLaOw/2xnVa2TaEAaVwhmw/tvVcSgaKqhpXXb/7TkgBNg2O40In5F2/MrORCLvDnn7TXe2XmIzqM9/IwO2A9S4BMymv3YlpB6sYw8dSKMWA05M4usKnKthvXgRvjBs8jbL5T8ayS9oBvNh6YNFdYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwq+AwLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwq+AwLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B571F00893;
	Mon,  5 Oct 2026 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190762;
	bh=yCtZ3RpYANVKC5Zew5dY76iRjEW/aZ7Cs/rmF3ZIEMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vwq+AwLW3xbdMD68ANImDVIqxtd1LYqXKTOyNN8GQL2Li27r6pUZeOYu/InNzypa1
	 WxKdhKjl3CEbHDyj08LlhOeeWqGF9FrVNRK3J8lcVd0vfp+qb/2ra8MQMCu4HssJeX
	 pE4reyUSWRL5AKg7LSbXk2kIhZDYmpiiEIclo3bxGMRUkTUHbK6sfPqps3Yj9bQgfE
	 zod5MoNHP6bQSWS3qyfiSqV/Fqb/ad3aoixh338mEFVfQyTfCcPPH3IsXStMmtXyAY
	 xRCLQ6DChOI76Ul1YuiKqBlIyZWB2vREeRpR4hmjXlZ+WzF9EYPJ3UtK2/oSNkUidy
	 yRyk12EeocqmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 7/9] mm/damon/tests/drain-kunit: kunit for report
 rings and ring drain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-7-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-7-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:59:21 +0000
Message-Id: <20261005085922.31B571F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] mm: kunit test fails on architectures with PAGE_SIZE > 4KB
- [Medium] mm: kunit test flaky due to short staleness timeout
- [Low] mm: kunit test flaky due to hardcoded magic TGID 9999
- [Low] mm: kunit test flaky due to assertion on global state
--

commit 00b2c09e452d8dccc585f63512e7c9dee88a28fd
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

    mm/damon/tests/drain-kunit: kunit for report rings and ring drain
   =20
    Add kunit coverage for the per-context perf report rings and the drain
    that credits regions from them. Wire the suites into core.c so
    CONFIG_DAMON_KUNIT_TEST=3Dy builds them.

> diff --git a/mm/damon/tests/drain-kunit.h b/mm/damon/tests/drain-kunit.h
> new file mode 100644
> --- /dev/null
> +++ b/mm/damon/tests/drain-kunit.h

[ ... ]

> +static void damon_test_unified_vaddr_match(struct kunit *test)
> +{
> +	struct damon_ctx *ctx;
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	struct damon_access_report rep =3D {
> +		.paddr     =3D 0,
> +		.vaddr     =3D 0x1500,
> +		.probe_idx =3D 1,
> +		.size      =3D PAGE_SIZE,
> +	};
> +	unsigned long before, after;
> +	int hits;
> +
> +	ctx =3D damon_new_ctx();

[ ... ]

> +	/*
> +	 * Region must fully contain the report [vaddr, vaddr + size): a report
> +	 * straddling the region end is rejected by the drain.  With
> +	 * vaddr=3D0x1500 and size=3DPAGE_SIZE the region must reach >=3D 0x250=
0.
> +	 */
> +	r =3D damon_new_region(0x1000, 0x3000);

[Severity: Medium]
Will this test fail deterministically on architectures where PAGE_SIZE exce=
eds
4KB (such as ARM64 with 64KB pages)?

The injected report size is PAGE_SIZE starting at 0x1500. If PAGE_SIZE is
larger than 6.75KB, the report will straddle the hardcoded 8KB region bound=
ary
ending at 0x3000, causing the drain logic to reject it and fail the test.

> +	if (!r) {
> +		put_pid(t->pid);
> +		damon_free_target(t);
> +		damon_destroy_ctx(ctx);
> +		kunit_skip(test, "region alloc failed");
> +	}
> +	damon_add_region(r, t);
> +	damon_add_target(ctx, t);
> +
> +	rep.report_jiffies =3D jiffies;
> +	before =3D damon_get_samples_drained();
> +	damon_report_access(&rep);
> +	kdamond_check_reported_accesses(ctx);

[Severity: Medium]
Could this test be flaky under CPU load or preemption?

If execution is delayed by just a few ticks between capturing jiffies and
evaluating the drain:

	rep.report_jiffies =3D jiffies;
	before =3D damon_get_samples_drained();
	damon_report_access(&rep);
	<-- execution delayed by preemption here
	kdamond_check_reported_accesses(ctx);

Couldn't the drain logic in __kdamond_drain_ring() drop the report as stale
since the default sample_interval is 5ms?

[ ... ]

> +static void damon_test_unified_vaddr_tgid_mismatch(struct kunit *test)
> +{
> +	struct damon_ctx *ctx;
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	struct damon_access_report rep =3D {
> +		.paddr     =3D 0,
> +		.vaddr     =3D 0x1500,
> +		.tgid      =3D 9999,	/* matches no target */
> +		.probe_idx =3D 1,
> +		.size      =3D PAGE_SIZE,
> +	};

[Severity: Low]
Could this intermittently fail if the test runner thread happens to be
assigned PID 9999 by the OS?

If that occurs, the TGIDs would match, erroneously crediting the report
and causing the test assertion to fail.

[ ... ]

> +static void damon_test_report_return_value(struct kunit *test)
> +{
> +	struct damon_ctx *ctx;
> +	struct damon_access_report rep =3D {
> +		.paddr =3D 0x15000, .probe_idx =3D 1, .size =3D PAGE_SIZE,
> +	};
> +	unsigned long full_before, busy_before;
> +	unsigned int queued =3D 0, dropped =3D 0;
> +	int i;
> +
> +	ctx =3D damon_new_ctx();

[ ... ]

> +	busy_before =3D damon_get_report_busy_drop();
> +
> +	/* One past capacity, so the last iteration must be a drop. */
> +	for (i =3D 0; i < DAMON_REPORT_RING_SIZE; i++) {
> +		if (damon_report_access(&rep))
> +			queued++;
> +		else
> +			dropped++;
> +	}
> +	preempt_enable();
> +
> +	KUNIT_EXPECT_EQ(test, queued, (unsigned int)DAMON_REPORT_RING_SIZE - 1);
> +	KUNIT_EXPECT_EQ(test, dropped, 1u);
> +	/* No NMI nests here, so the drop must be the full ring. */
> +	KUNIT_EXPECT_GT(test, damon_get_report_ring_full(), full_before);
> +	KUNIT_EXPECT_EQ(test, damon_get_report_busy_drop(), busy_before);

[Severity: Low]
Is it safe to assert that this global counter remains completely unchanged
during the test's execution?

Since damon_get_report_busy_drop() aggregates the damon_report_busy_drop_pe=
rf
counter across all CPUs, wouldn't concurrent perf NMI activity in other DAM=
ON
contexts on different CPUs increment this counter and cause the test assert=
ion
to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D7
