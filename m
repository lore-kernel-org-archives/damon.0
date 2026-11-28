Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892183;
	b=XRX9iNscttm+QF7YQB8Bm1fH97XVlH5mr8yy0EORN046cYxu8SZEQE9XySCq0cE236Kn
	 ZrlMl9/tBphU4q+GUTAUeNLxXAPcJnXMwvKdzPw8yL30If2Nsi3aKEcXl6M+UmuBExQG4
	 LK7/J0CgqfxpdphIrGN3VgS8q7Q8avrP0s6u0atR0hyIbOcFOBZ4+tKGdA7TkZ724tP55
	 ARS3cGqUIObk//TcMLKH+bFGlMeFCLWKUPs19clEP6EW/HkXXjSy1bDagrx19VVtIhxdj
	 WmKXo+Wnn6hNVyXQi8JeURogw3VnG01gCjfN0ttSfHjcckJLeZDZRuOnlVUBN4P8FvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=afHOt3Ua88IRHFGBJ/3WRDSVkMDM77OwVTwLqDbUGXs=;
	b=gtZk49EJmL/vL1qnVk4SBsZ9eOaSq/ZanYewHQ48b9R2ggEDQdZxNPaje5isXdLCmNCm
	 lAuVORhbuZH+ZiZYzvPivA1cuMQuhONXC3B2bcjllsgTLV5yK5ePWnonhXwUdnXx764Mx
	 LzoKiNO96S1blog6Y9vwJ44c+/adAXNl7Fll548Dc3FqZT4KJbNrT1SOu45JE9lO/HkFZ
	 /nqF2zTMyPYNYye9wv/kU0lpEGOPGgHMT1eSgIfyYgGuSElOV0Gxng9Z32R89Tx+MSeNb
	 3+Q/8UL6ACfd+F7JLfNq633s/z93BceRwTe/eteYrYhRQJRm2JZUuQbkJqdXEQ+A/iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRGyq+Bb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA6606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRGyq+Bb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A551F00893;
	Sat, 28 Nov 2026 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892182;
	bh=afHOt3Ua88IRHFGBJ/3WRDSVkMDM77OwVTwLqDbUGXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SRGyq+BboaJ3RAqKC+UAZ+6hfeRsgvUdjHw8pV1MwYXUkOzSys8sPpzysvd+F+3UK
	 Y2GLOz6UrbSE2zEby3FhJBF3UciZEpvIs/vUhorj6+En1rNoVO/5GHl9lUs7/T+gjR
	 QcPSColOLJypsUnnsqF/3zm/Onx4CdJ48HnCs2tIDIZzDUD4/OW86UP7uGi0WY15PG
	 7uQCYYXGZOfuRqugIJJLXsTDPkYnqu3p/iXer38QUPtMz5NE3oZb6sqgOeiN/oCmDr
	 k5fPLyJkJl7C+mIzFUvyljRjkxDk6y3KfPpkAPDZLIOwxRDluRcqAuLDcCzP+Av3Wv
	 P3/LzLqyaTBiA==
Message-ID: <sashiko-outbox-238973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mm-hotfixes-unstable v2] mm/damon/core: do not
 update stat for core filter rejecting region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261128185140.163079-1-sj@kernel.org>
References: <20261128185140.163079-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 18:56:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_apply_scheme() update stats for regions that were unable to apply
> the scheme due to the quota.  Those are counted as tried and failed.  It
> doesn't update stats for regions that were rejected by DAMOS core
> filters.  Those are counted as not tried at all.
>=20
> However, the DAMOS quota-driven failure is handled before DAMOS core
> filters.  Regions that would be rejected by the core filter can, hence,
> be accounted as tried and failed.  As a result, users could show
> confusing stat changes.
>=20
> Fix by handling core filters before quotas.
>=20
> The user impact is not critical.  No crash or leak happens.  Only the
> DAMOS stat could occasionally move in an unexpected way.
>=20
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Closes: https://sashiko.dev/#/bug/linux-9c51890e-a25c-4534-afab-ef33f22a9=
557
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128185140.1630=
79-1-sj@kernel.org?part=3D1
