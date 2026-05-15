Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CF2459CF
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807129; cv=none; b=c1hQQxdsDeZOC2RliBcGaP9w/VeLTHL6KliGBeEbYfS823RXgz9eKisivClxOzHZlGMkWLXEuxj8vIQZQ3pkIN25FIzZRCsr6DnjPtSw7ki7ILKXM2kBlPUuEDVy2FatGnlbR/watW9LqflbBSvZVa4xNAJixxnpfOxMGv9UJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807129; c=relaxed/simple;
	bh=7kSmoCsUJ5/fx6uTMUQS0tS11Ulfz8fmlT7Vce2azmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RvcD/6S6yHWsi6TSQSgbwMQoGrIGXVIOB4M7YhiXsdF8OuZBH3+5LF3LgQznPcbElvpTW6oKVxuHY5bPCG1EZAPbpJZxQ7+BDXPBj/j2sQDpnq7lOgSmFSyS+H/nulMXgyG/qPRxF408pCOgQ9ip2vDxjYd/hVMJ9gK6L6cvoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgu9AiCh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgu9AiCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E7EC2BCB3;
	Fri, 15 May 2026 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807129;
	bh=7kSmoCsUJ5/fx6uTMUQS0tS11Ulfz8fmlT7Vce2azmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cgu9AiChxj857KX+hgOk8gtGJwB+JPbeZCCXvf7ysy3lmB1asWSKx5pgh5HvD7zA5
	 XGCxTShjWwYDjpfzrgwgs+54iHSFy/9IJzgVL08/15jR2VwXs84EgptrwNafla1xnc
	 GbSZRu/3ToAaKYumpaTK7n21+0YSCI1tGRcFIAdcQHjgRKUXnMRL+s25jwkzuoSs83
	 335KPG3g7ntVtZoirPQqeAysbPeVhGoeoS//M5ELdGr8uCPOnMolyi4gjWsm8b2f/a
	 q1xTS1iryjDVW0ugnmVQDIuqBPi0XCiiZ/DYk0yZrQxhYhdZWrtmW1f0DIuuANRwZZ
	 +/0v0HdOwcqSA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 04/28] mm/damon/core: commit probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-5-sj@kernel.org>
References: <20260515004433.128933-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:05:28 +0000
Message-Id: <20260515010529.05E7EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] In `damon_commit_probes()`, a newly allocated `new_probe` is add=
ed to the destination context before its filters are committed, leaving a p=
artially constructed object on failure.
--

commit 2686f1a22f9199eacddb5ee3b2612cd585a68b00
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: commit probes

This commit updates damon_commit_ctx() to additionally commit any installed
data probes to the destination context.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 44943d654dcce..15f2795a1156f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[ ... ]
> @@ -1378,6 +1413,72 @@ static int damon_commit_targets(
[ ... ]
> +static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *=
src)
> +{
> +	struct damon_probe *dst_probe, *next, *src_probe, *new_probe;
> +	int i =3D 0, j =3D 0, err;
[ ... ]
> +	damon_for_each_probe_safe(src_probe, next, src) {
> +		if (j++ < i)
> +			continue;
> +
> +		new_probe =3D damon_new_probe();
> +		if (!new_probe)
> +			return -ENOMEM;
> +		damon_add_probe(dst, new_probe);
> +		err =3D damon_commit_filters(new_probe, src_probe);
> +		if (err)
> +			return err;

Does this leave a partially constructed probe in the destination context on
failure?

If damon_commit_filters() returns an error, the function returns immediatel=
y,
but new_probe has already been added to dst via damon_add_probe().

This differs from the pattern in damon_commit_targets(), where new objects
are only added to the destination list upon success, and are destroyed if
the commit step fails.

> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D4
