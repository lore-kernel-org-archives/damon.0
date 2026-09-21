Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCC1A239A
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956475; cv=none; b=Z91CpTZcpW9ZVqTekSF1JLj2LkzSXCOdhTgdVNbuxbWLXWPKmGDwJdP/B3GOEas9lhOraCAwZbExO6IAGmlwQMM9oNGbk9UgWBWDDaps3+Q71jszDey46VJIYVMPln4+x1hivnvIy5f6lxpGAe6Rv+BkxOfRoj9YTRVrm2hvy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956475; c=relaxed/simple;
	bh=6bHKwYK7TQnStn9RyVGhwTQKNPN8mUdfJt/LOdTqG0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhGhW6hrdlIfrXhvtoVWowy1qJY7BMkgpqKbxJXcFpv8CHiNgeMWCug58rANHA280Yf8etHRBq7OGiZ3DTqT3W0k1GwIeKj73sBZJTskz0yUUHGeWpjQ9nkYHx7LRQfRE7f/ZEsFAlzQbAc2k5jIjM24VsbbOcMn49OHxiO+uxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2BHm9Gw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2BHm9Gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E341F000FF;
	Mon, 21 Sep 2026 02:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956473;
	bh=6bHKwYK7TQnStn9RyVGhwTQKNPN8mUdfJt/LOdTqG0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2BHm9GwdJoXlK0qve1vs9b+fpkFIIxGWn6d4Gk8xPVh0uBMfJhflZqydCaDBxB5S
	 0wo+GzPKC0GwSV5L3czbhHYbtUrzWsrj7PHakbKbedBwI+gl40I4zCbya9ospID9lC
	 QLz+aZGejZu9d8BWn/3mO46ZGEglloeCjrmk2GM0PYWtv9KxK5AdHxK2c9fEiR+VVn
	 WiDFUPSVl8v7BePXVh0JJ1O1G0Em2Jw5Cue4i9+Icn1ljmAOvHmd+DVm2VF6vcj1/h
	 pVhc/Liqm4SC8/3/Fimgo64sPSpVoB8QiZx/TUgePSDXorJHP5H0S/T49GwNJHzoOd
	 PIxOpZkKa0Skw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: keep the temporal tuner quota
 over an unmeasured PSI round
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921020013.33105-2-kmehltretter@gmail.com>
References: <20260921020013.33105-1-kmehltretter@gmail.com>
 <20260921020013.33105-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 02:07:53 +0000
Message-Id: <20260921020753.B3E341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Commit b73198a47ffe ("mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total") scores a PSI quota goal without a
> previous sample as achieved. This leaves the consist tuner's input
> unchanged, but the temporal tuner sets its quota to zero for an achieved
> goal. A running scheme with a nonzero temporal quota therefore loses a
> charge window after a quota-goal commit.
>=20
> Use the effective quota to preserve the temporal tuner's previous
> goal-achievement state during an unmeasured round, as SJ suggested [1].
> Score the goal as achieved when the effective quota is zero and as not
> achieved otherwise. A new scheme's initially zero quota stays zero, and
> the consist tuner's behavior is unchanged.
>=20
> Move the PSI current-value calculation and last_psi_total update into a
> helper that takes the current PSI total. This lets a unit test cover the
> unmeasured and measured rounds without depending on system memory
> pressure.
>=20
> Fixes: b73198a47ffe ("mm/damon/core: handle uninitialized damos_quota_goa=
l->last_psi_total")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Suggested-by: SJ Park <sj@kernel.org>
> Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org=
/ [1]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921020013.3310=
5-1-kmehltretter@gmail.com?part=3D1

