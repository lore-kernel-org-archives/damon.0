Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968913;
	b=z3Yy7qvprmmyXSJK5FDhpPDfcnMm93slabEj/JoVPQ3dEOCUGy5scXZCagnuc4tKKjRZ
	 NtpKJoL9ls01dtudtjw6JY7VAJKwHwhj8xBuJDZomjrtAKFSC4fXsMpXX5+kSkWzCH8oH
	 HNSQsDwBzxEPSV5FK4HF7ofdLk/gQORM7oxkWwtplR+ynTes0wKbmyx8LyRb8FdwuwlVX
	 jAyMy0AdcHNg2bUhOM1T49QCCg1kjH0d8xbav9g+diEOQFitSVarJumScrSlUT4ZKApsd
	 xWxbhLnafikHuS9cXj76lexVR2mPmNw7ChsVD0zhItsETUDAAni1cQN2HhW+FaPMViw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dBVEpuAM28J+44L3RSo6zJZsDeJn6aQJ5oUdQHdwpS8=;
	b=5XiXj9ZpiD40C04jDGzwpBWQ44VVdusTq2ko7e3KNWlW0EeDHr5CFtIP3LCGu2IcYulH
	 aIOrNqmzfY8bOVwN9QwiSAr3zgXeOJ8Uk71CUmBoO4XS34vsYHU+eY9o/Zf8iEuh/v+e+
	 W4juoEoF+cOmf01S1YonHP3vqDKCcRXB8AOzMxBJ9euZ/AInC5dm+ryWvHdd90WxXqqmN
	 siyc1wJ5NFeLufcRQuMusT3PpEPu6LY+c12Iy9j7yKonK1Hou+0thLJmTmkel7BOYqxpw
	 i+1n0UIPLKCE9z0JfEpIL2mOLHfKmEvpKxaS249CiOkwk2xNQmkjVC7DcAaMh0K/mJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3tQEbtz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA00606A331
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3tQEbtz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235DF1F000C4;
	Wed, 18 Nov 2026 02:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968913;
	bh=dBVEpuAM28J+44L3RSo6zJZsDeJn6aQJ5oUdQHdwpS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3tQEbtznjtBX0/t5DqR5rk9V3FCgpyg/BHaXqZJORk6rTjMuZWgPkxAMLbQZPK6S
	 tjfA65Uc+F9cr0btvQ6LNL2tW99GjEUnZxhHRwLPgbf/nsIUeVHoWoAjZ9kqKoXhpp
	 TDMHM/RtCD5YhqviO0ZlJP8EHC6dxzcwGueKfqa8SLmdbDO5C4Ncuad+DCBA7tH1NW
	 hlDl3TVXt0xXDK+DEB/zNzbgNRlT4AS92Q1VeOgv+MhGLaO3My5PTN1qkLA3/T6C4Q
	 dimdGU5Z1b6eief98DHFOvKY5tKhjwQ3RRJejPczq5GKxZPdqLu7WYsJkie3BFYyiM
	 eG/W1Z2V/xjDA==
Message-ID: <sashiko-outbox-219954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 14/27] mm/damon/paddr: support REPORT_MADE type
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-15-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:28:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a support of DAMON_FILTER_TYPE_REPORT_MADE type probe filter to the
> physical address space operation set.  Use the DAMON core API function,
> damon_report_exist() for the core report search functionality.  Set the
> time range as the last sampling interval.  Pass damon_ctx to the filter
> matching function for getting the sampling interval.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D14

