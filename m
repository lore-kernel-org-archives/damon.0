Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A847ECD7
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270367; cv=none; b=uXgWocb+HKlofPbNJTnu1p/VuhgfSBODwv2NZw0sBTtHRN7l2FscWPUltLqWFN4OdrRNa7R98+lJE3U7lp1r0BG+ktqAkbqKMLd1llM+gq9HB++10oMGlEeDmUTtBjDqZ8ZADPaxP64INB8q5Hop0s4gi9eEz+OUfh73HeA5lC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270367; c=relaxed/simple;
	bh=eOgaaR/Bmx7bNwh2aCz4CCJ+PVgVL/xyUp6j6oh3jos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WGzGMI2G6WjxoNZzk8jHqHnhscdV96axlU6+Wb5tJsaU5IqaXqxsFbmnXzWSXe9iKsLq01CVEblUuSJ4FdoYCUBuKU/n8zRKbXmEjwlvpY2zw6FoqzK3X5g4dUROiNdQjobmUKTm8knl35BOv2DJ/6HfvNtPFBuXt9NDevp711Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdZ7z8Jo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdZ7z8Jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8872D1F000E9;
	Tue,  1 Sep 2026 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270365;
	bh=WVfc6+TFdtcjc0LYedJlt36gQIshRq0DlX5/GAQo3PU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EdZ7z8JoyYxM7htSdoAogv6Yn/rRFGAF3tQAU/NiHWo5OsB4dMNeziQ8AYT/6PHs4
	 p2bt90eu3zG6kBfd/s9WSZjcPIVSmJ7Sr16hLhxCbpY/N8kQAw8dvreS7dbYWnCVTX
	 z7NTzMy8DvigVt6jE9zX/+su2fX/o9F1H+E5ZUNj1u8LGoKh5b0P9ESOb799Yaai7T
	 3FPgrwXRPsN8gG69lypYDqst+/xFxOAXeWfQ1rFYM4TOflLzXg++YBI2VV6LH3Q39Y
	 5jM2ZaaNRvwHf2K1FStlRUbaxnlDNrmvHwqbN09DXwxjs2juDgiRNi9dPZVEFUeXyQ
	 bBdKiPxrrzekQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 12/17] mm/damon/sysfs: implement prep_action file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-13-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:46:05 +0000
Message-Id: <20260901134605.8872D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add a file named prep_action under the prep directory.  It represents
> the corresponding probe preparation action.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D12

