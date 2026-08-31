Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2F49503F
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198859; cv=none; b=ZZeFqj06U3nHL6JHEhjYs/gtKQErV2UJxbygbNjKdZgV93HO5wbjt4xUbayQepkqcyOZKZa4GuOaimJMSo53ERxwcEdo0/4q9dQFyxryZYpJhKvpXvjsflaEZ+NeV46HWLFkzfCdJJvkb1j/+MK4Ltwf1cPYrTHlK3HCUibcMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198859; c=relaxed/simple;
	bh=nffnnv5oTf4OtNWibXcWlQsdM9yDs3iJX56kDMDXCBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bR2noaHrOdKNB0cfL0M6FZaav1NhwTottOhEgG3SnlW7SSqycwAEvpUFa3O1LVpXXEll3YQRVCvPt2DUIVoUQUH7qskFYXMu+VsY1R0lFemgZF43r+tgJqXYUhOlkskdZqenKkbBw2k9eRirKuQVQEZWcVUXBUW57m1/sQQWDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE2sJ/Ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE2sJ/Ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EDE1F00A3D;
	Mon, 31 Aug 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198858;
	bh=WNXc6XfQOE1ffesllVgANkpx61pxxz3ukuTfax+6oV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZE2sJ/NgSVL+X7o1EopoCoIgtKyTnEbjwEOrLi8PthKyOy+Za/XH+3SBg8EsanaX/
	 Rbjajtuwc5XEYp+VpwYZnUU2ayD/za3Uf7isy5TRLEr7I1pV49FchQm0o17D5AkZG6
	 0ZM/MHUzMKLhqv1Bld7PiXjblW6x/8SxBAG465s5HYf0lo76dr+hbAMXc1kDD2P1Xs
	 QNdBJ3kyILH1Qzybtj3HlpMaGhRXrxxbGCW0s8iPZS0eyFsvabRvJQjWCp7xKf5Eqt
	 TD271JM704QLT/0fxu2OfW50nOX9pi6Be2asOjji4gAPn4VDCdfhpp/xW9Qcps/bVU
	 bHJWqsBzFjUvw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 2/8] mm/damon/paddr: respect folio end for
 DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-3-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:54:17 +0000
Message-Id: <20260831175418.64EDE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The function for applying DAMOS_STAT in DAMON physical address space
> operation set (paddr), namely damon_pa_stat(), applies DAMOS filters to
> folios of the given region.  For that, it gets folios of addresses in
> the region.  It starts from the region start address and advances the
> address by the size of the folio of the address until it goes out of the
> region.  If the start address is in the middle of a large folio, and if
> the next folios are small, some of the next folios could be skipped. Fix
> the issue by advancing the address to exactly the start address of the
> next folio.
>=20
> The user impact is that the DAMOS_STAT-based page level monitoring
> results become inaccurate.  Since the page level monitoring is supposed
> to provide relatively high precision, this is definitely a problem.  It
> is arguably not critical since it is only monitoring quality
> degradation.
>=20
> Fixes: bdbe1d7bc325 ("mm/damon/paddr: increment pa_stat damon address ran=
ge by folio size")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D2

