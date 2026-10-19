Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424193;
	b=nPzyWObUgW2aeQfynAulb1tt/pI1SrK3h74DqVHlBjrTdARMNxg13pvlf0u1sMa0P7T5
	 fCAAXfJM5ZkeGXVKeuhq+u6UlRMGq9Szeic7ftOvzOXxicVw1UlBCr2oXVOUWXXGK7YBW
	 VlrVCHci6OhUMhIRym4sh7VQw6iU86Yq5/dvZeTgrWC+ZZGfe2oMJ88hoHqgx+bODqunR
	 1JcNdb2ls30Rod8OhVV3lGO1wa6/udT6bJkVV6+weZ1x7Mix8KipbvrelaKbzsE+qTfy0
	 MDWzXqoGgKaaZ+oYU7CAHne3VIgYwswwBgvWig7DesiJoEOXRfh0NbcRgUCxredogcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424193;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/+ek51YRgszwIPOcVnLQdglqQ5oAAxgeXhb6CBw1CBc=;
	b=ua9BLYrdRtnRnlsVE9UzdheAC/A/WHiVfGdcCegatS0gkA1YgMzMvvLoyDmVcYyHwMIF
	 Dy3x9KkQ/4hQT3a1F7Z0ZB8OUSXh7yL8RA7s+TPgVbCfzYZ4IKXIgXg33Ex9omovZgNv8
	 VedOgkiFwdGcfPUm3gwIrfzcgqFYXue0VqYGR8st59cN0brvYNcdLijGgoxPorn6p6qdx
	 wYjnOPcL+sMm9qOU8Ushp7UsxknGh/TmP/ETYuusFsrVammVkh6FGnGtFwoXnkG8Wgj8a
	 gOogLjOCjPXtwc2HIl2ZuqaGIZfBFFMUbV/nZW/GYcOBKu2g8OBTrTMTaOgbN4c1XVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNIiZwzn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6A606C15F
	for <damon@lists.linux.dev>; Mon, 19 Oct 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNIiZwzn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA21F000C4;
	Mon, 19 Oct 2026 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424192;
	bh=/+ek51YRgszwIPOcVnLQdglqQ5oAAxgeXhb6CBw1CBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NNIiZwznaGgkGo5Dkrzp8SjpBS+gnYZGXCZC0dJHOdP2zYKDNpBcxQ+ZA8IPlvSsa
	 Jp1vuDxBKgk2WAuTR7LXMYdydAcc5i9varmaCFe0cFNsfGPO4BWAXXUURdlEnFaXqV
	 TCBApvS23SuhmHUvG7bKiq2stPWOfPDInrxCrwQC6O7a6K8L2UKNYuMUCMvPdd7nMt
	 CkYnyop6Tramr1DoNA1QsRcydw0HMTrVbrIaFScDLLj9mTk504c/OBWMTMMGE/aY2T
	 VSLnUdwhOblC6iLZnEhKBFZpWcpSnsFstXvDn9sFZiXBAhL2menBoJT+YRVsjX2a0l
	 3bFtoqlBFZHoQ==
Message-ID: <sashiko-outbox-177767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261019143713.98610-1-sj@kernel.org>
References: <20261019143713.98610-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:36:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota->charge_{target,addr}_from saves the target and region the
> scheme's quota limit is reached.  damos_skip_charged_region() skips the
> target and regions before the point.  The target that was assigned to
> charge_target_from could be dynamically removed from the context by the
> runtime parameters update (aka commit) feature.  In this case,
> damos_skip_charged_region() cannot find if the point is passed or not,
> so the scheme is effectively disabled.
>=20
> Similarly, the user could also remove all the regions of the target
> using the runtime parameters update feature.  It would be uncommon to do
> that, but it is a supported feature.  Because the skip pointer detection
> logic (damos_skip_charged_region()) works for each region of targets,
> this result in the logic is entirely skipped and the scheme is
> effectively disabled again.
>=20
> The user impact is that the DAMOS scheme could suddenly stop working
> under certain uses of the runtime parameters update feature.  It could
> surprise users. No crash or leak happens though.  Users could also
> simply work around by re-installing the scheme.
>=20
> Catch the corner cases in damos_adjust_quota() and reset the pointers.
>=20
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c4=
9b8
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019143713.9861=
0-1-sj@kernel.org?part=3D1

