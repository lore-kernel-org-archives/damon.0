Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB02FB639;
	Thu, 21 Aug 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796496; cv=none; b=bZ4VEa9iRNmg8FHlqgWzQVknkY1QqhqlZZ9oCGKJTE6WtBNLOvzDrwb1GrCbJka8RR4FG/AmwwBniw/qjfE7s7YO+rykMOKwnN0IQsD7HqrM7bsbZGHE7tMoEorBUNaoovIVk5eR/MAAXtjKkRwlP08IZzxkAZ2/Pqckwue3gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796496; c=relaxed/simple;
	bh=1vDDyQ2wAyO54CObnl6lZo6V3Vc1WKcRhHbyiY2WM98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGMx+5pfAFXUKbSk4ua/ZHn+XkIM4W2pVYnnFtdOU96YvWqZEpyNh3BTWhSj4h6cW5Ph0nwuf7P9I4gMS9iJ89jj1P4Y3SbEj/qeHswxIWOxXM1FzOeS33LSeWSUyes33kCHxAgWfqHde52ofnjsDpRCk+zRzqzvuvcNW0GKMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk0po0Ju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk0po0Ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E452C4CEEB;
	Thu, 21 Aug 2025 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796495;
	bh=1vDDyQ2wAyO54CObnl6lZo6V3Vc1WKcRhHbyiY2WM98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pk0po0JuG/OGdbRlFS5EkZOGFJwN8zM6BkdZ4VetwSLqGgBvUOLDdWBtB0kBmar8J
	 7Co0+7Rt0dl9btHy2uBveAcTAZVxaeiAbsOj7jqNzR2KAz+DYGJbkZRt8EX1bAwqMr
	 QyauX7LRl8K/qQ/KSR4Kjff2oFgAuEcs9EdYnblhOZot6kdMzfhxJBbi1uzND2d/Xe
	 fIVzm0zsMoFaMslY/NfoxdLR/WTjc+rhpxvQxPLMELoSYsRT8C7cJLiitcQv91qGQc
	 e0rES61qBQvfV5qh+yk+c/tu8SVY3iTgH40HOzYSth19Yg3jk5XcvLF7XLx6KCxUDZ
	 oSH4mz4tQnlCQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Thu, 21 Aug 2025 10:14:53 -0700
Message-Id: <20250821171453.81776-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-4-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:51 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_PAGEOUT action handling from the
> DAMOS operation implementation for the physical address space.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
