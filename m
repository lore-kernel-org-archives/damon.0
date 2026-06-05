Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F830C154;
	Fri,  5 Jun 2026 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621794; cv=none; b=uI+XX5Sznd2L6vL5XEexBKVXE+RlvekEvIsRjYbrKfxRiZcMmZe0ITdqmJ+tupd4gncbia05+uTOMsELzP5tfUodbfdBtlfP84/aHFYqpxYOB0upAUMXQIj+aOxn2hg2H4ZDiDIWFo1hFvrmAUCUhB9SlUBuIDbVBuaMq9MhhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621794; c=relaxed/simple;
	bh=phPcFV8eubpCtTGlCNUTDWYp61QpUpXQVPeAy0kZbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA1PLD9vzPuujfjVpsVMaUWgWWmI2pX4UyKVNYfJwVY36MMoci65OctbFY8bL+XRgWGXyj1FId8PPdKGroj0nouetu8ykleGd/qiuW0muMxe8SgWtlj8hbOP5VjB0qZyyiJasFE/FT2m+ECdUAC/C70BIx9GzQclqmVi+u5QyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMAgH+Bh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMAgH+Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA32F1F00893;
	Fri,  5 Jun 2026 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621792;
	bh=ehBAQB/RsO81o3Ma8kEkus27EmlKUL5ZUfOMvorCwK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMAgH+BhEsSGaCBYIVG0k4dRchvDozpj0/FIxqNz7AuPpYa3/7EMkJ7hltbnj7KrQ
	 xSy5IWO9qIiNg7rHODI68gv2NW2vZ9Ukkf2y8H2EHqJn9QyyEMcSCdX6dSmZI9RbJM
	 9HCQ/HL7Yb4LYXz0LkNphSp/2UqSVUJMLpxwtvHfl0pC5dG5GgBjy86n4RSplDYCJa
	 KLc/0d6sMf/e/6YMdNKD0biEFheRplzVK6DBvL6UnOP8NlH4h4XClouPXct75IEm5V
	 ztSEB0li5CoGbLnEISo293OOLUuCiD4bLmvePEaKgQPGKJNnbKDm6bChTbAtdHg6FH
	 usnaoq2j9BAHQ==
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
Subject: Re: [RFC PATCH v3 4/4] Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management
Date: Thu,  4 Jun 2026 18:09:42 -0700
Message-ID: <20260605010943.83146-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604150338.501128-5-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Jun 2026 15:03:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Add documentation for the DAMON-based Hugepage Management
> (SAMPLE_DAMON_HUGEPAGE) feature, which automatically manages
> huge pages by identifying hot memory regions and collapsing
> them back to regular pages. The documentation covers the
> module's features, operation, and all available module
> parameters.

For sample modules, I'd like the code to be simple enough to be able to
understand it without a dedicated documentation.  Apparntly this documentation
is made since you were following the pattern of non-sample modules like
reclaim.c and lru_sort.c.  Could you please make the sample module simpler and
drop this patch?


Thanks,
SJ

[...]
