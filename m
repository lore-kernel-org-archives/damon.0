Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B31377ED9
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618189; cv=none; b=gUFopqz55smxcJkQM9dSv4hwO90eEzmqV739W76hZSzLLQWoNcMT66d5+Qw8S/gd2MnuptxV3mosuG5Lz6p+THbganCAyTruWOZ/6lxM2YUmlPxLKbksQN4Ss2/HFYToI7DiMW77dfNmzE/FTiSmmL2NDyrGx1m85WVfIpQ/Xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618189; c=relaxed/simple;
	bh=WnVWPXS4B354f5iALRujv851XEwunL5WVFuQXxf2XrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6Wy5FB7xsmLePyv8z0X904mN4bsYWSszvNyEEJXAeHeGFy/aPfQJrYdOuPxN8McR63RJ6vPUu+AfKzo5yc4I59xtuXh9uoMVCAbLuV0OxScSvBB/S7B7M0BMW3ghfSCEzfSGjDGQ+eblhLjnY0zm9+JzoYFXDnBnk17gZ4hP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djb91AZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djb91AZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836B31F00893;
	Thu, 17 Sep 2026 04:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618184;
	bh=ur1eDKmwtibWlXQ36XLMbTsjVYs8R+/7PWBvTZI0TGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Djb91AZVj/aidrExrcsoBno9qDjp2c90mI3bEGzFT3SWGcHH5kku0YGz82UFzlorQ
	 ihEdh2QiXieuAxk4IR1ixZYX/yx054B9iYN+QnTbbWM2kEbOeI1/34pQR+hTgW6g/s
	 XPmuVMAoH1Luj5dJHbspVN83L0xTuAmApCqR+NIjpOSVEiRymDXfEIt+FW3WiR8WhH
	 /miDkgFrvj3BK3OA24mLw2KEibvKyadqkjuhMzJrq3eLgCDMUomRrdSoB9U+3blpkp
	 Vb/dRSfd7oMsjJSIwW705YVaHSmMp3udHmA30UmFVoI58RKY6IcxJayJhlSkMxYdDC
	 Gxx1tkrkbhq1w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/10] Docs/mm/damon/design: clarify bp is basis
 point
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-11-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:09:44 +0000
Message-Id: <20260917040944.836B31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON design document uses "bp" for "basis point" in multiple places.
> Because it is not clearly mentioned, it is difficult to understand what
> "bp" stands for.  Add the clarification.
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infr=
adead.org
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D10

