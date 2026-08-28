Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED62BE03C
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942938; cv=none; b=taA3w45USD/MUETR5dqUKenMZPXzTcPuN+HGXtCEgVEY6LZrnmSN3z7mzSaXS2ZcAus75O14YOzBSeuLoAhv6qB3kit+T0Y8fHyDcxuWzF5A6W9XRNT+/Gp1y45sVp0475a7dzRJGjK7UOjcRnKRTpI7w8kx1nqYmqeUh6ZQN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942938; c=relaxed/simple;
	bh=wc6gVxFOGEqzcJSaUblGuPKBplb8W7J8fJif/DXciwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r3V+egKhOIWBXmKhkEb0gm32KIVKvHbfNpEP2svtLT33hFATFE2YVqOmRds/R5G7bf7c8vTyNZD8Dz8+FQrx3LUv+QgS5hLuNU9uurGB6kxIXn8r74RfMUHD+gSia9DFImd/wz7Aa4yxAukUYCn6tOZpSfbDOcgSy57aHJoX2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuRt+j6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuRt+j6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA111F00A3D;
	Fri, 28 Aug 2026 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942937;
	bh=ISs8rKIzDOFKrWHig7PK9gk9B9spWFZACBX0oRB34ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuRt+j6nmYdekRzH+KcrzSofKEmT8rySa8FNnHgLYomWkns1aw3DeTJaFc+Hhor5J
	 rNEnb2iak4M9G7j30oUBNEEGLHp+LWY0tMpofDparcznvzBAJazxJndcAcvy8SdOGh
	 k5iC47bav44VONSUySaSAsYCUnJLIsi84mSggBLElcyduG10lZ3Isv+I3pNjt6NGOc
	 kxNeCCpsS0PqSSA4898JrXp+Ej83VWTwJ4SXNLte7qjxxcdSuTJq1U3HPUPOBp/dbl
	 euwOOgnfw0dhf9X81cINPfmIDmDCjefZJhDl1HNfq2wriQwmwXHdEDk49+dIdTZn4y
	 XahrfC4ZnYM5g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 4/4] mm/damon/sysfs: set next refresh jiffies
 per sysfs context
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828183649.71192-5-sj@kernel.org>
References: <20260828183649.71192-1-sj@kernel.org>
 <20260828183649.71192-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:48:56 +0000
Message-Id: <20260828184856.DAA111F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
>=20
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug and can easily be reproduced.
>=20
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a glo=
bal variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828183649.7119=
2-1-sj@kernel.org?part=3D4

