Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35841443C;
	Wed, 23 Sep 2026 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143573; cv=none; b=NwqSF0dkcPg3jgVyBYJWafhShBGkkbLx1zL7Kt+BKM3ix9A+jVHqIli4Ri9oIhqjvKzc8TEH0APvIHZrqtwX7SepcqKfToBOQF1hkRqJWONgDBqkKfUDtnXC2iXWTrTXfdyJkvLzbPto81C9kuWYmqKAHGKoFtq8a9CkAfMDQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143573; c=relaxed/simple;
	bh=JyqsjNMcsXWV3u5r5O7rgtecnuQJ+qmGrHBX/IzaxmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGRXvoV/psaT4CrbFL+oOMJWOtkDrsTVIQ2p/rIFWfq1A+4ghBUm9XU/mA+6JAKBChLnOD8+wAk1vlIQ+Q1nOsU99jsY3d164Dw9+UrJyQZKQgoEzZ4Jk08/PZ/1rl376Cw+aMf2f3PKgHakI5wJI12Dpt4hmZKUIDNdvSs7ZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyfPW9I1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyfPW9I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D87B1F000FF;
	Wed, 23 Sep 2026 06:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790143572;
	bh=q8xknLz0/hAEOZEQ449Z9zgJEDzncDaOaGx5dlfb95w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyfPW9I1lpAhTu2TiVmhGg8gtfAuR6BHkCcubtD2LxpQjy6TXjsyBcQ+HALJPCUCs
	 Z8MHyZGN7Xfama31gTf/86hqq+ZH85617vaaht4hicBYgYI1XOrjuSrl71OPA3Npv2
	 kjfSVyOhh0NRxkt+lwrcHks4bOH4mq7EHj1IdMKeoCSYCGY6gwLuFURllRJAoooZS6
	 IBJukl0zq80eZDpiPtumAP13wMfQDgQTCbB6Z+NJdrjqr7QoQxKdIFhED4kxfGMeNG
	 XfL4TX+J1OPE6JXBXo7YVALVLzrkDYgtC6uBTYs/hFTPbYXMNCeU//QGB3ilJRcaCK
	 xvUF+CRBr8ydQ==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Tue, 22 Sep 2026 23:06:07 -0700
Message-ID: <20260923060608.4097-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 09:25:57 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_goal_tune_esz_bp_temporal() hands the size quota to
> damos_set_effective_quota() through quota->esz_bp in basis points, and
> the multiply that gets it there is unchecked.  On 32-bit it wraps above
> 429496 bytes, and a wrapped product below 10000 divides to a zero
> effective quota.  damos_quota_is_full() is then true on the first test
> of every charge window, so the scheme makes no progress for as long as
> the goal is unachieved.
> 
> Patch 1 bounds the conversion.  Patch 2 pins the boundary in the core
> kunit suite, where the new test would fail without patch 1 on any word
> size.
> 
> v2: https://lore.kernel.org/damon/20260920023111.2466265-1-donggeunyoo.kernel@gmail.com/
> v3: https://lore.kernel.org/damon/20260920122411.610213-1-donggeunyoo.kernel@gmail.com/
> 
> v3 was posted before the discussion on v2 had finished.  My mistake;
> this version was held until the thread settled.
> 
> Changes in v4, from SJ Park's review of v2; the code is unchanged:
> - patch 1: drop the 256 MiB mention
> - patch 1: say what the user sees before saying the setup is unlikely
> - patch 1: cut the closing paragraph to "Bound the multiply."
> - patch 2: unchanged, and carries the Reviewed-by

From next time, please add full changelog (changes in v3, v2).

Otherwise, looks good to me.  Thank you for finding and fixing the bug with the
test, Donggeun.

This series is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
