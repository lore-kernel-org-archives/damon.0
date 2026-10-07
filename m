Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6274BE456
	for <damon@lists.linux.dev>; Wed,  7 Oct 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388835; cv=none; b=MWNS7dytaA9ILPDYQcT1En9llje2QUomVrUfo5ihtrVQ2/q66FBEMgb9YGRmIZo9TeCFxqABsvszTkt4VrUK7bTRMPppOtGmk9vzqEErKNPLFHxD2++JLXPYspamCzKCtYtts9ru1UfjpV/O2T2ESJ2C/lSk/sLkekVB21BCYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388835; c=relaxed/simple;
	bh=yUbDkYYoYrHgxMCAocrkzyiZyj7mm8/dXfbV3DjWcFI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f0CM4kmxY9O/tgRoUvKexttJ8uTjVqh5L7LfFH4wmjkNPeJBg/zFwUyk08ryAbb7hXUGEyu9Mpz7wOvGBDY5iBko2GZ02/ndjUDam3vgxH/krdH/5iwC5ebsa/JfT/Q4hL0zU9P+omLKAZEPmDhoUO8wFFf9acQR8OnO6bpIWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEi3fP2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEi3fP2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B417B1F000FF;
	Wed,  7 Oct 2026 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791388833;
	bh=yUbDkYYoYrHgxMCAocrkzyiZyj7mm8/dXfbV3DjWcFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEi3fP2/SEfXP0sbS4rGLu7i8GwAdS2Qz86fQt0Og5frN4b21DjQQ5vk/oMpnbtuH
	 /dH/RndI8yDZWV0W14xPk57eY55so3ujLqhkYRszPq5yJk/rK3FRgQFxnCHOzCMmyN
	 wepkB/fcW0A2MKyeqpVgZMKfmLlhrO2LrVOQaTRrwrUM+CISl5fa49Tou0yXNbvMNd
	 m0s/mDR4yZEPhE7FBITNyLFAAUksrTwPT0IQIkfu6s30UGgqoczBoTqARA68nLh+/V
	 t1bnHn9zCAgfis7TgDPAQ/wQsjygU/EtMWmmoUnKoqWTTLXHT3Oerj25e5TbIN4MIp
	 7x48xjj34B5GQ==
Message-ID: <sashiko-outbox-163179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core: Copy only installed probe in
 damon_split_region_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261007154851.45368-3-suhaas@s-joshi.in>
References: <20261007154851.45368-1-suhaas@s-joshi.in>
 <20261007154851.45368-3-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 16:00:33 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in whi=
ch
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
>=20
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().
>=20
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007154851.4536=
8-2-suhaas@s-joshi.in?part=3D2

