Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5B2F3C18
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269801; cv=none; b=Qpw+n+jayINohPX0S+MoW+OaUeqbpdMKCuYo0FSy22eWhS+J26zUKBcqwXPwLQ2el5+3ZPbMWpDpSdc/VdHxkU7qUeEj/iryX39zGVV2GrapdNINsKXN2NKu0/nndSvp6HAdYIzK7xXESArEmzGsrjflRWgUI7DGA3u+VgUZVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269801; c=relaxed/simple;
	bh=yIuYsq2vWlVHj5PPPRC3DkB0Ojt3z+F5NK9kBcYzSOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AlgifNE2VH3Un4tYdX5McKQ+k0RGjBqwcVR2UoUx8+48Z74vtfsoQlzbHkBnXpw6NK8Unac+jQPfXU1Pzq8zFxqiSPhJdW4fvzaxkTtnz49KLN0XAGd1cUgWi/3/aRdim0KattVWg0NhoZjYABqXy+KGyWCPVe9kCFIkqp9QnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX/bw8PG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX/bw8PG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F106F1F000E9;
	Tue,  1 Sep 2026 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269800;
	bh=5Tra/ZlEnilb9XM8Hvl+p626b9MpOnH/fpQLUNJyEg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NX/bw8PGeptv8ai1PvGLqsMeeOFuKTB6AyZU4ZAH0N9NgEyuQG2rXkMXAEgzZRaiN
	 cPKEtgYUpbmLLAt6lE0CHxSu6udurNGiio7es/kDJe5wlcP47/N9zP5o8mABlxHtYk
	 aPW6EFSD5bz0SBch/lfGN7vjBxhgKJ3R1m4EcUFjvSjLdKaal3lqh8BYkm+fQeKG/9
	 IxyM7p8yFDY4FMnJ2l3PZC0yEk9Xfihfh2OVahbtdRFkQ4FRWZs9pnvHI5B53yCyF/
	 FwfM9O1d/Vq+PEWX8eQ2cmmfxwmbQk5861uFq4mNqZzPl4UwNrMWeM7LKzrVrEJMI1
	 UUmbbE2dIkOyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 06/17] mm/damon/core: commit preps
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-7-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:36:39 +0000
Message-Id: <20260901133639.F106F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_commit_probes() is ignoring damon_prep.  Commit the prep actions,
> too.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D6

