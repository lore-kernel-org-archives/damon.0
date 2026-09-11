Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1153321A7
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135550; cv=none; b=c3GCzFOMv89MuzSOMZIriyylRsrft05c91Yr8gVnv+nX4b7/E8ZhlmJMUdZiEb4Ne4IELcqjPRsC4oDB0vukZriSkvMDICbw6ix0Q90DkKD5jNLW1Xdj7KTaGUmO3jEh7TXmK46cWqwIGLzRRA/0WU362cXwv8WtmwmitJKO5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135550; c=relaxed/simple;
	bh=c4Rt5fLs8IOfUx9/hM6A5p9P75VPleUziJPTITb307A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a69mYVK1oNldDvPojYu3deLr4Y2qHRUwHnzO0SbnjbBPAYuZ7OWz4YrjqnBBcfVwKfdh+8uJXYZAzmExZ9VUFEnrb4lgR1yWxs7YY4E4coN8LsWd5juxR29GRo2h71gbt71bpqDqhN2Z9CayVDNhDTcINfbVKGukVnWGjRsFWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU5l3KLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU5l3KLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E73E1F000FF;
	Fri, 11 Sep 2026 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135547;
	bh=LGA5H7dIiMcxk8/GKpCXLLeJYOr/AgnSk9Uhhimd3Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YU5l3KLyctxcbj8w3OULJJpU5kRjYoeK0yz8eLzfcBycGaJ6qPQmtV4Afo8GrfliT
	 ZZJqT/dfYS0dPfMZvZbTHAaNMvP7tANCw+RXouIgqN0agC6fiu5InDbmROZLd9ItRO
	 /YBdID4Z4YYZcfHmdDI6yCcLJ4QyPNuGrfylTZR1qu8+UFyd1460XToWUbXpFrRm9h
	 VnFK3mnGgIxdiV6vWGQrNcMq7fD1NO+xRJ8QAHlwYOobRaZ4yaGOXD4WX/To4TXs8y
	 RQdMFpfHfwtZcEJG4ntf67bjR1+VPEi3vJLVmxV4PNnKPMLXwZq8fRuwSXc5O+VF9F
	 sZ0NfMN58UwwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] mm/damon/core: support probe_hits_wsum damos
 core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-4-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:05:46 +0000
Message-Id: <20260911140547.3E73E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement probe_hits_wsum DAMOS core filter support in the core layer.
> Make three small changes for the support.  First, update
> damos_filter_for_ops() to treat probe_hits_wsum filter as core filter.
> Second, Update destination damos_filter->range_{min,max} for
> probe_hits_wsum type damos filter commits.  Third, extend
> damos_filter_match() to handle probe_hits_wsum type filter. Calculate
> the weighted sum of the given region and compare it with the given
> filter's target weighted sum range.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D3

