Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483435;
	b=Y+gyForBDiujpxJ5s/ucJBhvo07fvA0wlxuJQAGyN6pPgR+e4wLb+BIEd/VKYRPrf7mU
	 nnmxwZpWPqln2N0YIrO3IcjpFYWCBTTuoT3Y0xLrcUEWWjKYsK73+N35sbUhhRtJxRTuO
	 EsKx4GoH6NBNoh92YpWEs+qeccW3hqEIZyJ9HD97HQcUXdz1K5krDRVU7GSercyh9An0y
	 o4ydKbXJK5K6b2nSyHF9dt7JWaakCbwmmdFwIouCjRNfXEfC1Aofe7tFEsO//PpO8Lg5C
	 8cBueWIi4iwcSumUDQGjJeYUmVLqxBFPY9bgiLjjKKKRoL4XTA1g+7DBd3mQ45WtQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L6WY9rgPVusNXJvy1MtCG7eHkaFCa8LJ1hX2y8nE4Hc=;
	b=CRTmU/tK102Yo7WcuwwLuMzbB6o/+AIjciszWH5ZE8FIPuhMoLyehK56VMVvn1DsOpaM
	 dQ5wsX4+uML5r6w3Kjf2Hk1JM/LjbfqPICOdBj5LTjIudQLUoFLuEEowgsV5dm6pAh9Wa
	 /T/lIs7PPSS5PQBPgz36wVOqwUCdicUNslvo3qGzT50JT7ydzZX58SnlzznCJymwouPJT
	 wNu1UQSRPmYmiDhV0XxVaOUWevscKOQKIqV2i7wu8LhYo8uuq2jShn2v5xXaLtuh+ytQi
	 ynfq3CUSlbllh3SwN7iLHItPWjr13DRVQzOcYWTRL5l+e2tafk9/ajHMxPFVhuisJYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSRvcaWE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F7606A325
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSRvcaWE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE0C1F000C4;
	Tue, 20 Oct 2026 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483434;
	bh=L6WY9rgPVusNXJvy1MtCG7eHkaFCa8LJ1hX2y8nE4Hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSRvcaWEqPi9nF/5NLNTqeW856hXiYzQmIOV+jd+gEjRhz8mxLbRQouSgMgEViD6j
	 KlUMRi5w/4cMDnTSxntua1AZplFtQDBIKoRmE6N79ci9PjK3iMLPO609tMa6VGfKY1
	 Q4d7BLx5wKF23t3bObL/zrwGPLl9kcSGis+tY9nZ8mNQlBfQZM+jD+eFZjlhF6SZrA
	 e7wyx9hes9EDGYS597aPHBbZqvgdvMRh4hidMvExdO5u5Fuag80UBGquEfBdgNx8Do
	 Upro+2ZOc347noYyIUrP0dM/dmrtlxNLuCLxr8NSC6sUE/7mu3wGFTlWiGiAc2sS6S
	 zdgzfCE1UrzRw==
Message-ID: <sashiko-outbox-178473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261020023958.108276-1-sj@kernel.org>
References: <20261020023958.108276-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:03:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota->charge_{target,addr}_from saves the target and region the
> scheme's quota limit is reached.  damos_skip_charged_region() skips the
> target and regions before the point.  The target that was assigned to
> charge_target_from could be dynamically removed from the context by the
> runtime parameters update (aka commit) feature.  In this case,
> damos_skip_charged_region() cannot find if the point is passed or not,
> so the scheme is effectively disabled.
>=20
> Similarly, the user could also remove all the regions of the target
> using the runtime parameters update feature.  It would be uncommon to do
> that, but it is a supported feature.  Because the skip pointer detection
> logic (damos_skip_charged_region()) works for each region of targets,
> this result in the logic is entirely skipped and the scheme is
> effectively disabled again.
>=20
> The user impact is that the DAMOS scheme could suddenly stop working
> under certain uses of the runtime parameters update feature.  It could
> surprise users. No crash or leak happens though.  Users could also
> simply work around by re-installing the scheme.
>=20
> Catch the corner cases in damos_adjust_quota() and reset the pointers.
>=20
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c4=
9b8
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020023958.1082=
76-1-sj@kernel.org?part=3D1

