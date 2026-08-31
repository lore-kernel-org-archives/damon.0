Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3835CBD6
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199563; cv=none; b=NMtSI3BYJ872LvX3Q7gVmvc+bFaSWD9bPkkZpm74k4UJe8z0FvBbw7vQxMo5MuOOLBhg/343pr1upn0Y47KJbkfIG+q6lzn+F83rN6JQD5dWHonVmbMsrwWo1nrhfqkDF3Ni72QhSmAUG/CXj0F1NRifIDAmQA9wJAZl+yExY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199563; c=relaxed/simple;
	bh=3zVcjw58ExeOHkzWSQa4m6FkL6vRF3BQgFLZSr85dds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQeav2vmeols1EppHhnDhOK1tr17Fv4EVDOr+7llOjNbp5/uvnxPpUaaYvWJNG0Lq0SxKOw4dCw2JdsnWRX7yPFliffvCRJWJTjnYs7VNZHJf3Oz21PyFwJ/k1BF2fu1ZBEXQ61OKIlEBHjfgj9tykRf2Gcf7bn/GQXc5EaNXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8sNwHlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8sNwHlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C371F000E9;
	Mon, 31 Aug 2026 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199562;
	bh=bMwKa6cbk/k6sR4tW0oEbCY7BFU2GPKkkbTe8FNKGN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8sNwHlOYS3CGrm0MQGj5ArwCr2fJtnjCxkURCVGHiVibJwWH907ko+0I2B2cSLo0
	 11GLsmUgoaLsgRiDF0zWMvL4xRRU5UbwNq/Bc9LysyuLdwSzhkcfneKZ7BwIwb0Mu+
	 p6nAPnYyvv5KDRp0OYA9jETrfm0VVyUetaLLCg9LriRJ9/Qr5cKHAlyrXxQEkFageV
	 pkbJtihem2r71Xh0hvq3c2u6VEU4HqS7ZSEPmf+dVBCyHolOsinKalZzf6jFoKfQtt
	 abnU1dvmG77vKxOgQh0fAjrGJA8hxoj+NCvsRGwCQ+ihWEyEdsA0gTw8KQLsDMHZkV
	 WT+AEBxPg9CmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] selftests/damon/sysfs.py: clean up sh processes
 used for obsolete_target test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-5-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:06:01 +0000
Message-Id: <20260831180601.D6C371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Hari Mishal <harimishal1@gmail.com>
>=20
> The obsolete_target test spawns three sh processes and uses their pids
> as DAMON monitoring targets.  These processes are never terminated or
> waited on, so they are left running (or become zombies) as orphaned
> children after the test program exits.
>=20
> Terminate each process and communicate() with it after the targets are
> no longer needed, so it exits and gets reaped instead of being leaked.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D4

