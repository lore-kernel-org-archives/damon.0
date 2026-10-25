Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947106;
	b=bLnSjeBMdRXw5cP68NZUdk9O2KVzjATmnNg1gh8EKikeXmRRARR3HHa2mnf05nOA4KIo
	 6I/rUNhzFqkroKZi3qHTLuRU/08ZvLHCvgHXujdsgiYyHneK9wtLiCmKWjLyZeg6lMbOq
	 tYODIA+zYVcwVRXGBW0c0IHzZfMgqnA2jMggkSjhLUD1psO1agiuLq2rodKpFGQ/JspUB
	 umE/+6Fq5a5D7BLDgnQpwenGfhHdqKc1GeTH6OagQ9iTJPBUELZU+z0l+glAUztYCQ4l4
	 N4EU5sS/KV6UP8hV5FPUt4jp2nquj3KNIg5gjJDnXzLCO8D3MlCtpAU3AUWYc2nk3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947106;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0xRdnLEs6BKf0jDGVVvju7nJQnRlrobErBRi9vch9pY=;
	b=S08fe8xXwtRTUwOBomJIdK/eSUIcXAjKFECAzuRGKtAo7E92gsiQtgc1BsObbY//1lO3
	 zMghSClo6bYORqzDgRMQihSVPFIXXeZpOAzVjRPHDPSdjar6o8BE1uwIgG235xjyixbdG
	 /itFzrA8TdjWoauFNvGakcPBFwJSbI7hHJIdC/vS0NUcIyRfet1XDQgFa261ywcxkK0Pu
	 b3hGFlUanRZbA/NCqDoYo+O3gGh3gSkDuI0MTLF3agmfvQtZYrFzK5ThEP1nfXDpm61Dz
	 REvOExzMDdwTcfnTvTtLcyhAWPNuR4uJhonnj37F91oGGHMEbd8q1rKrFv8XvvNyMvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIU7VYEF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B7606A326
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIU7VYEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C28F1F01828;
	Sun, 25 Oct 2026 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792947105;
	bh=0xRdnLEs6BKf0jDGVVvju7nJQnRlrobErBRi9vch9pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIU7VYEFydFg+KStGUPiCmew5x5P6vAuxKIEiVOYnl92m/YH7PwnYtlW3OVEY0xf8
	 TAgGY78Tg/PdH7XLRY7ePnFahQzXdIqJ+CN+I/hbkMCHx4RW8Mqy6aImwTt87tCLq/
	 jK8/y09p6ha/OmENcJNoRbC7S8pkK9kCEJRqn+yRmlDlJQv4CJjrzG8xIqg2sdPPDx
	 /zLjSWZ6JAMT9KqHJtbF5b+mGmRd+EtsL5qJmPcLzKKalK94zACIh9vKOTy9Xt1xgp
	 3XBxvl+FEg1QZmiqJ3jSebQy/c9TLsM3IxiBN/DvFxXzkFb1o2HmHvZcWw+cwyTB3M
	 +Uu5aRgHHu9mA==
Message-ID: <sashiko-outbox-184282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm/damon/core: move static variable rotation to
 damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261025164808.152048-4-sj@kernel.org>
References: <20261025164808.152048-1-sj@kernel.org>
 <20261025164808.152048-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 16:51:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_split_some_reigons() uses a static variable, rotation, to remember
> how many times it was called.  It is again used to determine fair
> selection of regions to split.  Since it is a static variable, it can be
> indeterministic and therefore less fair.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort and indeterministic monitoring accuracy could be slightly
> more indeterministic when multiple kdamonds are used in parallel.
>=20
> Fix the problem by moving the static variable into the damon_ctx struct.
>=20
> Fixes: 1a582e6e0174 ("mm/damon/core: split a fraction of regions when nr_=
regions exceeds max/2")
> Cc: <stable@vger.kernel.org> # 7.3.x
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025164808.1520=
48-1-sj@kernel.org?part=3D3

