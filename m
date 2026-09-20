Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AA343D75;
	Sun, 20 Sep 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898434; cv=none; b=MjowhUyoUahsRnyMiaJam0g56Cpglwty5BuBR6ajJisPTToF90w8UxQ+BNvvFL/2zKOlytkDCqQ/b5QrJglaMBxr0EJitKWotyFibJYz/HlQWt2IkXfupY3xQCcv2NQu0itmp+vhwDsmp7B1v1vUADlZs9rmX1hfdYS5YALd67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898434; c=relaxed/simple;
	bh=i/f+ltDwE+0pDEfrDUwL+taMO+IjvxPZcpSA4mM/NlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3dUa4E7kXhktJQ23VlqJzEp7ajwoo68vZp5/Fn3S1EDbBBB5/dzl0ZK43/RJ3Ikp9kdsyJ51uPSWABeY1jzoyNZQaYJYD0PUHv6FgCyRmsbz9+TUQ6jE0cMpI+J1aHYqv0ToqFAlCA1JSh/knVvckaoi1pEdM2weqLirHVSEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwfVX3I9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwfVX3I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67AB1F000FF;
	Sun, 20 Sep 2026 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789898432;
	bh=eNOkuOvBgpaeImx4XytamWlsHw1NNr1OL5vpKYxF3rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwfVX3I9FP2+Cj8IDi6JXuS9zcovsK5gEevP9S2LkyW/wd5gFw4QKgVFahXizcQjY
	 qH4BLljpWsAnohK8aOSwE+js0ywxcy+ai1wUDHEvJMlt+oNdr3FqYp+0ZMw5TPjYbi
	 AAJsz6+hfTCUiW6DHcDxu2kYQ417eL+TfLrfTTQxp9lOLpFfXomF82B0VIAANbMJNA
	 P4oOsP03EK2aVn4CpUXsw33vXDjncp1USqz9FrbGWz+39T/IdK508cpC+b+qnF8wJO
	 FbJfhNBUejmQPS95Z2oRaye0VqUvWyKk+RDojqKBipgw+BuanvfgbiBz4w9rWEryAJ
	 00B04w9Wg3DQg==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/api: remove unused NR_DAMOS_* enumerators
Date: Sun, 20 Sep 2026 03:00:28 -0700
Message-ID: <20260920100029.46849-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920012028.9565-1-zenghui.yu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 09:20:28 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> NR_DAMOS_ACTIONS, NR_DAMOS_QUOTA_GOAL_METRICS, and NR_DAMOS_WMARK_METRICS

More than 72 columns.

> are not referenced by any code.  Remove them.
> 
> They can be reintroduced if a real user comes up.
> 
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Other than the above too trivial thing,

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree with the fix of the trivial commit
message length issue.  If this patch is not added to mm.git in short term
(~1 week?) with the fix, I will ask mm.git maintainer (Andrew Morton) to pick
this.  So, no action from your side is needed for now.  If it seems I also
forgot doing that or you cannot wait for my action, please feel free to ping me
or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
