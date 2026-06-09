Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8A3A9D9D
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988311; cv=none; b=bh5ugIdWcVlaq5TTAGopI1h/p13g8GtkuZ4dLY/xY4ctU9mja+74b90ZpGLQ9F2E2NGl9M3y4TeFmV6s32iEy0QMszpiNGugIoVvH+lwCZ/1LeAA8qrlOxHIEABRREEOSe7zNahfWpAadYUnwKRpW3co0VqZGDUDcN5zRfHl5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988311; c=relaxed/simple;
	bh=GhpRlXu8+Mr2qL+p0EJlqWPTQFdwZqqLOtF9PXpeeVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CGkM8aWcMcuwDdGIc/+M5KHgUIUGaMtmDcQF1FP0EtwRlrjDHUKHIAUmRmO4C3kUAw4KonK8WeGgN9kzkshEquK9nvMYult0gUoswEKm8mvY/Q6nUIkDLk/RrNQb/+otrum2b6VXIsq2aAeB/4aj6nkUU4l27Iqc5q5mkI3i1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQgjUjvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQgjUjvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBAC1F00893;
	Tue,  9 Jun 2026 06:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780988309;
	bh=TfLSxjgztfJSfHYB94UGmAyiNTdsCHnWhvWsWt+xqyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQgjUjvSfi0Bm4Tq3dEAVeaG1wZYX7ORcoJpflBGBlUHjFjmqy7Po1U+0/ci8hiYB
	 0DckPJvW3MX9E1ANy79LB3dYm7Dfi8yWaK2DMDubTDFdH0pYwhS1gfT5Sj5Ujl1b5Y
	 NZNDoe0088pmZmlYbuu7tT8Rf+ayL5cERLHB9yduK354YmLwB5wJST5skSi7kycfcO
	 nMBAHyNMYoxT9G2LaWxdGx9fj+7uzj4Fkl8ELEqx6SEqLE+TP+x93fP41rzMu2cwGr
	 ruezRw7TU4UhaVmoyiFdY0q+VrH2rgZ+rCJV7r0iIgbVxY+XQw8bz6C/++/R5vxxqi
	 bZ5mF4lrqmI+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] samples/damon/mtier: fail early if address range
 parameters are invalid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <yuzenghui@huawei.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260609064653.1829-1-yuzenghui@huawei.com>
References: <20260609064653.1829-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:58:28 +0000
Message-Id: <20260609065829.6CBAC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `damon_ctx` structures and potential orphaned `kdam=
ond` threads when `damon_start()` fails.
- [High] Incomplete fix allowing integer overflow and resulting in `WARN_ON=
CE()` and massive region size.
--

commit 567b4e8a4b1811419a6203e400b62d93a47bfe84
Author: Zenghui Yu <yuzenghui@huawei.com>

samples/damon/mtier: fail early if address range parameters are invalid

This commit adds an early check in damon_sample_mtier_build_ctx() to ensure
the address range parameters are valid. This is intended to prevent a
WARN_ONCE() that occurs when the node address bounds are not properly
initialized before the module is enabled.

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index eb1143de8df17..3785b0c7ffb17 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  		addr.end =3D promote ? node1_end_addr : node0_end_addr;
>  	}
> =20
> +	if (addr.start >=3D addr.end)
> +		goto free_out;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this incomplete fix sti=
ll
allow an integer overflow?

If addr.end is set to ULONG_MAX via sysfs and addr.start is a valid address,
this check passes. Later, damon_set_regions() calls ALIGN():

mm/damon/core.c:damon_set_regions() {
    ...
    ranges[i].end =3D ALIGN(ranges[i].end, min_region_sz);
    ...
}

The ALIGN macro will add min_region_sz - 1 to ULONG_MAX, causing an integer
overflow that wraps the value to 0. This results in calling
damon_new_region(start, 0), which triggers the exact WARN_ONCE() this
patch intended to fix.

Additionally, could this cause damon_sz_region() to return a massive value,
breaking the logic in damon_apply_min_nr_regions() and causing excessive
allocations?

>  	range.start =3D addr.start;
>  	range.end =3D addr.end;

[Severity: High]
This is a pre-existing issue, but does this code leak the context structures
and orphan the threads if damon_start() fails?

samples/damon/mtier.c:damon_sample_mtier_start() {
    ...
	ctxs[1] =3D ctx;
	return damon_start(ctxs, 2, true);
}

If damon_start() fails (e.g., returning -EBUSY or -ENOMEM), it returns the
error directly without cleaning up the dynamically allocated contexts in
ctxs[0] and ctxs[1].

The caller damon_sample_mtier_enable_store() sets enabled =3D false on erro=
r.
Subsequent attempts to enable the module will allocate new contexts and
overwrite the ctxs array, permanently leaking the previous contexts.

If damon_start() successfully starts the first context but fails on the
second, does the first context's kdamond thread remain running as an
orphaned thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064653.1829=
-1-yuzenghui@huawei.com?part=3D1
