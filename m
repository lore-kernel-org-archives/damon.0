Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB83A4F4A
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013320; cv=none; b=kMOUJK7YmZ4czO5Z83qXWGhlJLktyHI5+0Rih/ZfdQR9JCeuDZuQO4Mr/+NdO4sMhtF+XtiJaFTKPsoUNHNFFf2yRmNzlUDRkDzO5HOmYwr1Z23Pt+bII+5F1H5JhCI1Ao7hBgm/hq7QBX3KE7KbvIqMPXO5YXqd8t4yunuKX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013320; c=relaxed/simple;
	bh=PWX6zsRnQUnJVRfzfLTZSCfT/KdxFh0FG7UnAs4RdZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KmAMJ9YPNznyM1J6hIT/BQgJl3lrz0hozhLXx0nitVNLGAZpwwCe4P7r73llnrjqgZ0Wl2dJ+jnguGKP9fdmQyrZ9VzZt7rrhLZC2H2D1OcLtJpr7+jwJYiCpWXHcIOM9xvp/LYh7iYhuo0PreSyRFbWgg/LFOXEVFASGgvAVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0hBdTX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0hBdTX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C41F000FF;
	Thu, 10 Sep 2026 04:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013312;
	bh=Q4uAnLOG/h4DB4rBDH8E1W/xTtbn2cvuF6VtCjWHFsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0hBdTX+xKMwXS/KGxMdnhzTca7FmsS5AGrjWfE+Gg+XH1kfr17J4SEoj3GQ5L6WY
	 i/FwVKnf3SWYzqPFgW4ZpKjQDxZXqrPXc/ypBeu1KTiiA+Osbufx6mmmWR3zP3blBv
	 UAxc1KLsrEEMvAJEU3UEEDCajhmWrSQXWsPkNrGNuORmJdWuSwK7xBVS+4rD36QS0H
	 i5Ze0t24R+XSX9Wif5b8V/CbQ50a+wd0KZLgdsC5YhHzBJg2XWWkL3T7w6ZC4Zzpqa
	 /MyjJ82ZIBewsf2C4pbGaThSW0oKXZa6f2JlI0B2Hfi9xHETS4JKLRijPSWzpLErUH
	 N5a63hBaXYJMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 2/7] mm/damon/core: extend probe_hits_wsum()
 for moving sum based calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-3-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:08:31 +0000
Message-Id: <20260910040831.D44C41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_probe_hits_wsum() is being called only in aggregation time.  In
> future, it could also be used by DAMOS.  In this case, since DAMOS uses
> its own apply_interval, it could be called in sampling time.  Then using
> the not yet fully aggregated probe_hits could result in suboptimum
> outcomes.  Extend damon_probe_hits_wsum() to get the weighted sum based
> on moving sum to prepare the DAMOS usage.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D2

