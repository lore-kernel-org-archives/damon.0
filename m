Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC62DA76A;
	Tue, 21 Jul 2026 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606338; cv=none; b=h6cFUf6TiVHv2uIxnSxbxVrJJoGqQdFovbWqX7zfWbBqlVqyZVBW7lE9NGtozPC0t45K/pmLi6zN0uoBF4sVQE+QS2w00hiF6DjfR3PQF4FzKkFLJZq3mmdS8TZi0CiizKsyWA5B/mIUwcB6lqvlXBfxqEuVSjI7Kv5rVGlresw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606338; c=relaxed/simple;
	bh=obu7MieJr6Kbsh09/47CGNbJ+UvVnyYp38bxxHInKrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBaQwXrdWwrwti+DWBOgM/NE+jJ2H02G5A8p25HyZl/yXrFrm6oEDWXxPKYKeLLilcKYZ/c995DVizG5kVGkBUcMWugpp73bxXx4EWh0M7YJy1LrvpaN19igeXo6+WAjhwLsZhHxXZeGe27CneL+yrJ8VP+KoM2bolInc0r11s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMVVeMNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMVVeMNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181501F000E9;
	Tue, 21 Jul 2026 03:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784606337;
	bh=oJ6Px6DXNbc3Qe0XDywPZIT4PeLkWoS5DeFP+oHDWtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hMVVeMNI/exwtUfEOKmbDpudKB06CfsJ6S12sc3a5dbqfCXBpqs3iqDSxS8Y5vZce
	 q362Xnnk251ZMY87mIzm7QX5GqOsehzFwpaoo7BuJUQa0D46f2jJWoCB4dQA972oZ5
	 EAPsg2A9bwsMe4jO5kzXr53pTvNAifLffGZVRAKR9V3WcqLYYu+028agb/wv9wy9jj
	 5SfskE1m3N5fYcM/VMk0HP84+8FqFzFu/UAxtT+08+0/xa2pXFfDMVs3uWKtLqfyeG
	 8t5J/lkL+a3fa1ElywSRvr1b/PAkxdQPCIP71g/I9TQsJqyOdbLJk+r/6blgTHDg+y
	 fh1l6mvCeMHXQ==
From: SJ Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SJ Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Mon, 20 Jul 2026 20:58:47 -0700
Message-ID: <20260721035848.147455-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720120140.881468-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Mon, 20 Jul 2026 12:01:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ========
> This patch set introduces a new autotuning which allows to collapse
> hot regions into hugepages.

Thank you for making this series well done like this!

[...]
> Patches Sequence
> ================
> Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
> Patch 2 -> sysfs support for the new quota goal
> Patch 3 -> Document hugepage_mem_bp parameter

I'd prefer handling 'total' underflow and returning 10,000 instead of INT_MAX
from damos_hugepage_mem_bp() corner cases.  But definitely that is no blocker.
For the series,

Reviewed-by: SJ Park <sj@kernel.org>

This series is applied to damon/next [1] tree.  If this series is not added to
mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  In the case, I will update patch 1 to do what I mentioned as
preferred change if you don't mind.  So, no action from your side is needed for
now.  If it seems I also forgot doing that or you cannot wait for my action,
please feel free to directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
