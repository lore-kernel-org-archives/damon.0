Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648784BEE32
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789217388; cv=none; b=mHSfz/MXWGMEKThT6uoX1H0Q2yGyV31COvgjP998jmK488NuTPHqosE0Jss4EEvWAp2xGm5m0KUAdCt/qjyXGopeiUZzMjVRLDGUkF13l75fEcgziTIbi7UKg4KlQcZ+ME2Vlkq7RapS75OdV7aJfHbG4iObPeGxtGaHQGW/mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789217388; c=relaxed/simple;
	bh=J+Oavj0Zsfu5fIWpuxoyXOryhxkVbHArS/JwxOa7zW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dNb2S/46mTM4qN4uEppyg5zduY/OKTKgAmO1yYJ8kV6U5Nwxu9VPNu+MzojvYDCyX/X8K9sxa3vhQBl7rRpYNdzaE3yqhu65lHpAVCgCcQm2KF9SDGQ18Tztl2Ct3TcRLLplxsn+ziVHThW4iIz9AcLFzBwtT1b7Ptc2c016H60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql7W6vw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql7W6vw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AC11F000FF;
	Sat, 12 Sep 2026 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789217387;
	bh=GOhbLnpMkk/Kc8fgqzLQbDhGhTkJLACLVHz1lSpPMAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ql7W6vw9ZBATF4O/Kg5pySTS+RmwYLevBDC7QeyfUsg7ROFGlNxtYMXvDgSDySuwu
	 PzQY7iF9FPyYvMCMDGQw7XvGV1l4/zPpLt2T7Lh5Lgxzpt5au9L9nDnOV+wNhL/h9F
	 2gpHhhxO27YR8LYY0tO+q325vwaisrMagwU4LgUXd92gdAqdDD5FFTpdxnAJ3oelLs
	 X9rsDKRYLMFrzYMthU+KSW5ka9t9VDRC5NQv70fdvLYAlvZulAsupPGMtqR4sLj1Nd
	 viYfLMJyqM0FyC/OjHOPif7d1cyooRQSOW/tge4le224LKh+0uZmqK7aGma1AKqQlN
	 b6DRBNMs/DIGw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: add short circuit for temporal-goal
 schemes in damos_adjust_quota()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912124406.96535-1-aethernet65535@gmail.com>
References: <20260912124406.96535-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 12:49:46 +0000
Message-Id: <20260912124947.02AC11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When using the temporal auto-tuning algorithm, the effective size quota
> becomes zero once the goal is [over-]achieved.
>=20
> In this situation, damos_adjust_quota() still calculates
> quota->min_score for it.  However, this min_score will not be used in
> this window, because in damon_do_apply_schemes(), damos_quota_is_full()
> will always returns true, preventing the scheme from being applied to
> any region.
>=20
> Therefore, add a short circuit for temporal-goal algorithm schemes to
> early return from damos_adjust_quota() before calculating min_score.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912124406.9653=
5-1-aethernet65535@gmail.com?part=3D1

