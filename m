Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481092C3257
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237656; cv=none; b=JJDgWHqe+qLViWmrpv0+2phqh12tx+aQoUd0vBmbWtzV9RrCA1MBdEtPXGGYGMlT6M1z4cvree1zChvKJPVDZ0MzZGxaEpMotfYCxldLxgpo+jjRx6Xn2sNewLE7pEnvyAH24LEkiHSS5klCfwSiMmOGuzc7hbybhiAslcoQcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237656; c=relaxed/simple;
	bh=5dxQ21Cxg6QqTKsi/5e+4DUL/b3+Hs89JV4hvlaIVOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GX8r3SqEoDK0L6hTSNX5RW7+zZ6b9a2/gagO7XnUL4LRN7FGbLFNXx/YO0NSwSpw5OsBjjVNXLzKDy/zP5pSv+Qin8MuOtaOqvlrOXwx2AVaFeioBPa+VDYnHKInRi8tWxN6VKbHO3hC4vPKZH4mBEXS8dkSXHcfAXvujsw0WcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWhCk/bI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWhCk/bI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014A11F000E9;
	Tue,  1 Sep 2026 04:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237655;
	bh=15CY5X9kYbanrBZ7QsIDXkGJfneUQLO+CuSiy2oYbFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aWhCk/bIcGCUxYnQxcp8MePGVbfmHqhavd8xPrWSjC4Nvh8jMjWZxReIfNnl2qwve
	 RrhmJ7lbfr3T8T7rq/JfencI4KUU1nMP5HJnHNnwEUWyUbuCjhnMN+Zb24RjNexAbR
	 Llg1BhJHvAAJSG1zzlRZdxJ7KnRW1ya4Qe1vOOlXXlu1Oc6T4lcY8X+jTmURAQAtTs
	 ec7FGP1/BdQaA4focT6PiDwtQpWKZ65Zi+quCE5jJws4ltx9cOXvKrrZmvhKXS1Rjj
	 T1BR1J/O6XyD0u2fSaLlbWB8xs4kcQilnLd6Ym9zci2/BCkYTAEFTvz3Li1yfft9WG
	 CllpfH2CB/szg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] mm/damon/sysfs: implement prep_action file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-13-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:40:54 +0000
Message-Id: <20260901044055.014A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add a file named prep_action under the prep directory.  It represents
> the corresponding probe preparation action.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D12

