Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBB1991CB
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316725; cv=none; b=gxOqzPKLfmH5zOX+uRU3ywLqaX2voXvwYpS/zNYRlik9mCe1ZQkbPM2AQbEpx4cJTBjrRVmStYoNbc71fzg0BZLVD4YXpSS3TOU1aisrdQ0XRcbyroI3kcKDqhDQQbUs/3KJ1F7FSNl7ynp7edxr8Kfq2oS4wQgixuZ8o9zHyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316725; c=relaxed/simple;
	bh=LrNSQsAm0Ll4Mgbo9bwCi4S7DLkJhEknRL4HpF/7Abc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMxW2RNXqzfhoqfaf2GiyQYtFHvT6YwoFXPLfSdCi2Wqm7upToJKauldUXYFZZRQiJ74gbiN2xjLNFFrECC0x6dIwjj1ESn5S+x6kWfX3+nJZwWPsswnpUvqW5WYuuujqj5CB7i8cvhTK77FAPbjF3mByXDZtcx1io42fl/D+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3BhzQa3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3BhzQa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F07C4CEF5;
	Tue,  9 Dec 2025 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765316725;
	bh=LrNSQsAm0Ll4Mgbo9bwCi4S7DLkJhEknRL4HpF/7Abc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3BhzQa3MebFQX+rVVMpmbWhnLYk+G+FkbiDiSZxuEHWixq6RDAGV0xSYDEPSy07b
	 EqgYu5FZLQQzPUtEEnbfaWxhVDm/zid2z1RBHRbJu6drYFrqeDhgDT1696fAeUDQqM
	 bpqPq/eO1PUTun+NUz0KrwjVkDCV+iYdoDuWn3wzPILKsLK7CX/wvbPC+Essaocyov
	 RgacqpGAc98eGPFQ1f3XFsO+WJN5Mcn/aQwYZm1A/2BrmJQGvyIfQOzFlkMln+5DxR
	 hnmBonTgS9CABTsmeErftpyVX6v47/iSuRxOIJLqFa2xMlQz8swB9guPxCIamf4c/j
	 mgI8OXOYwAB7w==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/vaddr: fix missing pte_unmap_unlock in damos_va_migrate_pmd_entry()
Date: Tue,  9 Dec 2025 13:45:20 -0800
Message-ID: <20251209214521.44487-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209151034.77221-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Dec 2025 00:10:34 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> If the PTE page table lock is acquired by pte_offset_map_lock(), the lock
> must be released via pte_unmap_unlock().
> 
> However, in damos_va_migrate_pmd_entry(), if damos_va_filter_out() returns
> true, it immediately returns without releasing the lock.
> 
> This fixes the issue by not stopping page table traversal when
> damos_va_filter_out() returns true and ensuring that the lock is released.

Thank you for finding and fixing this!

> 
> Fixes: 09efc56a3b1c ("mm/damon/vaddr: consistently use only pmd_entry for damos_migrate")
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
