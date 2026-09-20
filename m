Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C43EBF23;
	Sun, 20 Sep 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789900859; cv=none; b=C9sIIbg/Lr28ikyVPbjDHr0KWzecwZqrAFGzead3IDcrU9Hz1BYkXiXSPWahe+dPMCL0j/nK+LHi0WKlcia2dtA3Eyu2bnFuEIKbnAD72f3b5izZscd7cCI4OuS/4t6r5CAFVadkhMa2XhVCzBTpXZwx/xNmsRdIxPuBnABrglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789900859; c=relaxed/simple;
	bh=zGgJ/GlRVZAYOpzSr2M6hk6XDxwJfQjCV4uzdyE/4jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug23SXqytE2pR4zpXvpUQWBSPBMm6WXLv9czguoUlB0VG1MMdPK8gwX2RyZK2NXAwxiU04g5PrbNKppnXRMbZ1wKQtILgNEpYbCGo62rFcYBoC92HlpXtHuBifBJOPy01QnBRYk9DjAiI425tcJzWbqbLTGJ+hwu20Gy6LrrNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl5ily5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl5ily5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339241F000FF;
	Sun, 20 Sep 2026 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789900857;
	bh=P0ar35JML3hYV9nkiEE/sXJ/W+HUlMH5GL/lIbPR8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jl5ily5Aits8qB1RPjNZHY6eIAr2FKO13WiN7n7BSp55opoujuaUt6nQdZyBQjsgY
	 our3hlC2LQUi7IHtRYByRJ6uACgKrW1nHX2Fb6ecqfTBYdOQttJv/mzJ0ioSKLbDHr
	 2evp68xCIuwALXS6zfVxcvhNs87rZEhcip2mvbC+KoERGKU4nLIbaFKNcXqz+0M+UF
	 l6M4E+U57XAN/2wLC4MkKlfBRihYBRClUnMXHBLGwUKjh4MjRX0vPRmVgUY4+OeFwI
	 gviArGiBD03hz0AC2pQi4xBOBh1bafQ0KlON4wut3plIh82Miq+nN3sc7moimQ2VI8
	 wMaU0p0JWvxoQ==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sun, 20 Sep 2026 03:40:53 -0700
Message-ID: <20260920104054.47877-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920023111.2466265-3-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 11:31:10 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis points,

Please wrap commit message lines with 72 columns limit.

> so the conversion is exact only up to ULONG_MAX / 10000.  Pin the three
> sizes around that boundary: the largest one that fits, the first one that
> does not, and ULONG_MAX.
> 
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Other than the above column limit,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
