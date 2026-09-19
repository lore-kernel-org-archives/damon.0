Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C723B7B7D
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780602; cv=none; b=Xa60RJF/SQrz4PDhpIqZSQBE54ez1mTgtoSdu4jgmCx0O5v3c59sTlyFNKMbKX/DkJwrqEABoPyZYJ3pgVs4yScXjE0NRMlAVfuMFQ/7dWdaqFQjsN1OZlQ668H9qd3WHDk5pBU3yPvvJWisSMMHZmymp14QqXKz5yalouirv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780602; c=relaxed/simple;
	bh=+RVgVquv3gPSJwCnHzsJcGVt5Y6yTfA77H5hEkWtG6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DMj7R13bdLkt/xivQ51c1fRtPvZaSvs1eOaKWINZb+5rQpkOIv63CzzqvS5HxGKo/rygez0OWD2mYjT4o9BnxTe7cSPQIQ5DpKMQPOrMuk9vYfw3NgxSnA7YfWsPOJO2AbXlGXPUb2lgMWWEmtWOUMzznyc6qYqOq5651t1AygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ievbM3P2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ievbM3P2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413851F000FF;
	Sat, 19 Sep 2026 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780589;
	bh=+RVgVquv3gPSJwCnHzsJcGVt5Y6yTfA77H5hEkWtG6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ievbM3P2UQS4DNktgr6fayocsz3+DD7J5qzB35zeT8ss0xFiUUGEDa3EfGPKi/yYA
	 +wPCkWEciRRYwbAkSSrEc4QuSrDHq0+YJNFJS/O0IbwPUH1su3s95UVXwTCAF2sfFr
	 tqc56E+DUL8rSWEnelN4AhW/wADr2KryKTgcLRzk/VUZfW90V/GHPEsj853YlxahWO
	 kiCDn2MAy8rEO6cm+37Yx5HHuR16fGrnp3H+JMjLHmypEwdBqbF98QYpb/ZFi+gVmf
	 S0CzvqoMfA9MFyadJCzxEuOpao3Cr42b5gN122Njx6hC9Ib5wtrVjRgovwRDeBx8eu
	 u5UUEFtGUaSaw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/7] Docs/mm/damon/design: document damos quota
 goal complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-6-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:16:28 +0000
Message-Id: <20260919011629.413851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added damos quota goal metric
> value complement flag.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D5

