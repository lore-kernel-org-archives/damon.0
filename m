Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506B2E413
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398116; cv=none; b=iZHJReZEV/mRrFTw98qY7XiHIOanU2WyEiawLUU9pEMqNgph+w3nHDMouQTgd1uUyqxqOjf5n5g/cVOJXZu3LIcc8MJE5pwAASj65KvNRHflPibVZojgwlfwoNCoTSMvt1dzHZXeC3GI7JJn2x2ifcHkC2YQ32xkK36sCBSW8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398116; c=relaxed/simple;
	bh=W2NivFKmbn96YIVD19Sa/v1rUwOBgAZoq/p1BfESmVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHyfGi10u0UQYRMTCB4QxV9WtJMvyLcsxyatLb4agz5T/Guo93zmFT1+MKbthK3eCTulvSINBKCWTKbo2jPsnWrCh5xttGX9JpPa7Rb1Gbg4Y42+Ta/I7W0pufnkTkDzSDEE3OZg2eS0zPtA+8bBVL7CqE/1VTrR+Gr3Ev0h3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecdbbr7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecdbbr7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC41F000E9;
	Thu,  3 Sep 2026 01:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398114;
	bh=0QKKqf4ZEec+0hMehQy9yagjzP6rPy00TWq3VwiKUqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecdbbr7dx0NVgd1GVNQx6HpnxSjS3ot2zRjCRwOEX0YO6R/z66kaqCRkhof9/pFSv
	 BsqS/DdfM6OpoGWjd0H6UUiezCVNCCPpZV+IXLm0c0HiabnTQcRY9G6K2jY5AwLYla
	 aHrSHGYnG+ixw1fURtJilPP03F3F/ng5GGpi60EnRKeN9cgWvEWxfO4dkHTTMnjZfr
	 QRl3TpDIR5/iiZBQ206AkbOEAcOMGf0x7Xc6N6wk6khyLVYg0JgXZ4XBkyOkCS30wm
	 up291Rt2a+8aJiBMUaS0ilEniBrYsOmWO8mDmflAES1l1eSQ+luUcb+QRPAWrYVLs1
	 G3WXJIlJzcUaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] mm/damon/core: handle NULL ctx parameter in
 damon_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010334.93622-2-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
 <20260903010334.93622-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:15:13 +0000
Message-Id: <20260903011514.2AEC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When NULL damon_ctx pointer parameter is passed, damon_call() could do
> NULL dereference.  The caller is responsible to avoid that.  It is easy
> to forget, and there are many damon_call() callers.  Meanwhile,
> damon_call() is never meant to be performance critical.  It uses mutex
> and completion.  Add the NULL pointer check inside damon_call() so that
> callers can pass the parameter without NULL checks.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010334.9362=
2-1-sj@kernel.org?part=3D1

