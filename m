Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5334D957E
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655132; cv=none; b=m4BcKMqDnY0Tgk3SbDorVFIyMFPMHwsjl9ebu+2ih1d2/Cq5ITqX+v3k70BUJGKl//L6reUAvkaEoFtLQJ3JBfjsptvogZybdpUNTswr6JOIeINnIm5wI6m5Zd7zYQeVcfs9FknFFyLdqxcp9p0tFphpOotrzWyeQHsuRRNNetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655132; c=relaxed/simple;
	bh=4sr6nAT/0rcxYb3JEJkZU3OKDTuka3GCjSbM2ztuk40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=blIbOzfhWeTlq7e+PLgNAOw0ExLAWPQ0YDo1++89q96froypgjXhymOgv9ZijUY80ISbaopu64ZtGPZuWdhGy3ruYKveuyY+p3KvTeC2g9mZQClL60HxbY773t2Je7K2DGfilyVn+Mw+CqLZvXxGrl+bNWCgRFR1q+Xpdqha/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPRVmhLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPRVmhLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75A01F000FF;
	Thu, 17 Sep 2026 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655130;
	bh=4sb1Z6DK9rhY2c9TUgKepqeMhd9WFQPTHU26c57f7dM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPRVmhLfbbFeMiJuYxL+PHDGDZtOU2+/hOMtZDHetEZpnvjQlGBccIlMQ9BwYtXDV
	 bqG/T6UQULGnLK29BjsKgBnGOJkRH/Vsqkxzs3Tjs3wVrT3EHf2u9rrpUjq8roVq57
	 lyIozapN+nScyDIL7LSCq8cVGX8G3BYWQs2yqw/CIkGW/Qxf3rkZ70h1H6SxlhGEIa
	 d9JZE2idAS19LVP/FXtGD7q6eWSNrp9S1z1k5kT16gyncha6ld9jhmL5s2e1jQQStr
	 TT56OfkEa4T9AwFvvLMpAbOsTGNcE6e4CUxy8Kz62o4ExMOiszuFXwe4xrLL88K3bD
	 EVDQ0zeuVMY6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-2-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:25:30 +0000
Message-Id: <20260917142530.B75A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D1

