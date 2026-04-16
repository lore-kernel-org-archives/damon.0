Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D322083;
	Thu, 16 Apr 2026 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298919; cv=none; b=AgSANc5niaukv4BAUgfIkQM2hAFxOg7POrLij6l1UYy26orLBvNciRkHnzcZvtRIAF//SiNngmfRCzzMuJSJo4jgimjuAejh0LwRbJbU6X4UPOzK9N2+1RBsdLVeriNwoSTfSsKq5YYMf5RNCETlwbmmvE66FDxwVK8DtZGwQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298919; c=relaxed/simple;
	bh=4aCM2a3NrSe0b28zTKT01qVpGH9mP8AJfok0bnI/F04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCHYkei0TJOgCbbuKY7cHj246uA+NKRN1ZsfpJF8A0UYYmMw474AQKO4K679Mck5rvbWa++9Bevh7eBLgT7Hq0E0UmMr4EcPdGB8l8TBNm6nLLhkq2YIWv0xDIACU4W9KEOsEh551CzJspxiVlfm/zlvOhW+m3GQzlAbtECbXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO0LzLDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO0LzLDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B1C19424;
	Thu, 16 Apr 2026 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298919;
	bh=4aCM2a3NrSe0b28zTKT01qVpGH9mP8AJfok0bnI/F04=;
	h=From:To:Cc:Subject:Date:From;
	b=XO0LzLDcbkq3gAmnsRuFTrN6VyKXKAFpBnpTwRQbzmvo+RxFbLxgdiTFJcKihAXob
	 m+TzjKNcfu24qbPZhOLSz/IV3EXPCSMqxY6RVMErTfvdT868Y8sHM33hqTY7ixMiaN
	 wbfIQ9iy9vAii4YKsjxF7xl7j0oJcX4yKNw8nQbLeaXDRG4wdfb2wmQIuQtS1V1llm
	 u39MDqgpU/srdv6eiKz1q1cmiwOWIXgUdjCaMONwhHsaofOCPmQcWa7qBk1fqvqXsz
	 WiQy3JgQUCxbdZHSYoUE7nXnmUk7MAACNpdIjkEwrSeNCUb+yocWjrwm3J64+gEAwF
	 usdS4+iN0VnYg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 0/2] mm/damon/stat: add kdamond_pid parameter
Date: Wed, 15 Apr 2026 17:21:45 -0700
Message-ID: <20260416002149.87090-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT doesn't provide the pid of its kdamond, unlike DAMON_RECLAIM
and DAMON_LRU_SORT.  This makes user-space management of DAMON_STAT
unnecessarily complicated.  Provide the information via a new parameter,
namely kdamond_pid, and document it.

Changes from RFC v1.1
- rfc v1.1: https://lore.kernel.org/20260414235912.98174-1-sj@kernel.org
- Close the parentheses of error handling block.
Changes from RFC
- rfc: https://lore.kernel.org/20260414053742.90296-1-sj@kernel.org
- Fix damon_kdamond_pid() failure handling.

SeongJae Park (2):
  mm/damon/stat: add a parameter for reading kdamond pid
  Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter

 Documentation/admin-guide/mm/damon/stat.rst |  7 +++++++
 mm/damon/stat.c                             | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)


base-commit: bf44f59d29186d80db01e4124a8ab23b3b235b32
-- 
2.47.3
