Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792871054;
	b=JrE3y7TtCVedcYCUdg76FMXAF09nqzn9tQjzUxwxw9TKK5K+kuEBodaqSkV9AGQPQPSp
	 /TTCRHAfg6+PdqaaGcBctIPkovUQdA2V/knlky1IuhSxmK+hr0jCinroPWRGS6mg9bTb3
	 DZLii3KcuOu/YETfZSVvpBOos0rprNRx8QvkjeGKnOyD6f0yC4MxV/6/YkaV7fqV4k447
	 V3+UUkiklkREr3l7EB/EfkXbtpdIO3fhsYOw2hqsg3Keeblyxm1EL4lEPiStJJpO05kqD
	 Nt1RCcFRfZG02DKJWgO2D0wK6w0ZOlxY3X+EYJUpIonCDwSNsAmTRlbDsmuRBZUr3Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792871054;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2QnTcRtF2kC0OpX+XJ0Zik+fwgAO+AWm/RbN/Fyi7pA=;
	b=Jx7ZqwHyJ7U+AgMlPucqEXjuO3OGbRDQHtuW9XWjHoXmmQNvC3Xn54rlUYU2XD59iKp4
	 M9qZTRqMM29QmCJREzMONZdSTiZsfBmqmZZA7Ofs07MYpCzsoLWQHjkh/67PxR1f+OLue
	 mhMdkACmKu2IEIKCNwwRl/Ph6istBc7NOpXGC40+6rF52tpJ4zzUfG1uH4bAWce6n4lOp
	 2nGIAMZ+HvUCPPXxqvbtMLHl8U4xDbI0m/TCjr0QrRW+sERtOaAADDYRgWyTC7Z+ZWmEZ
	 hwBfLKDrQ2k2Be4LV47UPRHCXxgOs9J4ofwJ7Ejm/Yiz+n939VMnc2hY4bVrxiAcicw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvoWz4VY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8617606A31A
	for <damon@lists.linux.dev>; Sat, 24 Oct 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvoWz4VY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED21F01825;
	Sat, 24 Oct 2026 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792871053;
	bh=2QnTcRtF2kC0OpX+XJ0Zik+fwgAO+AWm/RbN/Fyi7pA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WvoWz4VYoMcVdGdXocYEnka35Pdj1duLmPDJESjbsBpEBOj2g5kpVkyOERaUXGt45
	 wGfNqRsKxDmrRccWdNPHZ5cGcyoyf8YkRkX+WZaG1iC32FI0wPX5zAh/Li5qfRV+QW
	 +iNcjtBUwIH897Wo+FB6PxqNJSw1RFSU/Sj319l7CFO1QJ+DutFac3Loyj5uGJOO39
	 ta1XDETFcBRfgNsqqUUasCiBDvsrmZd7/1MFxD0WX5A6KwS8/29NL2XaVmnKF+B2L9
	 EYveVOdByap+GK9qmgROfcQHylnqZpgs0dxzORtpMCn7sp026wLk0gzDXhfUG4wFHd
	 QSFuUkYvyJv4A==
Message-ID: <sashiko-outbox-183864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] mm/damon/sysfs-schemes: hold damon_sysfs_lock
 in target_metric_store()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261024193351.87130-2-sj@kernel.org>
References: <20261024193351.87130-1-sj@kernel.org>
 <20261024193351.87130-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 19:44:12 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_add_quota_score() reads damos_sysfs_quota_goal->metric
> twice, once to set damos_quota_goal->metric to the value, and once again
> to set the metric-dependent damos_quota_goal unions based on the value.
>=20
> target_metrics_score() can update damos_sysfs_quota_goal->metric between
> the two reads.  This time-of-check to time-of-use (toctou) race can make
> the union fields incorrectly set.  The incorrect damos_quota_goal will
> be passed to the core layer and make DAMOS incorrectly behave.
>=20
> Users could reproduce the race by writing a new value to the
> target_metric sysfs file while DAMON is starting, or online parameters
> update is ongoing.  The issue will only rarely happen in the real use
> cases.  It requires sysfs write permission.  The race window is short.
> Sane users wouldn't do such writes while DAMON enablement and/or online
> parameters update is ongoing.
> [ ... ]
> [2] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org
>=20
> Fixes: 85fcf0ffc460 ("mm/damon/sysfs-schemes: connect damos_quota_goal ni=
d with core layer")
> Cc: <stable@vger.kernel.org> # 6.16.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024193351.8713=
0-1-sj@kernel.org?part=3D1

