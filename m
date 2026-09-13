Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5636998A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320326; cv=none; b=sCZb70DSq0XP6vvDnAgkLESqJh0+oWCe0Q/j4WrogEwdHHfgTJj9MyBIhczmkUdeUQBZEJp2oniQAEOhzYJk0JBntnE9+r8azazGrjy0GpYwiJZH8RNtWgzQo8MQBG5muiBSWHNuv6JakZehQ2RNF5FvWSVM0e5ahqDP0TfTqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320326; c=relaxed/simple;
	bh=x7LPz93ODqvkmFIbMfq6qsNMXVfWu7J44sDQ+EDrTGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iq+1bbOF6OgM5utYQaUunmx7n1tYvVedhgAkNLmWgTeiAbBF5HhCkA0rAEyBNQQhBlE9LrvfZWCymjVg+b9WJE3uH3x3ESBN/w5IjnwvSXcjFlrt3zwyGZQSVjWnLBh+PXtuk6acb4E/Gkq7H4ovaLe5xf0yhJKDv0nxpIO7QZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnGKCzNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnGKCzNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAF71F000FF;
	Sun, 13 Sep 2026 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320324;
	bh=PJCSy/rcbkF4zTq/kql4XOg6zLLYyr+O4hO1EipZTHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnGKCzNsNFStYrf5j8WPKi6395QNTalhYqh0+h9JUgDr+5rYsN2lcAEN9NxMj86Ka
	 7OBgecQQ8vRKLIaTarp/JI55XSAOuqwjRr+OXHYB4kaFnjTuI5FiQKY9CGSRNMfkvu
	 v1bQnJ8ewOZnLkSbqqvbnvlOqQzvYZJOz239LZdxmXmmFfiSBx+Fzq2TuYkVPxXUkM
	 UkiFn+mhJhOj1M9tE0qUjzO7jMnqF6zf+dW3714EQwZzHxeULNb1WHc6lIpBCJg6e7
	 yRHJ2H4IfSoLmbcNbcB8pEy4oPnjj7neSWZfaol5vOC3q4i2kjdks4T24tJVUAFkZI
	 XKU2HM/a2zaog==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/8] mm/damon/core: return an error from
 damos_commit_filter_arg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-4-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:25:23 +0000
Message-Id: <20260913172524.5BAF71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_arg() is supposed to always succeed.  It may not in
> future, for example, if the given filter is invalid.  Prepare the case
> by modifying its signature to return an error when it failed.  Also pipe
> the return value to its callers and let them handle the error.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D3

