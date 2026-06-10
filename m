Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D198231A23;
	Wed, 10 Jun 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100147; cv=none; b=GEGrZYg1pdFyec48lWwBFs1iamoHH4Z7tXe/mQh2bUIOVWbPHdJg8HmVK2Q7Gh+ithKnVIow2SYNkCtpWiKSsQ9prexMHHv/HyHMQ3CM03gqAQBBTw+Jg7AfKxL/ijfxSuOkt+zMvCTINtt8YC5LaHlyWl66EruuYCUkzQZRzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100147; c=relaxed/simple;
	bh=F3XfSddtxoKja8HU5dC27AlxrWarHb8F2+GYeSpqugM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El+tu9lb5XiOA4cmcwCWpLclcmHPTNAOS8XDtvKiXVA6o7p5ZosDOks3VnUyflLnbJ9YbuQ8/Y3FOXFGoOQUD/OweT2cp0oLXOdZnXFqrmu2O4iafDiD0LZrPadhZePsxx6sZTRr+xo0tX8it3x0zyEJC3TkZHaCpCmBBWlKRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRtHvAXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRtHvAXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3131B1F00893;
	Wed, 10 Jun 2026 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781100146;
	bh=kuSmwGv7M+HksYo1sSLXZGpleDXHiSTOXzJAy0Yn9NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRtHvAXofUN/bHMnFNyeLYvbtY2fqUAlw6qCSwASZSLvtXYAFhhF8Vn1DNQ0Cahgo
	 uF6jFNlMHncw5BRQhEl9VaM/VNceaIEo8/iKKY5eZw77YSfajtexO5ODjyR5p6J5zQ
	 OF0fFTE0dSYIaz/V9QXi2iUk4YYAu1Bzo1p8DAX7DXZhP6nymmK6QuD177j0fJeXh/
	 vuGRJYo/oT90IY4oUz5DNYWeI7NCxHRka/qMppIP7L+13+ZQ0E0/iZonlC+spi2Zfc
	 UB4kUi8bFlVE5KeTM+RPjCn390JzZs+B794BTMpNTcQSYSLjnnMcgEdQ90p+iJg7tQ
	 G0KnDIFLM1HvQ==
From: SeongJae Park <sj@kernel.org>
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Docs/{admin-guide,mm}/damon: fix DAMON documentation details
Date: Wed, 10 Jun 2026 07:02:17 -0700
Message-ID: <20260610140217.65110-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610053951.553739-1-doehyunbaek@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jun 2026 05:39:50 +0000 Doehyun Baek <doehyunbaek@gmail.com> wrote:

> Fix minor DAMON documentation issues.  Correct the sysfs scheme file name
> apply_interval_us, the DAMON_STAT module count, a malformed reference, a
> misplaced label indentation, and a few typos.

Nice catches, thank you for fixing those!

> 
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this patch is not really urgent.
Hence, Andrew might not add this patch to mm.git until next -rc1 release.  In
the case, I will request that after next -rc1 release.  So, no action from your
side is needed for now.  Let me know if you think this is really urgent or I'm
missing something, though.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
