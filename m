Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883359;
	b=d52JXaix97hW56nC0m4+77anL7D4Ltrr+EHIR+aRlvcSdvKcPri1ZVLypFhLbjL/ZXDy
	 bsXZNhjvu+P8auMX3h3710suyd9IftkZbiNvrYQZWwrXY50f1UAUJR8k14pYEoQy8LFkJ
	 b6rXLcH02vybioO4PaEO2z8YTtoatS7uGvszYy5rgQ7O3negxiPL+sAYY+D+wA4F2jgKa
	 6bUlk0w/O9DB6/aiJfyL1+ti4V13lO2+VgrtK2oFc/6ytnCk1U5uptUVJWkOrcLg1XDlT
	 NohXY0+EFUP/kJagMKErY1HxkUaX9YqfTHPVoDt52dLbYyUWfWuSwJPtU29HvG3Qj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CV/8yQe2iMIuyGyk1G/Q/QXie74bXsaHYJKwVGXVxoc=;
	b=qTritq5hYPkyLVQxoBsCi8lTrTjbL2yXeMLUl3eSv7gN/jQHp0GTmWl2yMmqpj8mqezj
	 DSQJoVreplbdaCAhTisUSzc7Bv7vp8+B9LnfNNbB62PbXLO9O/2traUbTFkOQY+Ls4LXk
	 ElMuVdMZxr56g9o4J+YakdwY1x1gK6AeTWh2urqBUXw492bfftlDKiNIsREyi9CsMyLPQ
	 nFRZjH9DNHAc4pBXHZ2KaWHWkf1eBMx+152sRbesZVw6wZA3PtpxsDbgBSuiR2lctUV7t
	 0gGhZg7g1udcbHoaPUpwXUE704T7dIDz76fWrVqpvLRs+efyFPbv1WRiI3yG6Zktbag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOB5Wdz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E5606A31C;
	Tue, 17 Nov 2026 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOB5Wdz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C115E1F000C6;
	Tue, 17 Nov 2026 02:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794883359;
	bh=CV/8yQe2iMIuyGyk1G/Q/QXie74bXsaHYJKwVGXVxoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YOB5Wdz9H1jgHIcXmTMbNCpa7DHT2t6ztkS13qf8w1JHlrggkQ6+xUM+9g9p2akeC
	 ZbS3uzAb+yDQUc73pxgdy+3cQ5rBZfKaP834GbR5Jwzhut7BzfiNCH4EGJGLf+9Ndv
	 o4MMnFDITh3Wbv7U0qifeQW6hWs9ovjP02qGOImwwiT0kkSmpLmVkQQnHVKBeC0a/v
	 fZnrGVBTA37azhKsPz/f1uS852hkZGmgaG4hPjg11i+OdX/mFMJ+7GEj51Y2T+32xP
	 Lpk5iEI+s/hSJdBu4TwwRPzn2EYvWi8tDDUvtEdewEOfI9UqLd/sRWzjKwRYD8IxBJ
	 +XWZLPk7CqOTw==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH 0/6] mm/damon: add sz_ops_filter_passed_last DAMOS stat
Date: Mon, 16 Nov 2026 18:42:31 -0800
Message-ID: <20261117024231.113721-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
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

Hello Mattathias,

On Mon, 16 Nov 2026 19:10:03 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> DAMOS stat sz_ops_filter_passed shows the total bytes that passed
> operations layer-handled DAMOS filters, accumulated from the beginning
> of the scheme's execution.  Users who want the amount for only the
> latest apply interval, e.g., the size of a workload's anonymous memory
> that is cold as of now, have to keep the previous value in user space
> and compute the difference.  To know how many apply intervals a
> difference covers, they have to rely on nr_snapshots.  But nr_snapshots
> is increased once per target per apply interval, so the computation is
> complicated for contexts having multiple targets.
> 
> This series introduces a new DAMOS stat, sz_ops_filter_passed_last.  It
> shows the amount of sz_ops_filter_passed increase in the last apply
> interval of the scheme.  It is updated at the end of each apply
> interval, and kept unchanged until the next apply interval is
> completed.  Like the other DAMOS stats, it is exposed under the stats/
> directory of the scheme in the DAMON sysfs interface, and refreshed
> together with the other stats when refresh_ms expires or
> update_schemes_stats is written.

Thank you for this series!

> 
> Patches sequence
> ================
> 
> Patch 1 introduces the stat to the DAMON core.  Patch 2 exposes it via
> the DAMON sysfs interface.  Patch 3 adds a kunit test.  Patches 4-6
> update the design, usage, and ABI documents, respectively.

I left a few comments.  Maybe patch 3 needs a change that might deserve
respinning.  Could you please address all the comments?

> 
> Tests
> =====
[...]
> Tool use
> ========
> 
> Claude (Anthropic) assisted with the code, kunit test, documents, and
> changelogs of this series, as noted by the Assisted-by: tags.  I
> reviewed all of it and ran the tests listed above.

Knowing what tests are already passed and what tool is used is helpful for
reviewing.  Thank you for sharing those, Mattathias.  FWIW, Assisted-by: tag is
no more required [1].  I don't mind having it, though.

[1] 1e035297ffda ("docs: remove Assisted-by references")



Thanks,
SJ

[...]
