Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457033;
	b=bLyXV8qE1eoCl/6Sr0GgWjxcKQuOkvqWsUBVe6DgvxSh5gj5pffuHYHtYpset61ezc0x
	 aU5WzbKdkNUF7xXH5U0ouEp0Vn1jf9v0fRlT424IEMw33iyejDwqJ9aFKJ4ebZakNuZjm
	 vchs5kgZdaX+jsw0xsrx7hyZ3UH4TXa3kfnaQp1HJjmdRaAqRmzQa4EtUcDB5HnhJ1n7r
	 WzYiBrI9kgsN21kvOtVnnj8WlhWmsM8otT4R9sBsCdKI9dclGOZnNpTar4eQRbU9cjPFc
	 ydVP6CzvYqPRg8yYud8K6G/L99iOHZfOvxXox/Nt/i8iotwO7akidicwSq1INNi+jgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oGyDIK5rdrER74aX0XxP0tN5lqLfzpieYyIynIXcrfU=;
	b=dTe8gZZRddO1eorSQAXgCUF6sOPHQW9RzGGHy7G9bajaz7FmS6IRCm6FzngLQUYj4UP1
	 +x0JvDSCcFXt5wF7V2qxYgr30qQ0rna1kUUSwu2nzloQn/tTchn6PkyZtUQoWQ0E9allo
	 2yigOpi6dVzJ+zLktSlk2bDw4DD99c6bynxfhMUbPLkbqKieNqWT9C4eXlUzgoAFfUxiy
	 9Egzw+IkfwICR0UOOoDinfyZR2y26DGpd2UxQ4kuFAPSLvET8fkEpaHYHhxZ4QvGBRAa1
	 1AWofkcr/ab7bONok6env4oh7TLQ348hzdn8wZ/IDp95ZENOc2pu/loExW7/vrwAJiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtujFuUG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5C606A31C
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtujFuUG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12851F000C4;
	Tue, 20 Oct 2026 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792457032;
	bh=oGyDIK5rdrER74aX0XxP0tN5lqLfzpieYyIynIXcrfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PtujFuUGek48l1bUlVqxFg+OsZvDnl6Xbu63rX0Py96D0tOTkJC0VosJfXp7eoQiW
	 5GtMUHUwGQRKzbU/H+ZvhGcZlY4BUaCFAzzwxPMFR0ITtxu0cnpVSd5rTtT4PlneFn
	 rSjz5A3ueyhZvToB4Za+wroZ/ei26rVU3EYchqsV2xi9GL2+5eN4vHk2UMJvXvhmWB
	 ikV3ImmhL7wP2xCP0vmdv9FESQv/0JI4msXcPuXbngmDFV0+kpgkhqcuuwsgf6sFrs
	 a0kyl7BpDlEeRW4CzybvKGyH9sgyfYZA2JtDHzDO6sB/UdqlmqRY42FwwTkWtHIfN8
	 hmOre//XZEAcQ==
Message-ID: <sashiko-outbox-178392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: filter out damos address filter-split
 failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261020004119.106690-1-sj@kernel.org>
References: <20261020004119.106690-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 00:43:52 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When an address type DAMOS filter is configured, DAMOS tries to split
> the region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash
> or leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that
> the user has excluded via address filter could be a surprise depending
> on the use case.  It is only theoretical.  No such real case is found
> yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> [1] https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org
>=20
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020004119.1066=
90-1-sj@kernel.org?part=3D1

