Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942101E7660
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279914; cv=none; b=Naj92R+trzTjALb4n6uYgvR/nxEltwyySsAbOiWGdFBgcgJtShbVLfeCpuKKxCqF08B7N2S568cDUGzhm40TPbNTFgLMrXj0b85byzGgmkO43u2wE2aP44Hkm/zTUTA9Qcjea9SQpFMS6a6Vqx1YQhXXIpCECstym/yUq/glDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279914; c=relaxed/simple;
	bh=nnowgGbE46uUV/cr18YAPiUOXHG5foExtYJUvvI8O74=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QQuIgw7s/4L/2OKmyRMZzsSEwQlUXxM/xzF/jVwPYP7YkomZCbXy9NbeAGqWaZ8eLB8MDBWdfN7HKKkp+wJoYU3UYQEcn3PTGYfYZHZsuYL1Y9sF4Pro2wqsM6m97vKFvZd6lk+836d4+L1CPErAyGWF/ohh7JMmlyPswSwz4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bJgPJaPR; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bJgPJaPR"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780279910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yA/QFrCtPoX5wPIQZTccJ9pEjaemUdXNIzLEOb9zuBk=;
	b=bJgPJaPRzvdonnMsZ4dpFUWP9OLxY+c8G+lanO2reQL+tLTEmhRxizTgnW6WnfqjghcwTp
	8M0xmyVSfdACXogiyGGfbhUHphhbpsJX/hlBgDr7tob/B99FQ2oIjWrf1hZQ3kPWEAkn+I
	T8geubSrHZAE/8vN+xvMLhJLHYOoXKg=
Date: Mon, 01 Jun 2026 02:11:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <2b9ae12de845ad1c7070c797ed1214602e548db9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/5] selftests/damon: prevent cross-context state
 pollution in DamonCtx
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, shuah@kernel.org, damon@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Kunwu Chan" <kunwu.chan@gmail.com>, "Wang Lian"
 <lianux.mm@gmail.com>, "Kunwu Chan" <chentao@kylinos.cn>
In-Reply-To: <20260531163050.98908-1-sj@kernel.org>
References: <20260531163050.98908-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

June 1, 2026 at 12:30 AM, "SeongJae Park" <sj@kernel.org mailto:sj@kernel=
.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:


>=20
>=20On Sun, 31 May 2026 17:17:20 +0800 Kunwu Chan <kunwu.chan@linux.dev> =
wrote:
>=20
>=20>=20
>=20> From: Kunwu Chan <kunwu.chan@gmail.com>
> >=20=20
>=20>  DamonCtx.__init__() uses mutable default values for
> >  monitoring_attrs, targets, and schemes. In Python these are
> >  evaluated once at function definition time, so multiple
> >  DamonCtx instances can unintentionally share the same lists
> >  and DamonAttrs instance.
> >=20=20
>=20>  Replace the mutable defaults with None sentinels and
> >  initialize the objects when needed.
> >=20
>=20Nice change, thank you!
>
Thanks, SJ.
=20
>=20>=20
>=20> Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> >  Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> >  Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> >=20
>=20checkpatch.pl complains as below:
>=20
>=20WARNING: From:/Signed-off-by: email address mismatch: 'From: Kunwu Ch=
an <kunwu.chan@gmail.com>' !=3D 'Signed-off-by: Kunwu Chan <chentao@kylin=
os.cn>'
>=20
>=20Other than that,
>=20
>=20Reviewed-by: SeongJae Park <sj@kernel.org>
>=20

I'll=20fix the email mismatch and send a v2 to make the addresses consist=
ent.

I'll also add your Reviewed-by tag.

Thanks,=20
Kunwu

>=20Thanks,
> SJ
>=20
>=20[...]
>
