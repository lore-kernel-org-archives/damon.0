Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F83612DB
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473480; cv=none; b=p0XZ/Y2QIhy2gC1l+H6bLuUazjKBav1SzvBYCgTQfSDZoIy2idd2b2A3lGa0lA4pl6o8b/Tgz79o2VGwPJbc1cw+y9UPcVRQ2EKtiocZ4MZ87DyecKuh+yXnj+iU/49PkK1Xyq8JSNE4uoFUCoF4aJgPZ5BF6OwGaWM+8ZGAzxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473480; c=relaxed/simple;
	bh=7o+eE9fCS62EBHnfMiBb6WbqasmZoJCyuZzprLSdVjU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PzLNZ7bTs4NRPfYE2yBaOFzWhz7MOL7C7ai8xB7ZuHYmwwGS1r0HJHWXkRbpoKhjQYcTURGh7eloj/pS09tm5SWv1bbQ0W6m9Zx+nJvxbCryP1NJ64NkEe5Picc3iDdgZI2DgSMSLzxkifDAOLaAgXC44v7DLW9d3tcr+vET1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC9BUbIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC9BUbIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F0D1F000FF;
	Thu,  8 Oct 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473479;
	bh=7o+eE9fCS62EBHnfMiBb6WbqasmZoJCyuZzprLSdVjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cC9BUbICZXSTHTPQZhGZtBhupQwPnMltKRnXpyQNaIGiYzkkAvlHXpEgOhUk9Rtm+
	 3ju0IABNY/DP6IfPj8QQwtVObRkZqqKxQcjTPyP0Nxo/80ztSCt1K4jO4NAJWG8eue
	 FBHvIO28fZ86TplsQTuxOWXeSOFguYpkebAZsQIiJeBc0eysn9NveRImlyfzk0Zztu
	 Vw+SKzYHvtovn6bckiyo9AygRos7SNkMuJb4nYeguz/JgO2E75UwDvohDhzB8InzCn
	 PQP/0ccn+aYv4BNndDrXuzIpoO5san6pS+uPN3cK9gRQkF1iW6nItKIFPrixLMyCUX
	 QvEQShuGGVEGA==
Message-ID: <sashiko-outbox-164345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: Use only installed probe in
 damon_merge_two_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261008151944.113714-2-suhaas@s-joshi.in>
References: <20261008151944.113714-1-suhaas@s-joshi.in>
 <20261008151944.113714-2-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 15:31:18 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. However, it is
> possible that we have fewer probes installed than DAMON_MAX_PROBES. In su=
ch
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
>=20
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.
>=20
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008151944.1137=
14-2-suhaas@s-joshi.in?part=3D1

