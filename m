Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327504BFE73
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039423; cv=none; b=PlRleo5Du9BTqMoYERan1kTObh2TfiPeTOU0KsSZiwSyW0LxITQsD643NSSHgESbs/hWMsfn05rCqWLkhc/NP36dvZCu4hYTd14ImcCnnJ9vajQkQTDvJSIcpmHKc+YE9R4n2E9a4K9cKfq2J2HOsMX4BUVXdxy2ZRwZ7ibpwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039423; c=relaxed/simple;
	bh=pikWPDqfA81cpbJXhc7A2Qhx4miuLdgWcfaVCbnfdP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hIbVKEjttW2pdGQ+n6AjGsWmrK9O+4yc2ip0m/g7erUcTbXVhurigLWybCbD842gTswUzGu7EWcF0b3QB2VXh9qJg2/1R3kz+pFWuytvn7f60Pwj39OEXdyCefwOLFj3R8fNy3WVem153nuIetGs1LkzBy8pg2wk6cXFy1/mxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQZLEszk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQZLEszk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3881F000FF;
	Thu, 10 Sep 2026 11:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039421;
	bh=RFFcNXAzaWNJcK4tHdqxM6M1Ete2prsQD1X+54kzx8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQZLEszksTx0XRFW5YctVNJOwdrv+F+rKdIeOImN6+FudYe9kispdlIeRLy6jXhYu
	 i+ZmV2coYDS2CpFARLgZLceAfd4Bg2q899y1rNsOM6cfYY4rorFuAk5AbrC9wx/+Zn
	 mkxmTVHXktVVzpsgqAVAfWsLTDF1IViuNzNBLzLqxm0f3VqBxvMCDqK6E95xUMTSgV
	 BmduAUw/jfnpRoM8F8SXyGAQkHu1l2cKUz1uOOIfCA1G66GbntkNwKptaG2/KzGYtb
	 96pA18tY7d9a/IV5YEDP26bUvCqdyORId1nYg6IYFTJfUWfkYvh4ZySX0hKo+THIuB
	 0e5wWqJQb1apA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910112255.157012-1-aethernet65535@gmail.com>
References: <20260910112255.157012-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:23:41 +0000
Message-Id: <20260910112341.7A3881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> qt_exceeds counts how many times a scheme's quota has been exceeded.
>=20
> When using the temporal auto-tuning algorithm, the effective size quota
> becomes zero once the goal is [over-]achieved.  In this case, the quotas
> are still set, so qt_exceeds keeps increasing once per quota reset
> interval while the goal stays achieved.
>=20
> Clarify this behavior in the design document.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910112255.1570=
12-1-aethernet65535@gmail.com?part=3D1

