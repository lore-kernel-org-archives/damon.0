Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABB21D3F5
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062258; cv=none; b=Jfrq8fGOld8CCYrg7A4k5gqf67tITZYTXxMH9Vba0AiGFC1JHytV5xiDXLNB1LwoeJLhTgpA8xZJ+5c+Yn4ZXuriJEgAKv7OZw4K8rtjiDbjmaMLOs2iXfQrIFm5g187gD5teiH466kzzafyNCn+mq7WjzmO2MpH2p+qfCfOMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062258; c=relaxed/simple;
	bh=2ikq7HzMuUvC5I1ldxDnxumV5PAV2RONoV6nVe8Ebec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbw0ee52qj1NYflFlyWtEHi56CUYTxlX1U5qv5ag67mgtgXnw3AeSmP68mEelbSeiQdGrVY9QkClCxh3XVDzSemSGqZcPFlRyWz3Q+7Z+3gIzMkOR7+k3bIpc6X26dA1hkImFizHsC0v7IQhkgtf16XVWfXRB/10tBnYOCkkhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSmgIn69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSmgIn69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ED81F0089B;
	Sat,  3 Oct 2026 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062257;
	bh=yT7JWip98PCafYZDiFD2FaATI1+jLcrtPZqYtt/NSwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XSmgIn69G2LJu0hJLWGw+/fBQcqevZt7gMxjXTwCs/4EALhgC9Y105AhdJo0jTxug
	 CnbGGqUrjrq7ENTYyyJEbGBpMHJaE+PQVZ3O9VjJrhNkk0Qus0Mt8JiI97mSA7VFZi
	 7XNYULLC/tXbgzJxNhOp0o54jrGAPA4fbiOaxbqx4JyMQ6ddxjAYmZO1P5RMtcKGtD
	 a/nypkBe6OIPBwVbtBIojk9UEzEt9Eugtaw384zV5kqK98JvPAPiksmFpDKJlQSAFm
	 gPnnOIXZR8llVxM1T9JEqfske/pfSWc61+bv4qsOp3dBZMPv3Ksg6rWM9PBVKCFd/b
	 gUg4P+JuHGOJw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 7/9] mm/damon/tests/drain-kunit: kunit for report
 rings and ring drain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-7-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-7-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:17:36 +0000
Message-Id: <20261003211737.18ED81F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] mm: damon: KUnit tests leak struct pid on success path
- [Medium] mm: damon: test bsearch_unsorted_regions mistakenly creates sort=
ed list
- [Medium] mm: damon: memory leak of region r1 on allocation error path
--

commit 19081629f237047138afa26eda20068a417837a2
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: mm/damon/tests/drain-kunit: kunit for report rings and ring drain

This commit adds kunit test coverage for the per-context perf report rings
and the unified paddr/vaddr report drain path.

> diff --git a/mm/damon/tests/drain-kunit.h b/mm/damon/tests/drain-kunit.h
> new file mode 100644
> index 0000000000000..8e5023ebf6df7
> --- /dev/null
> +++ b/mm/damon/tests/drain-kunit.h

[ ... ]

> +static void damon_test_unified_vaddr_match(struct kunit *test)
> +{

[ ... ]

> +	t =3D damon_new_target();
> +	if (!t) {
> +		damon_destroy_ctx(ctx);
> +		kunit_skip(test, "target alloc failed");
> +	}
> +	t->pid =3D get_pid(task_tgid(current));

[Severity: Medium]
Does this code leak the struct pid reference? Because ops.cleanup_target
is not defined for this test context, damon_destroy_ctx() won't drop the
target's PID reference acquired by get_pid().

[ ... ]

> +static void damon_test_unified_vaddr_tgid_mismatch(struct kunit *test)
> +{

[ ... ]

> +	t =3D damon_new_target();
> +	if (!t) {
> +		damon_destroy_ctx(ctx);
> +		kunit_skip(test, "target alloc failed");
> +	}
> +	t->pid =3D get_pid(task_tgid(current));

[Severity: Medium]
Similarly, does this test also leak the struct pid reference on teardown
for the same reason?

[ ... ]

> +static void damon_test_bsearch_unsorted_regions(struct kunit *test)
> +{

[ ... ]

> +	/*
> +	 * Insert regions in REVERSE order so the list is unsorted: r2 at lower
> +	 * address first, r1 at higher address second.  DAMON normally inserts
> +	 * in sorted order; we bypass that here to exercise the bsearch path
> +	 * with unsorted input.
> +	 */
> +	r1 =3D damon_new_region(0x10000, 0x20000);
> +	r2 =3D damon_new_region(0x30000, 0x40000);
> +	if (!r1 || !r2) {
> +		damon_free_target(t);
> +		damon_destroy_ctx(ctx);
> +		kunit_skip(test, "region alloc failed");
> +	}

[Severity: Medium]
If r1 is allocated successfully but r2 fails to allocate, does this error
path leak r1? Since r1 has not been added to the target's region list
yet, damon_free_target() won't free it.

> +	/* Add in reverse (high first) to create an unsorted list. */
> +	list_add(&r2->list, &t->regions_list);
> +	list_add(&r1->list, &t->regions_list);

[Severity: Medium]
Does this sequence actually create a sorted list instead of an unsorted
one? Because list_add() prepends to the head, adding r2 (higher address)
then r1 (lower address) places r1 before r2. This results in the regions
being sorted in ascending order, which defeats the purpose of the test.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D7
