Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260A3FE64A;
	Tue, 24 Mar 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361745; cv=none; b=YWZtnZE4U/Igc+xwkAGcD9BMpH9r69K+xfh0+/UHo4D9e1lXkAhaCx9r+/zi4DZiwa0pDKDKUOebJs4Lnj2J2gNEBrO51YFFwzd8S9y6ZE7Vu4fIFPWxgRrGjqbmr/AMhZO7gtQN3oE3WoK/dH2VdZFZV0E+MEh9N4xqprKKHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361745; c=relaxed/simple;
	bh=rdNwTeZrJVIPFYcjbtTuAiqhCIJwk99EdUukTgho27E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdqhsAG/Rby8eZOVuE+mxqctLcO9kIUgx+i+KCZpSajpoT5zWDP9m+p7QRpjFeZcCevrf11Wj9m7Cff3xqI++xWezbPQ+1h3WYQylcj/Um2cvo08o4scl4VjmAot0NbcevyTm3OsyC2iiSzTCLfSqBhbDNAzuXqfpc889JplOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQdclUNF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQdclUNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874A0C19424;
	Tue, 24 Mar 2026 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774361744;
	bh=rdNwTeZrJVIPFYcjbtTuAiqhCIJwk99EdUukTgho27E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQdclUNFHffW5wwZjD+EMKJE50q8xQHVKyM1l83HbpGQq85u/WW1TmUgsAhwkLy3Y
	 wN4QvlE1cbPbpP/XdoINCviYRr/vT9utsjYQCLdnIZTL2h0TvklQtTfL9+pqNUHzD4
	 d06Jv68Ho8g7N9ujedjENGhJMPvBhtbQQZ/FyZU/3NmhG0glTnUkPaNKKdX+9N3nTp
	 xi6exbRRM+3UV3hWNNBsbk8NvGpHm1vTZMIVz7/hsdgJWSMMh9gNtmIh8ciYv8352+
	 NGEUkNodtOjhMtNAuieiovyon7/ogiNz7sXttL0NA2VjpcktfATimkMiQ1z3PzcvFn
	 Z3/p95wngBcZQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Tue, 24 Mar 2026 07:15:37 -0700
Message-ID: <20260324141537.91434-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <A0701CEF-CDF1-4B3E-B25A-C05A32AE822C@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 07:06:25 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 24 March 2026 00:14:59 GMT, SeongJae Park <sj@kernel.org> wrote:
> >On Mon, 23 Mar 2026 16:48:19 +0000 Josh Law <objecting@objecting.org> wrote:
> >[...]
> >> Also, unconnected to our topic!
> >> 
> >> 
> >> I've tried to backport Damon to 4.19 (for a personal android thing, and failed! Of course)
> >> 
> >> Can I have a bit of help if that's fine with you? The tree is based on GitHub a bit
> >
> >Sure, I will be happy to help as much as I can without burning myself ;)
> >
> >Seems [1] Alma Linux has backported DAMON on their 4.18 kernel.  Maybe you can
> >try their port first?
> >
> >Also, what is the oldest kernel that you have to use?  As newer it is, the
> >backporting will be easier.  When I was in AWS, I backported DAMON of v6.7 on
> >the v5.10 based Amazon Linux kernel, and the source is available on GitHub.  So
> >if you can use 5.10 based kernel, using that could also be a good option.
> >
> >[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON
> >
> >
> >Thanks,
> >SJ
> >
> >[...]
> 
> 
> 
> well android likes using old kernels for some reasons, especially LTS, so 4.19..

Well, but the long term support of 4.19 has dead a few years ago.  The oldest
LTS kernel of today is 5.10 [1].  I understand some vendors might still use
4.19 kernel, though.  Anyway, let me know if there is anything that I can help.
I will try to help.

[1] https://www.kernel.org/category/releases.html


Thanks,
SJ

[...]
