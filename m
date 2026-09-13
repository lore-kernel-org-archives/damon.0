Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDF370D41
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319611; cv=none; b=oEZ4+fwz1SsCT/rEl00oACEsRQbyT6WRSTebM37nTn+fpXkZ4YOS9Q6+CIFI0BlpwpfdvuGnrd7Ahr0ltAbuk4d/TSCOL+rrSl4M70NHk0e6xiywZNxxZT5j1ad7N66/XrgsGGVn2rn0SeGY+ctTsLeqa3Yb5yhe3mF7ZKI+EOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319611; c=relaxed/simple;
	bh=dAP4wDVtKWNGlMvlnDDnMc414Qs5ydmVa5LSwcQQ81A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmkcNG61emaxtl50EmRuiDRm8KkpiG4URUxeNAmVeyeGijXigkcTeTI8PEeGm2gb3t0/wcdrDEjDfJHfMBcMHFrzPzqrIFcnA5tSLei+CVWPo1jSl6Qq7nwHIeokbOZy1DT6IYm3F1j+a/DtMnL7hqRctb6OpY8TsimA3CxwgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwCJi/Ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwCJi/Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2841F000FF;
	Sun, 13 Sep 2026 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319610;
	bh=dAP4wDVtKWNGlMvlnDDnMc414Qs5ydmVa5LSwcQQ81A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwCJi/Ax0xstRjxcm0bXpVy0Ahc/gRZ/LT+ILG/cRbqLogyEK5Pk1A4Hvxgi7oAHY
	 TNhd8c+53FlYcCcXnXHKJGZuakARls4yrH0jh065teywuo0D8UFBmzAsWeS4EFexgv
	 3p47sDyQlSp1u204U0qTfh6ytLyqVLTXMC43TMGYMHAQDlMzE6FBVVga1/o8lpCyCA
	 R2PBXn13gdfQECC2wO61p59SH/zMXdNjIHCaRLL0KZlhHCRIaPjcOTmfCEagwGK7Yg
	 khQBZONv7bUtwHpXiyudXlENSS8sv8EzSpcYB0vBMFQI/qAPRz/bvhG60cDWgLpUbz
	 KiJTMXhrx0VRQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for
 hugepage_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171133.102366-8-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
 <20260913171133.102366-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:13:29 +0000
Message-Id: <20260913171329.CB2841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added hugepage_size data
> attribute filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171133.1023=
66-1-sj@kernel.org?part=3D7

