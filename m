Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622898;
	b=yXJvciNnji4mLuZlr+Fx05Ua1xJ24/MfmjgPn28Kh6l8ZRfP2oho9tYyFP5NTjxHEnfn
	 T23RJB2ALcYV/ezrk+j0SDERX5bFlISlrHnEcY4RAkdTH+6ohojK9zM+13VyBpGMrCxaf
	 0iqky3aGIwQEs3jw6Uh9NviygpKvKGe7D3xudRVOODikNgDHlFphMnvGRYshOuoxDW3RH
	 VJjoRvXNtDduiq0JrYnnC7scfOTLILZp7Y3dRBRh5lP82FwFi8CA8BN9U7t3CA9Z0ydhj
	 GgDYMeX6NNvbJ3FhyGeAZqaEU6DDlA5xXV/r9cMQ2iTIwg3G/TQryBjQZWrCz2f/bgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622898;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LNUYU7pXy4dPQv+n0/00gK7Iv0h5927fuy55p2uNzJs=;
	b=A692ALgNvFZJ9SRB94051tc9O6nug4yJFtG1eNFesulycKxaQm6JTxr256tI3BWtuLUI
	 jhV6IJMLC6GMKS3Rd1Yo55hfyZbOy3ZspftqHwV4TqNTN2xgnLwn3thDsLpQtkap4Ul/l
	 5l8BUU1ZquxHzCmmeJlRS+fDyquV0u2gNw7tJ9o42uewHp+aso3XvFSD9zcPNDne/Ar+z
	 DVgOe1GyJvjCjeLfREALmZSPQ3VxW8CNz787haM5xswO9pWQYbpXsbDNmC7ncfneKvHaA
	 W2W1J0s5ylEa/CPLahXYHWsS4Cxp19hBGYGBoLB45b5e8wjrNaEN9OHUo8MJ5nYfkcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYJWrpPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A91606A332;
	Sat, 14 Nov 2026 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYJWrpPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E971F000C4;
	Sat, 14 Nov 2026 02:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622898;
	bh=LNUYU7pXy4dPQv+n0/00gK7Iv0h5927fuy55p2uNzJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYJWrpPODuJU1uwQd2fjcZgTZsCwjPpp54gSH3BU2DooVZjdSeMQ+TaX6vAc7QKyJ
	 OcB8opfbkOMLLHlhNvIiMvSw2T8h+sKA1HgSI2RRtv4/L9vZgA3oNUBwpk0j9o9DqA
	 s/0qGLmpOYEYQH6gi8+4feU5axeZwyRNa6FIgGClPVZc5gExATbuy+rHI68qeR7Dac
	 jJTCL6t2INh2nPv2mD5UET5BH4DFfrPffdf9TujQfaza4FWM7rnVPHLi6OAycZD4dy
	 1Dk2gIPO/LggKZh2OLUjp36ufjRjV8R/JtpXr26ikib7vv9V6PGxCh9e6aHZy0C1oZ
	 QUiA27aa34MmQ==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon/tests: add KUnit coverage for age_ms filters
Date: Fri, 13 Nov 2026 18:21:30 -0800
Message-ID: <20261114022131.110196-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason,

On Fri, 13 Nov 2026 07:58:54 -0800 Jason Angelov <jasonangelov@ucla.edu> wrote:

> The DAMON core tests do not cover DAMOS_FILTER_TYPE_AGE_MS. Add tests for
> committing valid and invalid age ranges, identifying the filter as
> core-handled, and matching ages at and outside the range boundaries.
> 
> Region age is counted in aggregation intervals, but age_ms filter bounds
> are in milliseconds. The interval-change test checks age rescaling and
> filter matching after both increasing and decreasing the aggregation
> interval.

Thank you for this series.  I show only small nits in the first two patches.
But the third one looks a revisioning is needed.  Could you please address my
comments?


Thanks,
SJ

[...]
