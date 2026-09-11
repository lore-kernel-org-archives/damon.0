Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6636492A
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135816; cv=none; b=kg8eADsbBoOiEDHCAGE+PnjSWU7qLEWrIB1sGkcOU7yQgCjwFmy8/schOtI8POLEDMhnnspptfEuDE2k+Jt6w8bOOtTRG9ZAUzyXkFrXZntIc/eovnj8bgSKV1w1bI2JwI4YFhK2xjwocYEWTyGGOxSEUCA9f4sy/erBeoMbx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135816; c=relaxed/simple;
	bh=L2et6z65/rQOi5mCGVWWJVPGG/n4XuD7zeky+jdp/x4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxIOPxptOhfEWnUMMG41rcnLY85PcwWl7576yUqy4i2dGI8s3isTc2CxdgKP2WhvdssOYMdjTs1j4DBjYZ4dceS7ICvl2sMTCfwtI3Kez7nEwUa9pnQI25nK8/kiuDtXqFmTFqIvPI/RvvF5c2bYlSxR8slVrPziAc+hasOxQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk8abT8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk8abT8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0D71F0089D;
	Fri, 11 Sep 2026 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135814;
	bh=/uDd2JUJQ0X+ka0WHb798XHy+hmOF6l5N2QPyB1yzOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kk8abT8ElmfSJQyVwDQhllc35wTIemEzDrdDVyLtM8T1U7q4viCnXjlWmRt5VfGpI
	 7FEtDeAlFOar+fKFPjSvAtIb5Jlr2ArVMXMFkhJIiM3raHP9sdQXtxQWswP8J5VOea
	 GRYXRo6XuD0vtuLROaLw64wXVvnM4RKW8Z21waOZDZkQrpSUOaahstRT2xKHgRCcum
	 rtioeDBvA05thXMSPaMkZCDW9YlbfoAUzAWfALS1ZpAFuZOLqToeh790YxcvgyEMW2
	 0J+XtI8geAMg4TrVgmSZukmkYwnHEOyO00eZm9Ubzj+wWmoVzjp+hQzr4NFyce5CoF
	 sdCp11tt25X6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] mm/damon/sysfs-schemes: rename
 sysfs_filter->sz_range to range_{min,max}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-5-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:10:13 +0000
Message-Id: <20260911141014.1F0D71F0089D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D4

