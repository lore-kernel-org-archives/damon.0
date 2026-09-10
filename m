Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6C3A5E97
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013746; cv=none; b=fEMzbgzCO4VISF9vStGz/RALXGgSUAkFxesod3QlgJ3U7xuz0dzKbXCdXa7nP4UqrtRZpecbLI4jSxuY2OiazrJDufEG6D7OZH4KaC/MJU1LCuYBy9oi6DhbE6QX/W5AhwnT1ay8vWYmr+cjCnorJO5bnpcBQ5eeVU54FwZ9m6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013746; c=relaxed/simple;
	bh=WJsltktL2HQIOKBQ56b2IALlKfUgzdQJJb0m865t3pc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDu3OeruttRMaFlWTnazOFze0jrBfYnpJ4hi6eJ3I1F+tc3pkzv1zg4/szKbKJXj9WUpQ0oaZsK/eKp6A0MlHcxK9e/d8tz9jqaSxldPaOCKB8dF05fnzrDUdUKzuMzhEAyXSWg9gSuFayYxchiBdAlT6pCxICbTYhxAwOXZngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hACfOLzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hACfOLzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6D71F000FF;
	Thu, 10 Sep 2026 04:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013742;
	bh=WJsltktL2HQIOKBQ56b2IALlKfUgzdQJJb0m865t3pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hACfOLzAIJhGjE8BUAzB9pAycenNGDc9kX6LobGBpWffmYftvkXqfyy1yBoUTO5vZ
	 2lbKCyD9ma4TyiTckkOTqc9RoBfb2wcxRSnfS3i1HcDJg5WMaUZriQkJzN4aJNAqMM
	 IyQ/XtzGXKpxlf4WvgjmT8kmZkNHNQu36n2jisyMm4sbXXkHrT+on8Pnj2zMmfQ0q+
	 MgqgdYzUP10sDhrbmvu1lLJUSTpkhGEOzGaIp6of2NLsdE4YysKKZWGwktpW2DPfys
	 Z3Nvrj7gtsm0kFvvEtuB9b9ieMkFNYYwuooXL9Pky0h3T0wwwwgIu213lbCBETeTDb
	 NnOArNVpeXLYA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 3/5] mm/damon/vaddr: support
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040911.148273-4-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
 <20260910040911.148273-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:15:41 +0000
Message-Id: <20260910041541.CA6D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the virtual address
> space DAMON operation set (vaddr).
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040911.1482=
73-1-sj@kernel.org?part=3D3

