Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E036B93D
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729071; cv=none; b=cpqz5zwettz80NuNYLD62AYUKZLDq8aWRubo9pgg8e+NgfY0d7XiDtuCsREFsdCFDV5rAko8kkywmbdibRKFftY9YDfnJ3FmDdRGhMMPZfX9JRuBJ9nF57snwzmpI88Ae6rmARfM1ay3R3/jARzpnq44wCoZETrtUg5sxtPp/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729071; c=relaxed/simple;
	bh=dDVDHU1I8xjxvG79OowMA0TooqrmTo5jkW9YhCGr8Zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kGdFgJ9IWxbSAZNce+LNJ9zOkcdLJUxCHCIQuUUjHCAKAmGg5VNlbDLBlOLxc+QsU8snmRVBVDppvQork/fhqKAx21JD+SmHpbdy5Kc1uKTm0kqXyquD9iKMoRzdXx6/ErtViGpVPJZDx35xJR8fbs8A4O0bOXZXppRV9ZtHShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izs1U0V8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izs1U0V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138711F00A3A;
	Sun,  6 Sep 2026 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729070;
	bh=z0aL3o2PP0c3UchDYFdQ79CUt0pUgpr/OTh3F8BtbgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izs1U0V8CJ6VFmx5a61OrJRE9gUejWESns3tlkQBHKHdAIHncZWx7H2nWhXeg2QTP
	 C7HUIYytFiPdl15S3b9sKIHKYkHNCZJ5/pam2bxLo2DxW9KxYOHwA70S44q2dg6Mz3
	 cyGprk7hdOP65MVa8G6LkNfuNqQ/s9epRn4al/9a3LEnVGJmsz2J+Olk7YhgcFerNm
	 L80FETb1vt/MiCX1bp7IHAbWJk9I51DqDdo1wpybcjr9D0BQxPgXfSLQ1rRW6dwGzU
	 0Oj8Dmjb2EPtxWePkOloT0i4DmPGs1/4OqwLq6jHz+GVfpNpXVN4g6L0Ctg6qw3l0V
	 1iu90pOHCwjmA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] mm/damon/sysfs-schemes: rename
 sysfs_filter->sz_range to range_{min,max}
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906210513.106895-4-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
 <20260906210513.106895-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 21:11:09 +0000
Message-Id: <20260906211110.138711F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906210513.1068=
95-1-sj@kernel.org?part=3D3

