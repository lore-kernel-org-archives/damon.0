Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827036923F
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013691; cv=none; b=sc3dSpPE/KDT7x09n/ctZxp2mY3kBDM++qCEe/0mZPRyA62nbsc6gtslyU+oa0XHQdqbzEsa8MKPMrxPZRvF1V4sFkOefjE0RuBE6nQ5KcT1HldDMCEaV9fa0jZutug9jVVhvpaDkKeWP7jWBNEXBY6BFQhCUJkOI66KQDptcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013691; c=relaxed/simple;
	bh=WrlHdGk3+k7ZcXA4t4afVE9RUBC2yvlO1VX9jy5rfUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wf0/NbQZm89x1LQoc8oTQ9tgX/eOTBOIqgckVF/02e103B22RRahonWl+YuvEjid7cOOitPCN2M2sa+0GoCNW3wX+zkQQiNnswWh73gbGG70V3Z7BS+BFEP8xm3dLWROrt/rk6gfb6xuoIToKKYpwJD5aBAjkwx0XgkzEHzv5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brBYS0PT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brBYS0PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EDE1F000FF;
	Thu, 10 Sep 2026 04:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013689;
	bh=UA8Vzl1fSVGkKnD3+WKVXfBqHGpj0HFK0BV84G4myp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brBYS0PTG0DAM1cdV3Oh35Oy3q8w4iaEWB04aFPuSIF5lE7v/grXdaBkoDqAKcVou
	 w9YUCKuJUJikFZYPMIcJ/pXxnbZ4EvDkMthaDXB9ednHM9zlYUCQDKcumBsSb6kRp6
	 ozWNkMZkybDkwgUc+OnUN9PwjY6vrVmh9tOC4nKG4WovI/vjeZ0/XBJx0mOW+ToCoB
	 lQjNNXHL7wY2CUcDCnJk6Y5697FpIPM3hFMtmGIZlwI5v5qEfJp8TcpOTa/SnxD9C2
	 pfMxx9DJPzsuak36/lDNrnZM6E230aqYYuIjwB13S5gl68fWTi70LYlcEy4E4qq05d
	 AjiHcu7/h4ccA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 4/7] mm/damon/sysfs-schemes: rename
 sysfs_filter->sz_range to range_{min,max}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040319.147037-5-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
 <20260910040319.147037-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:14:49 +0000
Message-Id: <20260910041449.89EDE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface provides 'min' and 'max' files under the DAMOS
> filter directory.  The purpose is setting the general range arguments
> for hugepage_size like filters that require range arguments.  So far,
> hugepage_size was the only filter using it.  Hence sz_range field of
> damon_sysfs_scheme_filter struct was connected to the files.
>=20
> In future, we could add a new filter that can reuse the 'min' and 'max'
> files.  And the filter might use a range of a type that is not size. For
> example, probe_hits weighted sum.  In this case, simply reusing the
> sz_range field would make it a little confusing.  Rename sz_range to
> range_{min,max} to avoid such confusion.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040319.1470=
37-1-sj@kernel.org?part=3D4

