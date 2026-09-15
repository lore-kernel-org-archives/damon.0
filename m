Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462203AA1B2
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438524; cv=none; b=dfhiuXFjv8JaOST0QRhoo1s+YRwh0OY0fz78J7stbnKeeSMEASPYrIBEWwmy1H0jkEZNZXWHpxaWQGWmBnw175a8lnphdVAe0amDUsv+N/rRGknpBzwW9Cpvt8Zy/crUo1zSzpYa9N9MiHiYkOmym4sV8umfUrRvdyMIGrcJ+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438524; c=relaxed/simple;
	bh=ruvy4mFFd/9MbHXtgFGMUj/a0w66FHSH5Ue7+NTVz+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uq79XvLBvm/Z72un+thvZfoD558gyYZzROwYBP8aeiaGj5digKa/jRXGcupitRTV/+Uz9n4e2psrenvndw7ut3ByAtz0cXgaXFRikzfb2GFfYEGzuTmdxcOuX+ZCve2LEISzsi2rlmJqfuTjM2yTkzZB08jEInrd6az/ixAW4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLKY81p7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLKY81p7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409BF1F000FF;
	Tue, 15 Sep 2026 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438523;
	bh=qkqMZm0ePz0wuJbMzYBrmRi+tpDV2GLVh/dIxZ0wIMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLKY81p7Sdcln2FO4NfEe4PoRO4Uth1ZBXyLaSNq4dcVb877Nll/KLM6iF+X3BGiX
	 ee6ZRqmwHOuRXEYMeK8s9MeQsIozkHSUg1jK3aGI0sXjqBfrFdLDrh/tO/PUgFjoO4
	 sKH+dgxUKmVTk0pvRl06KDoS0JYep9elUyzb1Eq8m6XxUzquADATD2M5niXwYE3NE3
	 3/7VoBOmKEmtMZZHnTO2os/vAcUrZrWfuKrXMetISaveuJUCdcZG2QLrrIk6Adx994
	 UGbp4Lri4NnlfpV2IRPRV89PAz3wCze8K1rPdw/h4OAPPs0THSfOTp74pFxCF157Vc
	 8E3qdMKt9GVaw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/8] mm/damon/api: introduce
 DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-2-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:15:21 +0000
Message-Id: <20260915021522.409BF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Introduce a new data attribute probe filter type, hugepage_size.  It
> will work for memory that is backed by a hugepage of a given size range.
> Add a new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to
> identify the type.  Add two new fields in the damon_filter struct for
> saving the size range.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D1

