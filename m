Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4835E1A4
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243823; cv=none; b=V74iz9GFXmHUrkz1oI7h4fE6UyyV0quvUCKYPK4bn+F49/WtLHLavhjO100HtoRCbKAbpwpsxqj6CdG+2yWNt59a0BvAaGp/1vEwOOngTRr+In33Arp43YzJWkK0KS/Curdlw8T+9yXlqhxwZZzSgQB2L95aTY8VPKa0r8vZ5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243823; c=relaxed/simple;
	bh=QFqwvluKXpgWEyvga8mC2aNuMrMyeDs0HKF1BaiCCEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ATfElho6xNzUl8OyHwPsoQnFvc+HnMl/cN1wVDByNI5DDJUOd5pbvgoGsHMEfBEz3xte+JLFV6Wnb1CGMrZ7hIXbN2I2ayujsArex0WRzVDjI4vTo6Conz/BXYFzUeW//OhIfMWmoHDwdO1UQ6QABm0k2A+AFMG6E8DQjrFI+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpBl/Ye4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpBl/Ye4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB391F000FF;
	Sat, 12 Sep 2026 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243822;
	bh=RpD0FaMWdZqTE6okv9+SuWVaKQ/NN9Y4V4qwZv0/vjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpBl/Ye4qEygXohWnblwNTR4x9AY1KQogvsOFKO1e5gRS3e0mULKTVOsraHc7+MOb
	 uc+y7rkZoqxLZ8yw/j2/BlTNnvzHqumA1ZhsrzsSxeHb5XFOxOcdixQJLo45lwSrG0
	 g58484anOTzXvrxtPU/3Ytw/TMHvcRy3eMLrBKB0mwiXn2Xy6frSRqmtZM5KEEHmId
	 DWQZTpvaLCU0Gm8B/4Ko2Fbl0PT3o2hhrZyUAA5eu0dDkDh2zjSlngsOfCY6rPiWGs
	 Wz08dUQ3Ii4aQwU5/O2h+V7kT6Y53GRnvLSEEU5BMxn5T3JBedGmzrjeBR/n08CMZT
	 UfTPqujQJ5gVQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-2-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:10:21 +0000
Message-Id: <20260912201022.6AB391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D1

