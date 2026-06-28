Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49961D7E5C;
	Sun, 28 Jun 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684499; cv=none; b=tnGPRQTJUT1lRR/OW+gqIPjHKjgQT3dBIqObOZSNDq3esjBHCovgxv2D9TYmybtTfDzMNPoIcYq2Q0bdwBNbm1X7xrPfPZIoc2KagE5EXVsWUZJH8j+/Us8k7DlErN8gVKRVoD1xyL646r4n97qip4kRhZ/EZXlADpQWNtwxhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684499; c=relaxed/simple;
	bh=GHdV2dH8IrCPgct5pC1g4kt8vQR0ccTKg17QZVW5EnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6DwBKU+SwA1sM+KW2rIgJOusncF8JVgnAr3UMIFPGbzWfbScp6a/tA59UbX6UDbQ0eH7bKQzNQwnwrvBbKfOs9i0q9knDfbrPlaO0qaeH+DUhuOrq4TalLos5JChRF/6N9G1AAo77BAWn9wbv6OYZiaPv4A4f5tmYkvGylIxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111101F000E9;
	Sun, 28 Jun 2026 22:08:18 +0000 (UTC)
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: add kernel-doc comments for probes and rnd_state of damon_ctx
Date: Sun, 28 Jun 2026 15:08:02 -0700
Message-ID: <20260628220808.98931-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The two fields of damon_ctx struct don’t have their kernel-doc comments.
That causes kernel document builds to warn.  Fix those.

The broken commits are in the mm-stable tree.  As the issue is not
significant and the next merge window for 7.2 is expected to open today,
apparently it is too late to squash these fixes to the broken commits. I
hope these to be merged into 7.2 release after the merge window, so that
those don't bother stable@.

SJ Park (2):
  mm/damon: add a kernel-doc comment for damon_ctx->probes
  mm/damon: add a kernel-doc comment for damon_ctx->rnd_state

 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 7875263842e9465bb31d0dbbcbd899610dfe43b4
-- 
2.47.3
