Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD8439F75
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073531; cv=none; b=DkB56QTYI8JJP/tO1LYBd93/2TBstpvOgA8a1AUiWRZImyltNPdzO2QhQrrLhiwgKURU61uMrHDljQBU6F0Vkhwa62L5bB7rhX6hri4NCbRtwWxP1TQfTdgiU+4mVCUgmVybrXmQ+YdfHHxuT5JF6sE6WmuQ1Bn8yutTtnZhQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073531; c=relaxed/simple;
	bh=bHMrskOyywW2Myi5FuA8avW/y8SRi0WGeJJDPe/BKXA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hcWtoZNAJCbS6zZLos+KjXUw64pzJ4C5skNqBhsJL+a0NIoCv4Y+mPIbajFjKox7GcyFiPaLUnPXkHSnB4OFizhfqr4WnbjNL3Ni/o58odpkh1+a3UkTKlyaR9CmAWRz7JEM0DJwQCUDhw9cEQ88uWO97M37i+MPdarJoVJyLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuTi6Ghf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuTi6Ghf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E70D1F000C4;
	Thu, 15 Oct 2026 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073530;
	bh=bHMrskOyywW2Myi5FuA8avW/y8SRi0WGeJJDPe/BKXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LuTi6GhfyXOPvB1lz/hxuAeroHdUMWJTWGkq5rrb8SzIiDkiakbHeRYSUig2e5x6e
	 WnHlQ8Vy+DvqpzgLiDRBylBBwZdJJ1WqofgJwSYwCjpyK7V3vL6q8QspF6yGPHp6b5
	 47QvT4sGMZ4YznHG1CtrLicaqJ4VSDaw8rqw6vM3ph3d0PwVRuzVrqj2o3HFsCSO6u
	 uRqs50yK3/aAEVvTWIWmpFpe4vW7iK82oLTq5IAogs8ntSRY5Pu8IQVYGNMbig8xnA
	 kMtKrQQjfvBxxEkWEFMsEAusAH3uiSk6lFl80MFBei48aj34WBpiDX+07sgkaFcTPM
	 hAQWbNgRlVkAQ==
Message-ID: <sashiko-outbox-172953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] mm/damon/core: Copy only installed probe in
 damon_split_region_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261015135801.19326-2-suhaas@s-joshi.in>
References: <20261015135533.18761-1-suhaas@s-joshi.in>
 <20261015135801.19326-2-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:12:09 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in whi=
ch
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
>=20
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().
>=20
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015135533.1876=
1-1-suhaas@s-joshi.in?part=3D2

