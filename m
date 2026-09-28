Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C948C8B9
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588415; cv=none; b=ur1HpmM6CAWH5KyNEEnLOdtIpWnF3p6MDDirB6En5MPmRjPtNaDOde9lgW3MP66y20xA4ezJS9P5T87lrLM3K/H6BlZC7hnEeKWCm0y0lHnvWxfAUKHFqYEgsZKWn/ES5SEhi9d5Pj9+DCgF2GOC+YJ71gBA1xNbcAnmFvrYldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588415; c=relaxed/simple;
	bh=JdYQLG8ZHiM2RR5fsjMW1++owujUJMNucZwSBRtMlGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6qVSxQBljcL9xlJS+ABurCXNyffO6orqzcZFyembIivCqSrXNtTtwOvOJATeZ/WF5780iFUHXB0BypLex2cdDNUBWUU8Iys87UFhQo2L8wCl3qKA6mHcxsMbtJSqsd5T8fCUWI2PWHbhN1OE5Nt22mXEAIQ0m5phnwkmRt0wF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwq5vr9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwq5vr9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC841F000FF;
	Mon, 28 Sep 2026 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588413;
	bh=uGqz7cV4rqFYREP6oA5HsJvTEuA2zIxvDjzdCCpglDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rwq5vr9u3+neE550zC0Vatd8yIWgYZKAzqPwlCpHTRWGEETwU0av+9u16ejy9NdyC
	 hhn08Odv9M8Zxsj0vPstJqYWD6UHUaywGmxiNFMjfoBSgoeX1lSuwvKxlSvL4SB1N6
	 C0FP8gEh9sQKcgIXYStUQQ+xTe02jOLZTL7x6l4UrsjWop5CuUVCL4jGLoPOqwO2zQ
	 fK9CnHnJtS8vrbsI6J0VmKy9hwSNR1iAfsTibLLb6yqXKJEJascxnxdO4S1Ki9H87q
	 vEigymWINGxRag65yvo9A++1mRoCOBCrE3kVGya2PK5d0oG7OtINDqi2nC1J/aqw5B
	 LpySZiuUYTt5w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 3/8] mm/damon/sysfs-schemes: support quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-4-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:40:12 +0000
Message-Id: <20260928094013.5AC841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add a new sysfs file, complement, under the quota goal directory.  It
> works for setting and getting the quota goal metric complement flag
> value.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D3

