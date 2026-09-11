Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32ED381E85;
	Fri, 11 Sep 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133752; cv=none; b=irTY4/TiV/ZaiMl3YACPCdXGd+6z0Zgs7nBRNzurMCG95oAeLtS8Oloa04LdRMkaptZY//Hk5YunG5d0OpV3UQ2yy52QEHJmMTb1m3N1/DpVfTxPTrmVKqgdUPLsBfY+RGqdZvj5JJ6MuSIxRNx8xP5rQYyONT+aEYfHZvpJ7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133752; c=relaxed/simple;
	bh=Fi5RS+ZGr4LqoSIZFrNySYRnWGBjWO2HwRLas3YEFU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4t+pol2q/F1oKSFd4DcgdPbleLNrP4IXUN2FxVFr0xPQQ1cv08AMGzCDuKt1iN30PTk8hLq20DDesTttbH43UrJBSKGqwrQWUg4fPaqTkxniyPh7slokAgGgDNW9N2d5DAuFH2t3IvmgjeigAMvD7o7vlwEo1UYzLnTr50lxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuqZzmWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuqZzmWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C101F00893;
	Fri, 11 Sep 2026 13:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133751;
	bh=GgGvB7wf3jMu2SKBD8yyeQabKZY9LxyLIN+L7CC9SH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WuqZzmWte3bB8Ft6qad7MYpkg/9RfskcX7IDxobWRqOvNgeD8tGWhYXzdKo9PxsMr
	 2HyIUNat9KztrqS3dCQOoSOpdsB5Rx1ZI3NBkSn1PuY0xOOmngDOFnMfRIKJxRS/cH
	 gRTdgbrETaoPK+AXcXPXMo6N6EztBKkCVpEm97ajoz9nK8y/6sFJoAjL9rSFMM/1+d
	 iBy4MtTuRNUCjytG0kVee3MqTIx650ie7Jjsy5Snv6RbcptN9fgA/XNfOBb91k82B0
	 7PWQFpjtL+Q9xQlKIy1yzAYs7YGo5xFX1OXL603T8DXiBGmjneV4Y2z2Rb4e3Q1s+F
	 JdUS+KQBVXGWg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
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
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: fix typos in temporal auto-tuning algorithm section
Date: Fri, 11 Sep 2026 06:35:43 -0700
Message-ID: <20260911133544.91871-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911093314.156875-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 17:32:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Correct incorrect references of "quota" to "goal" in the temporal
> auto-tuning algorithm description and fix the square bracket formatting.

Goot catch, thank you for finding and fixing this, Liew!

> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
