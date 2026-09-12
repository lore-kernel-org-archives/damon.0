Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CE3C1D73
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243937; cv=none; b=lOIbMZeYyebl24p9LjWtthjkIvRKgCQMmzh1Cz3ythKgCVP2tJIIcLvzeJbJ+FsnLaMt/QdP8qKWPNK6rjZ07MXt38pOp0JnKXPgLT602UrlZMqRms6MVNg//8KpnZ1zKVAclQhuZ+aLmQ7wBuxeQncXJlfaJj2SiRhkrzmORDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243937; c=relaxed/simple;
	bh=3X8e+p7MzLToZgq2cME154O2BjLTU94m3WxB/mkdLD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pui/2P2MgY0WfT4W9gVEoawtGsvqNImXAmlXqC37saL34HFqLz2osI3nUtLBwz1sgsahaDXXkH/UIizjDF/wPpOvaf03qsGFpMtFWeATEmqqyAkVraTmGI3dRXc1IW8m20siTMTZAdJqA3B8gwc5XOGqBuPy5ijEeHbRD6I3sP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+kIM/WK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+kIM/WK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C0F1F000FF;
	Sat, 12 Sep 2026 20:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243935;
	bh=n8DvxG4HmxW+XjibadJ8gRlwr9sBLKLaQwRy+7ofNtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+kIM/WK6ApXdde5Ig2HN54pWfQVVjjCw1hwoxsxKFS+oMv+h+U7cA6W3L9l7PsQ/
	 i12L092RJ3s1kdLbwLpmHKlibutp6Jfs143i0984/7VnLP3yRM5e2NaAp/h5qtUT6l
	 KMxq2NjmP3iDGUoD9/VySCBMaSFw+HZitFiiHD9GLl8iCLQVPJjOv2T7lVS0ukqOzH
	 HJvK6MsjswMiuwaCzUjcGVmcK6XUBYNJpd8Zlcb1Kc9sqDvKVak1rTBXiXJf3w4ZuG
	 6dpNzHpFVqPWptV65J2udMKnsVqDNH8nQIJoCV0P7+Y0ckmCP3p774zwUPBcPdlvwZ
	 Vz3FEhBYVrlWQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/9] mm/damon/core: use mult_frac() in
 damon_feed_loop_next_input()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-4-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:12:14 +0000
Message-Id: <20260912201215.61C0F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_feed_loop_next_input() does its best effort overflow protection.
> score_goal_diff is always smaller than goal (10,000).  Hence the
> calculation can be replaced to use mult_frac() without concerning the
> overflow.  Use mult_frac().
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D3

