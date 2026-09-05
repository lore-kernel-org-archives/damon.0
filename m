Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713F314A83
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641100; cv=none; b=JGd/Tnt7Bw92mhZpOhuN9uNVSUKHACHIKA/IXenYAUXyI/AKW8+4uK1oUuPef4K/oukYQdT76SDy8NXq4e/hAtIYc95C8s6yiUzAprJo2ZBwX8KydeNiFiOcefqfYdANQLlvqy044Hh6aLJgvTZzJv5jQAwds8uoknODa5vWZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641100; c=relaxed/simple;
	bh=vYK3aybq696zlXyaUDWiGm3y0C5STEHoNAu318jW5Lc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BJ2t7eXh9wiM22M/CZjz53SFuxEHrCNfv5kNJvjE5NEeGtMDAUTE0estndxun/bUCj76ov5Y8VeEvjro80hqkto3vaRsAARS6ApcSpY2OLyYVTCBhBC2ZYFcx1y/wFaUcMB4Al5s+pRvU8fA+7Dmbeg97KBKlXu2kWARW1L5Mdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wti6KOio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wti6KOio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4326A1F00A3A;
	Sat,  5 Sep 2026 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788641099;
	bh=bSgCg/eU2AkwcsK9TJrOog2bVdYjUJ9CKpv4pfefG1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wti6KOio0rQ55Xp2tsph0Tmg6UkFErpq4eIbqgoMYKMZZiAKPNwmrzx4lGVsUU/3W
	 Hb6gfGHOVZpm79faaCcCwDzSH+67SxNYDXh8TmdFqCrZhRpo//l3Mf7Cxsi8gZKeqr
	 mESWqkO3zbNX2eE55GhQ7+AoThcyIdaLgxEvOB1BEZ2uxQHrXSYT8DuqH63xtlOZV1
	 mfaeW/y16BmUHXU6AHjDvxspg8azyg2EcmD6iTKfM/TEuG249MgNjmSvsaNAk7l3Vr
	 2WN+JybkCntnxZMulY3miSpi4UQ8nkdMTfta2qLNYKY0VSjD82LwU9HcRdnoeMeF5A
	 ZcJqOSMuChFMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] mm/damon/vaddr: support pgidle_unset probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260905202634.88102-6-sj@kernel.org>
References: <20260905202634.88102-1-sj@kernel.org>
 <20260905202634.88102-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 20:44:58 +0000
Message-Id: <20260905204459.4326A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) does not support
> pgidle_unset probe filter type.  Add the support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905202634.8810=
2-1-sj@kernel.org?part=3D5

