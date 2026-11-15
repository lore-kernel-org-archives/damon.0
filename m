Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774824;
	b=sbs1E2BFbt2b6N6OiKhI7sWJz/lgsaPW8yjD6hZMbVR2ZH6hPQMNJ4gV1KUnK/kaimkO
	 2TWG/EbHYh4DTUbQd0TIU+Nwqd2D3el/XN9jyjPA18ACHq8PFFq7YAR89q3UsGWCAQ9hy
	 anGlZTdV3/zN6HVHp0GgALj+sWwPwEGnE7DW30oZk5psIZT8MH5514IIXHN8SpcR4frjm
	 6OwNsI3H3zDZttJ5izijIaCHrQDE/zmbOKJ6Uj4KrjCA0oy3uHx5ViqW35mQeEDkfcDVT
	 gLdw2Cdpod20FIwKCt716FMNHgBC6GuTmswB0Vw5R7zmS2kf1eEudDnLmbuwQaoHlDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=05Y2U91mOodaWL3NHp7DqvU0BVrCPa7XinWGj3l6V7g=;
	b=GXCnKUOAN4xKkF60+r1yK36SBCj8lW6q1R1O9DxUCg47maBbEc9fTbB7lGJF+9vfUw3u
	 ZEueMZ9FqHGuobcd1pWHjMZKfZHcY29vi5Rubn2U0m98kJb2UJUBi5G1j88TkAb/yeXvs
	 bfyEjvsasA/YzTWaguS4fY/IHEZwK7wslkdmgDjS2OdtRGl04+Z0vINv7nD48xdi/a1el
	 VIkM0n/uz66lL4aV2eOp4jUAkxkCnAdQN+EnSi+s8FlkkwEl7piDjmtJiAByLXzB6GgPI
	 Nm4Vs0xG/TaYXt0TuZWwBiHA5JQIxirkKLoUpUUVcL7fVgyo7XGm4sExhXZbZBpLftg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkkTCsu8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C7606A331
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkkTCsu8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D6E1F000C6;
	Sun, 15 Nov 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774824;
	bh=05Y2U91mOodaWL3NHp7DqvU0BVrCPa7XinWGj3l6V7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkkTCsu89/xJAKHtdXNxnAGAertykmBin5lL9xTaIROqDPsY4v5Y1wFtgUbKYTgwM
	 0mkxqAse/gb16+NiHyBuQf0SROl59sbqGzKdgGMTZlSzGJrog/UKqfPSp0Ooz3+3oo
	 g71mMRAN/WrUMk6ooHoWtoydkvS9FwPHQ+cExObZPycvGJZy5HMZY7x0HbL17qnl+h
	 FWqKPm3cGD9c0MrJSPxIpmU6VT27QfGn02xXR7SDcsUmq37RnkpQRtKPk1Z8+5CAnA
	 vIuLF9IpLiNclTPdMI7VhsHmuGfg45KuD8XSAewr8P1xOvytcBF3Pi1a2jtW5IL6Pp
	 WAginVTV8nzrw==
Message-ID: <sashiko-outbox-215835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 25/27] Docs/mm/damon/design: update for user report
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-26-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-26-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:33:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly aded user_report type data
> attribute reports.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D25

