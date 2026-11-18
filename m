Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968804;
	b=3GkFeQuopplX65RBqGoUQYz6SlGC5yPnxYHX4qrsOjyTu9srMoni41v0IQ3O17g/1YEs
	 lf6viWaj6vfjl8dkXgtAsnstPqPXNl7NHBpDQ0zPsDtiWk98bKmpVKWdom/EJxSOxO+FL
	 o5lX07TQYcHEkvIihqgXvElDpC0JNKAl1BJehQThChaGli6B+PORGVomcxehN5+A0RuZU
	 4u1BFtakpyP7ihetS5tVckan66xqreTyvLdOKAurANfz8tW0OL24QrZYdaI4sNIfFB0k/
	 iww3O21UFHvyVIJDLeGOA0N2GJ6fUIJ9Lqn43dZC6sct4+JO8fWMTC4/BW6rhGr4zSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TgxzRL488UpkIiF2GvBXrGL4x0fNZx6jyuDFWNtKvKU=;
	b=x6W1EXrWzLDinnK3DeMKKpwGdhTonrkc1kH8yMe/xMrbGZz3qw5iQnJ8VvS348cMMxvx
	 BI4KaTIKlaTj+KRCs0waVqUh8fXqfS18MLd6/bmpblk0F+WQA+3/IDwUHwwd7Fztk+m0i
	 GG1coEfWDTrYD5K47SrU36v67gu7FnpalToLmMhSthneiNHlkZk0SkwFgvAeglolF6bBB
	 YnwGlSDHPtNKHxRAtZ7MbBNmqH8CvL7ImMHrqPmVYXSt89sTEXAzARK5Dlj6GKj1hvHvV
	 BkVRHKA4aP1nxPU0ejxioHvkeBRecx92ZXhqU9amsjmsLwgBEc8wih8OTsVy2s+jl8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPSNCwYy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF8606A32F
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPSNCwYy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A51F000C5;
	Wed, 18 Nov 2026 02:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968804;
	bh=TgxzRL488UpkIiF2GvBXrGL4x0fNZx6jyuDFWNtKvKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPSNCwYy9tLSdwBUveiq6gRdi6gXhXl9GHKSUFoXE4pyOgs1jGOaAxCiptWMJeZWd
	 2Mw4jcStCJXllcB9vTgQG78+h4kHUfrc4UGwlQOFUUrw2yjZvX0LGHq3VnFRPtieng
	 9SqF6Hrvu87+kGiqLVIS/O2J35HDJKOzVzXU7/8Lv4BA1KxKRvIEfRGWPshMivhwcN
	 Bmwb/hY8HFlcCbiduXajsb1MlYv/xUmDAIuaDXOOl/WeM4EArxKmNAXesqxTaqIMLH
	 CMk0VntHhzMm66rVtCxEqYO/9XxmquV3dxWHyGm8Ya9kyqEOk5yFYC9gf5LOYI1r4K
	 bWjVKZJ8uoxuw==
Message-ID: <sashiko-outbox-219944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/27] mm/damon/sysfs: add admin/reports/
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-5-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:26:43 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a new sysfs directory, reports/, as a place holder for sysfs files
> that will be used for controlling the data attribute report system.  Put
> the directory under the admin/ directory, next to kdamonds/ directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D4

