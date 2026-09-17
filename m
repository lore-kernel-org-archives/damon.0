Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4024E4C6
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618421; cv=none; b=ZvQTVUR/TqlUxv+IE8JjjDNUFMWg9zC9pctSsXxV8rIIO6JZ7e/6jvGKayPnEqj0pWGki+7TyVz46eKgFXjbMUhW7C54eshczTxDMA3oyQIfRda9CXPMSjOks/5piqPCJKCaUJLQhBsXP6IEnZoplhFRVdN4wwjudNg8st75PRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618421; c=relaxed/simple;
	bh=Z5O2ZSmGJAW+nf6nGb0m/gG0vyjs8jaWUbSLNCFQCkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O6BQA7DI5hJxMDbUIj62KKUO0rdwfSZYQiDgbYHZsVcaewjjR6kHVf4YtmFccTrXFrQeK66QesS0JF+msl3yJwoeVvMWh3HqV5cxKMhW3TxFZn/1/Gp0LMH7r8iiyQKpVIqFCx1i8JPLU7lxZ8HQZWhXdVzwWj9vvwJRRt9NwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bySgDv6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bySgDv6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9007E1F00893;
	Thu, 17 Sep 2026 04:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618419;
	bh=1lXexOO/YxvrOi1V8eCeNiE5wpg17ZW7B7KjHXhBNNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bySgDv6uJYQBSXFl92ggLUu+yv6m8fZYW+ziYrqbI7u41288xJ3346SGOIW2RV6Bh
	 UY9jdRbDMgV98FeX8XhXceZQf28Xd06lcPupDgekhNGOxWfTHw+E2wa+ULKufZAAIC
	 i6wxzEx8w3/YwjSsC2GF7kwUA92YAWeLyZ8woPfpQNvE4Rl571ZUKw6zi0fAwufWL8
	 +n2Oooc3JXjmXxq4ZlvkyRr7uqzkonynVPqHyj+iuz+9T+ikDwxz0pS4uAsHtoa53Z
	 YaWB8FrxUuEcsgPi7DJNnCqTMIbSml7hyzDHomnP42LeQHWa4dsiwfmEiWx9FvBd0C
	 Af5jHvBfI65hw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/10] mm/damon/core: document
 damon_call()/damon_start() race hang issue
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917040537.107341-6-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
 <20260917040537.107341-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:13:39 +0000
Message-Id: <20260917041339.9007E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Let's suppose damon_start() and damon_call() are executed in parallel
> for the same DAMON context.  Then, damon_call() could show
> ctx->damon_calls_obsolete set while ctx->kdamond is unset.  If
> damon_start() sets ctx->kdamond before damon_call() starts the
> cancelling, damon_call() can indefinitely hang.  No DAMON API caller
> does such parallel execution of damon_start() and damon_call(), so the
> issue doesn't exist.  But who knows what will happen in future.  Add a
> clarification comment for caution.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040537.1073=
41-1-sj@kernel.org?part=3D5

