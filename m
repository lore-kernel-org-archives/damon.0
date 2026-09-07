Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034364AD7DD
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784765; cv=none; b=oqzr2IjiYhAd5kCsSE/frYGTMBF4vtOEGQ8BFQstNDSPTG93UmxypZvwCIAYclnviSCiz75W1luwF8Lz+ji9amYjEDNch2+Y8Hn9f67iS90OqBI9Ul7wwxkRfq1/GzCqmOUN9o8eckE2+rWR5g7n498jXc5QuZAdpcXeCZM3944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784765; c=relaxed/simple;
	bh=HHbfa1xjLI9mu79ItO52wCbi31Tp69wvAEcD4qUn7DU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5ttUbhoo9muOWaZmgiAGnCe1nGwe+f+s5kX9nXBcMBVo0ysgxZi2uYP6iEouZVx8QaGKrBF6Ci+bBqzAcIcTG4/gJKiTUYDn504MOUR39T16WsskO5CqvT56tfSOrOVJb6Lp3mUW5f45Az4OcXeuiqS2mSJo9cmjSrcmQth4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCzH0Xum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCzH0Xum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C991F00A3E;
	Mon,  7 Sep 2026 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788784763;
	bh=qXkx0XYPAC5ALf3cjFnOoZpcY1jP9OBNWy+ka1EkEB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCzH0XumyLdPzTHiIW9I/+JPkAFL7o4y2V78ZP5SYb+zcJgh4XH+jMIcJBCFOMrjK
	 mxwmeYohy8mHtxvdKoIgY4ROcVFN5iMpOkTLJRancudF0lAsYVb/67xOx0EorrzkZm
	 SKIRcFx3on0v8h1KOyH5FUH/5PEM3y9iXDlgJq1S+2LD2GFKFogODh/kTFdHMGkdjV
	 dAoNv1iOa/e+LYoH2fYQZKbEC/j5vDTxqytomOSVLy7ryqrmffj1OXiYonv/EseM16
	 DUcUACCVpayxrdnv+wDN55uvgyrfa/xN+p7Qa7DXeB4ut4IbUYjpoImH8HDio+v9Kq
	 RjD8lPq1heqAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/damon: stop kdamond on error exits of no-op
 commit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260907123455.67246-1-zenghui.yu@linux.dev>
References: <20260907123455.67246-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:39:22 +0000
Message-Id: <20260907123923.22C991F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> The sysfs_no_op_commit_break test starts a kdamond via sysfs, but its err=
or
> paths (e.g., drgn not installed) exit without stopping it.  The leaked
> kdamond then makes subsequent tests, e.g. lru_sort.sh and reclaim.sh, skip
> with "Another kdamond is running".
>=20
> Wrap the post-start logic in try-finally so that kdamonds.stop() is
> executed on every exit path.
>=20
> Fixes: 10725cd2b09a ("selftests/damon: test no-op commit broke DAMON stat=
us")
> Assisted-by: GLM-5.3 OpenCode
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907123455.6724=
6-1-zenghui.yu@linux.dev?part=3D1

