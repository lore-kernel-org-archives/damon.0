Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968835;
	b=19aVajYdouUX8xJSj0t7gqGgp1bGjcUuHiTJfczuQUa6Qw3DcpaSvRxjnwD9uuAIgkaI
	 QXc9br+sTnBOoa7F17n9fn6JIEFo6POBn26wrdRFmYOv3rLfkUMKB8mPOxVUb1a/Rqf6D
	 WFOnUouHd4JXxdffxUr0YyzgJpYvhhIGCH+4w9wz/rw7hczWEenIp/l554LrxGAi9isyi
	 HrzG82PZ5dtaPPgq5FxnbYgbNy02yZQccVhlquvJcK9NBab/gR4wk0XJk04iddd1kwV+q
	 3ri0hoRPBj/Jw6puWflfMXkkeEILw1CBrDaVuuukuKPJwGvuiUvmpCrl0a+ritFOwZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TFoDMo0yyALz7rOzExxwojm7Y2qW/n9+Uwd4vXMblmw=;
	b=KGt4VJ7hgXqWKeo/mMRLHeBZt0LQTV5o3kEnchtAwzSb3xFw8zw2A/1WLZRXaSZqdJaK
	 NdZZvg/kUbRSSZ5+og6gakQS2Co3KX9v4H1f2USjaXlDWF4aOkJpxjx0IBu/gtnz/3KXU
	 yPIo64TlzXQZLe3ND9QqkxCDWVsFzacT5/TibJhFc4vY/0peRURx0dH6zvwZazCyofF/H
	 /Ew7bH35yUwFXGpKi6yzqPjGFAxU00q7XNrYZMN2r9d2J+IzyxM0kgJio5AdWkza5Ggzd
	 BvkuR+2y4eT7mpSIoojIBcYEpNF+ATHOBO17dEycosQE6d1f/vo1fHEQCWvqfl+4L8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7uYk31d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A1606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7uYk31d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01601F000C4;
	Wed, 18 Nov 2026 02:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968835;
	bh=TFoDMo0yyALz7rOzExxwojm7Y2qW/n9+Uwd4vXMblmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7uYk31dnXSkunMtIzPbfNOkCnknGFUsaOkZOHEHt/FXfqEi8dZM9hUyGcCPyFRAf
	 gKmmTKOw/27V9QjdwS894/5r61FKuQcAoZgbzU6gCFqNY8emUWn6jjoRULYwJcPcU/
	 +0FnMbrJhmjsSr2J9vpKxTtCk5oz0+X5mSIpIK9/p3vUkUAxre9OIYJwpuiYkDhHzD
	 DL8zs373sh4ZfpxBB4/js0ktIuJdQSgVhZ+XUqoWO/AGupl57gDArDn6gV25CFK2mR
	 uJE/bw0GSmNCtq19ivwP6SwRE/DKEgkSQn93uneMSznwJ/pWTYieioRpVDaWvkLw51
	 4Ca0mXGMg342A==
Message-ID: <sashiko-outbox-219945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/27] mm/damon/sysfs: add producers/nr_producers
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-7-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:27:14 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement a new sysfs file, nr_producers, under the producers/
> directory.  The file will be used for generating directories for each
> report producer, in a manner that is similar to the nr_kdamonds file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D6

