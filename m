Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BE3E172B;
	Tue, 30 Jun 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799045; cv=none; b=JBjO26yKjenR7rY4DEkJrxQydUcVS6e+tNqMBEVX1c4kKddzaldV6eUie23U0qhjvVmcPrup5tg7gPqPJtzuzruamIM9PDoFpH8lZG/1K0rg8wziSrdsNrpbK0szJCBJz53U/hcZQ49x13II7K09DUwWhHQbRrL/sTCY/ZGzFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799045; c=relaxed/simple;
	bh=5yOgCR3gE3wWNiiZNV04Wm7fghNtrivSYHgYEze5x/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E778TNafj/uLMThiLiERL9HPiAB5tGRM/6hRt/MS6mCP9KYioVoZyTOyJJSfLLkwBxxEz+gclbHkd6cwj+2KNaGmpC4HaWj6AYBKlJwyORS/xcUP3262v9xm/25zjQccTN0t5tiUtPVMJ0R6oaMd9ZxyfhhkRGL153OI+cY6zZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ/kntS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ/kntS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D07A1F000E9;
	Tue, 30 Jun 2026 05:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782799043;
	bh=LyJYCsE6xTmRMMFlBTBzhXZGR3rpltmstKwqZS6lHeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aJ/kntS7PgCT1G8W5IO936nUF8aVjpmcFkkMsElMuw+flusPuWyYIWQarTbMgdreE
	 YkqozLGV6ncLJMBOG2CbejlYvtP0S68tiEJ4wNLXexNw4ab+rbBYCxvPNjVwXzwP6h
	 7aAeXdyC1TCDMRhyLIYpyvx0keOQy5pDNG60SFN4t9xxtFG4t3FRUla8HGrr++4UtX
	 dW2WNDiQlvQw40XG0vi8ILnGt+CpCVBkX6X0CEq4kxhRziRn9OiLpgPfqIyW+esgLA
	 OgDyJqTeOIaNB3zNThXp5tU/ae9yDUdbfGZHAhZKRPAPNuDzweYrQfsS/jU/Tenbop
	 Sy+GKDYneQHaA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	SJ Park <sj@kkernel.org>
Subject: Re: [PATCH 1/5] mm/damon/core: use kvmalloc for target regions array
Date: Mon, 29 Jun 2026 22:57:15 -0700
Message-ID: <20260630055716.87704-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145538.134832-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 07:55:32 -0700 SJ Park <sj@kernel.org> wrote:

> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> damon_commit_target_regions() temporarily allocates a single contiguous
> memory region using kmalloc to store copies of all damon_regions of the
> damon_target.
> However, if the damon_target has a large number of damon_regions, the
> total size may exceed KMALLOC_MAX_SIZE.
> 
> This problem can be avoided by using kvmalloc instead of kmalloc.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Reviewed-by: SJ Park <sj@kkernel.org>

Oops, another typo...  Should do s/kkernel/kernel/

Andrew, I saw this is already picked up to mm-new.  Could you please fix this
up in place?  Let me know if you'd prefer sending a new revision with the fix.


Thanks,
SJ

[...]
