Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820A4A43E1;
	Thu, 10 Sep 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049447; cv=none; b=ae8nBevXEc+cjHuDT+Bg54dh0IfroxKZB5v7ngNQaFkiV3nx0R5vsngtYJTLh5B+u8Z0D//rXKFUio+5eYrt5n3pv+fVTknmIRiE9p6/LThlYBCTrMtmStF0f1jlGQm0wLUBd0JadAP9AGxzreMHzvwVyHDY/EAmc18zg/W74xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049447; c=relaxed/simple;
	bh=wB2qcxMpavRbe612NiBcb3fYTpY+jx0JSHIdM5w9il0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R922ZblWbxwncoooE1l9N9VJMNUgoEidxrQSQS7JaTu3welK8Zcn3RLABRGYmg45JGjo7d2hpNPep6vOwW6Tws+SR6FlRu1t5ATMTeqVbuMdDLbO3XGpSh8igIp+em+TKc2pBMfgM/QZ2SxFtUUCR7Y6ymUHsGoWf6s2PDiuDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3YlUNYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3YlUNYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4CE1F00893;
	Thu, 10 Sep 2026 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049445;
	bh=uCtMBc/69YQLL/vmB0BOFo8lbp1vfibmleZ+RjFXS78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3YlUNYIYpaiM8jp3G4/WuOcLTOnIxdJwv+s+8uTI+kxKX65VwPDppqs+JE0zLvaB
	 NyDL2tInHbN7WThAmEhEtDhajRt1wFhhlIP0DMYqkynGRaURQKkbceSBJoxJ/3ZDTM
	 J6lzpSUHLaap9Dt7WgRzlmjkj+bowVZgXzobSJsWSohOBQjZ/E6lrjUrTQ55tUmUIr
	 hMBJoBiYnzzrCJR8o5kVUjQ/y1OkQCOrwlU38jpAP4x0CyC2YjOdvnevQAo6H4vXqx
	 gV1MqVpoDsbxEuZd+4owbI7fNw3vqsA2KdqHm7qUqimV2gt4p7d6pfDdQSJp9lBwoM
	 vDf49WpFcvzZQ==
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
Subject: Re: [PATCH] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Thu, 10 Sep 2026 07:10:37 -0700
Message-ID: <20260910141038.169135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910112255.157012-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 19:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> qt_exceeds counts how many times a scheme's quota has been exceeded.
> 
> When using the temporal auto-tuning algorithm, the effective size quota
> becomes zero once the goal is [over-]achieved.  In this case, the quotas
> are still set, so qt_exceeds keeps increasing once per quota reset
> interval while the goal stays achieved.
> 
> Clarify this behavior in the design document.

Thank you for this patch.

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
