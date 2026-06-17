Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7622165F16;
	Wed, 17 Jun 2026 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669810; cv=none; b=Vh/gXQBJQOR6byhOTBLyhFHnYJmzT0GsmLkft6VebfzhmYK5GY9CSgG8P3ts7u6oFdq0Ik7kbkRtbuKulZhhFA5dX/BYPgo8bdEGczNSSeSNYKTs2UFFjjkbmVfbsvk7qsD+DgPnc+5aoKLiI64yI5kaW0Fh7JSAoaYQyEhx6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669810; c=relaxed/simple;
	bh=x3Ka6vrus6IrFUSoAz1Wy7PCDT6I8blzQ1vWd3rLWJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwUjR4aSXEsOSWi7SbhEKzktC8FjQ/Q1gPe2ZwvOC8FJLKVAols1s0k+/pmfzNjfxeyc4yGkRWMtf6ZzrTnyeUw4nPj8Dqdy4pU9a3O7yxCrYsklNCpcGLizMVKwR6KZ7JnsQv36DuZ4rVPble+xQR9CoQoj9rEti+cQh1C/eiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR4slr6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR4slr6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7E71F000E9;
	Wed, 17 Jun 2026 04:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781669809;
	bh=tiKJc09+Au+978hFowqG63MFLKZDfeER8N/YPJqE24k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XR4slr6oIM/4HGPtUYAvNhCMBhNVu5AHFtM31LZ7OCbylLFjgdfu1Owanf/JiQEVm
	 cB23DEV0Y6MaGS0IAD+QPYEqrqbFWyItzIF/UmUrH4QN47sj2S+kdXZjtoRcnpZ71s
	 SB4Oc+zrv+mxLiQKh7B6I8rqWcfhiUXV3ly82CbTTvHQB01riDy2m5hr+HJMj3Y64q
	 LS7vzHhVjqIexOsTjGMwNc8WISzKZsGAPk+eNh2qBK5k3MnlKDv1e3sh19ODDR69ri
	 bwAI298I6Sq3o7N/+SGef54woPOizqgbK9jTvwg0XldwUFhAsar6TU6FZhuRJBanhx
	 RsTowlofvAiXA==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota goal metric
Date: Tue, 16 Jun 2026 21:16:38 -0700
Message-ID: <20260617041639.99030-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150316.580819-4-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:03:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
> This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.
> 
> Add the "hugepage_mem_bp" to the sysfs-schemes interface.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
