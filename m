Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774841;
	b=wEDBXfqeggiYBlj1XQdWkTbqlps8V8dLFQsIsQTPWg8ZMWHsFyGF6R/yRL86cvlIQpAh
	 /6UakRnXa81/1GHtKfiNzdZnBkB61PwwZPpKmug3OudT2VaEA/B7AU7+kLV+PSi3ddPpB
	 vTWgeT5tm9c8z70ROP2YVCVLVXPxjrmSseftGWbgdd8c8u5MvZ2BzrHSh9fTgV2yLVEQE
	 N3wsr0R5x/AFzzefiYjMseYMUcu7x1URm+a0IrsoR3diBpx+W3HitykPcpr/xTo1v5tG1
	 UKrnVr5RYroY/GLnS2BtZ+Uy98FwyLurxcFrriLxEOwFK10X+nCxHv8PUtl/nxEGqTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=97WTfpEVtLdDMH4MsbdWo2MlRK3lycVaF6jF2oNWBjo=;
	b=wJDAryX+j8EJF+YH/YXowPEacDQEIWONd9FtGOQPrOFLX5lyOKv+1irXcxZDUX+72unZ
	 22OhWYj/pgupdpCodZH2tCfpOtzXpFrjfCa7rYFJ2/6T+sczsirzmeHQ9ASU8v3lUmHhK
	 T887i49TdMBWvmOsk/ea22Yp3ABNAnyBnrUfBIP0IkquVHGiMWe4mxvtnrTH8MzUBgoCC
	 4RXVW4K5Sgc5q1m802eZoAGD3HBmtlmRxj5ntGKvROur17NkzVyI347Q91o+QqLQ4v+c3
	 yb+tA2VIc03CiHO91RVzBs9v5PbXKBaHxQ/4AiWbSKnZw8sr9wqVLX7Nq9cwE9lU5JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EmZ3S/sH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D8606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmZ3S/sH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652981F000C4;
	Sun, 15 Nov 2026 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774840;
	bh=97WTfpEVtLdDMH4MsbdWo2MlRK3lycVaF6jF2oNWBjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EmZ3S/sHXZ84J9gDREnI+/QTcKORyozBX56ok/pnDS7Dbgx4MrYGZ2W+sqMf5SyIA
	 NaC1ZqaBGXWVguL7+GRMDLf4veIWVSTdmqlyfPTmEJF/ioqLvg5fN0KQ6Tb2kzDxIe
	 UGMJE4QpzuVL+XkJ0iHRQKyUONGYMs7yzUUqQgj4AmC+x+E+zyvREI8318E4evrjUu
	 UIwpFtIL9CJvcw87+Xi7/8UsewNeGeGauMJedCh8T9HbuUXVh1l+/G8KDFXT9+8wfJ
	 eJBNCCXyfWYj1dHw0KIvkbhuD82rLsS3/b8V9HDkWqpV9M9peO7m47snxXiVNh89NC
	 SsoTeHYcCuCuA==
Message-ID: <sashiko-outbox-215836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 20/27] mm/damon/api: introduce user_report report
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-21-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-21-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:33:59 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Users could know some data attribute information and willing to provide
> that to DAMON.  Introduce a new damon_report_type,
> DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D20

