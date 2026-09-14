Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DE4718C6
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397859; cv=none; b=AO/mKcS3TOEyb+WkDfmJA7zmAo80xrZ3R8kWo620PHdoMfVKqXceYBkHSAYeLwlZp2CSmfx2fE3HRL/bIkKRq6TEVs04XJonPr4zMN2TN+cBUViwaVNWpulbLFNYrCXxDZINo8u9rYzad6VoaB7GNxvaEDG+ikHFndhAHffJWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397859; c=relaxed/simple;
	bh=DBRJizHYwAwwcWe39hltckz4ULGjYExJJIMdG4U6fS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ogr3aCYYy7yBe+jb+7FaaBRiactir0pn/3whY9ABGb8njKOjDSO5e8rNlsnHel3rXH2WbpzQirT8EcIkg08tP5n0S7UNI1JPjyGweuQ9nDvkWCfg/py+JY+w0AGQSAJugMfhzlfc8efXHUJH8tJOYEc7eFv5Z9iMk0JmOxe1Px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYeGLzXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYeGLzXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0B01F000FF;
	Mon, 14 Sep 2026 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397857;
	bh=sNsThkWaTVQPXO12qKNVu8ftbNF/GTcuvpTsJOGoOwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYeGLzXWQQx1nIeZ5ZwsZ/IDjddsDmqjqeZ67Q7/y8bXYn+LEVpTb9S9c5yz50JGX
	 vhinQUsS31SfKHoB+Y8Lr7QqyvscdJr67Z0z0mfnEtgM9D7bxvn1wKysIN0SRKcM00
	 Mkt2xtZX42YEUvQ+3Cs9P28HzzL+Szi1VMJyd7y6NO+UBoquB9ycxCDtIq6fsbtqKl
	 TMutQrsawRZyzIhWtxZ/K0uaCxOWN07d5FopQusg7M/Ab2vXgWk6lu34nJeNzUvwi3
	 5A0cLpZnmIoeVYa38dvcIvu+tteac+AWbfu6fS9C1t8EWnvjxC7wYdUmzjNnMY2uj9
	 v3LuKwPl7PB1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] mm/damon/sysfs-schemes: read sysfs_filter->sz_range
 only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-3-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:57:37 +0000
Message-Id: <20260914145737.8B0B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface reads the user-provided size range arguments for
> hugepage_size type DAMOS filter twice.  Once for validation, and once
> again for assignments to the variable that will be passed to the core
> layer.  If the user updates the arguments in parallel, an invalid size
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid size range is not really invalid.  It just
> works as having a weird size range.  No critical issues such as a crash
> or a leak could happen.  And sane users ain't do such parallel arguments
> update anyway.  If they do, such racy behavior is arguably somewhat
> expected and deserved.  That said, there is no reason to keep such
> races.
>=20
> Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos=
_filter->sz_range")
> Cc: <stable@vger.kernel.org> # 6.15.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D2

