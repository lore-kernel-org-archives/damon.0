Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8226AA91
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267652; cv=none; b=MLV2ZvUM0voVvHFV9L9bdjLH/2+LZTK75U5Wc87H7PVvoFEc3mwyEcBN96x4Gs4TlF+tP5dCXMJ/I6eXWydoF5J6IOJWKr4rYTbT4RUJI2JRPPhOgA7fPf51jWjNdzCWZbfFInF0xgtWyEDMKs/L46FNbvZAuHamHa6TgPeI2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267652; c=relaxed/simple;
	bh=fHEb08pw4wDaewOJGylmC9Ut0tn1369WKHDgqFmLdhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0ulPf9sfWJ5qNYBRF7y8Vqp7t5ARu6GKwgajZETxx/Q/Z7NNlbr6X2mjGkH7eN1cApSgwnd/p2URGHDl+y7zNnnLcdqaunkOtm1yz8aFxazHxgvyIEaPjnAL2z5acqLbZKKYroo7G4xp3djFJjBDmmlE9PiWVEtOuwXe9DS8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYBASFqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYBASFqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635491F000FF;
	Tue,  6 Oct 2026 06:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791267650;
	bh=fHEb08pw4wDaewOJGylmC9Ut0tn1369WKHDgqFmLdhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYBASFqM77HcK+nb3hhaudYvBrH+sMhKScPdmh6sdGJo3Efe0zoBYxiMX64HgMVNo
	 Ia2Hv+wTiL4Kce3LxLFUYI5ggWALZrDWPlDvjGtJICRWWrbhaBG+92NrpCIzL1crEH
	 FHt9CDQGH+ZmH0iZOe4SK29M+izTPL/JG8FBogCqd7fnTWkMWzvkzVJYsqXeRkwss5
	 NjpqoZot/SFqmrJP65qa045kNQ1K9a/+eF17zNyl2M3xGSIm+EbVE/aCyWQWhaR3Wq
	 sv1YRm0CAfSS/J3+XU28KH24DyB5oculvEUxZNE1DcTWxT9nmLyjbPGtlanoqZiJqh
	 ZQXLctqQUyO2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Docs/admin-guide/mm/damon/lru_sort: Fix copy-paste
 mistakes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWRyaWFuIEh1YW5nIChMZW5vdm8p?= <adrianhuang0701@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261006061549.627-3-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
 <20261006061549.627-3-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:20:49 +0000
Message-Id: <20261006062050.635491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The DAMON_LRU_SORT documentation mistakenly refers to DAMON_RECLAIM
> in a few places.
>=20
> Fix these copy-paste mistakes to correctly refer to DAMON_LRU_SORT.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006061549.627-=
1-adrianhuang0701@gmail.com?part=3D2

