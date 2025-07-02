Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79322D4F6;
	Wed,  2 Jul 2025 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433366; cv=none; b=mUV49XmFzNTVw+yy5SGsYC0LFU0dGP8gMqiF+izVuxY14v8gKD8JeRiRX/PWhJqI7jsZHMZzzUBSj2JQJlJAK4RVPz6FUyyfCffZJvMbdrnBP57ZZagJjSbYcIhnY1NYIC6BOsmlfDicV8E9vv8CEhNtF4vq5nH5KuFKYHTXtvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433366; c=relaxed/simple;
	bh=GOT+hMMc2cAgxhFzxN3QZQCNYo95TBfs4Wp4R9OGGQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zi/rpATPoQoE64kEShMjblq+xk7PSFqaFoweNi5tRdLAArccgUg2rL0Bq6oYPz07bGzAEDu2Bw/WQjHOzgQw6x3MLuEnfJ5M3o1pZCZrGK3z3cC12sd/hychT5+GIr0EPRUOHbdkDwF7qv4GbVEOZgkA9flLZXkOmUfp59H9x3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0N4UPpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0N4UPpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3A9C4CEEE;
	Wed,  2 Jul 2025 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433365;
	bh=GOT+hMMc2cAgxhFzxN3QZQCNYo95TBfs4Wp4R9OGGQM=;
	h=From:To:Cc:Subject:Date:From;
	b=h0N4UPpQ6fmKhHxfZ2f7CkES6W5lrR0kMo8MADzDdSRgafV4fQ8wbar1D8Zh9fLMC
	 E8FdaBgTFQY4AOK5hxMimyC9ExjGGKeKqceFHpHra1YkBMYgvUF7XAJIM22oXpO95u
	 Ezc/mOLbZgELP0LP+yYWsdQiHzSSNH+lGuXVs4hrzYfM7Oobsf0KCPZhjGyVs/dtc+
	 zNsVePw9LcM8zdHgKtiqYfOGetMOjtkOU0c0Y6atpAi2qAp45v/pebHGjEc4l3dbx+
	 cF9QNnZPsZ+PkNjFFEi1VnZpb2+tuoErvBvDHcwj+ddHndm4rxgL43MEAuMvzZMifD
	 x3IzZCgDtwAmQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/6] mm/damon: add DAMOS_MIGRATE_{HOT,COLD} destination nodes and weights
Date: Tue,  1 Jul 2025 22:15:52 -0700
Message-Id: <20250702051558.54138-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_MIGRATE_{HOT,COLD} action can migrate pages to only single node.
It could be useful to allow it migrates pages to multiple nodes with
different weights.  A work for dynamic interleaving[1], which is in
progress, is an expected case.  We also discussed this could be useful
for memory tiering, e.g., when we want to move pages to multiple noes of
same tier.

Extend the API and ABI for specifying the multiple destination nodes and
their weights.

Note that this RFC is a prototype of the interface change for Bijan's
interleaving work[1].  Hence this patch series is only implementing the
interface part, not the real implementation of the migration behavior.

[1] https://lore.kernel.org/20250620180458.5041-1-bijan311@gmail.com
[2] https://lore.kernel.org/20240408175228.91414-1-sj@kernel.org

Changes from RFC
(https://lore.kernel.org/20250621173131.23917-1-sj@kernel.org)
- Add documentation patches
- Wordsmith commit messages
- Rebase on latest mm-new

SeongJae Park (6):
  mm/damon: add struct damos_migrate_dest
  mm/damon/core: add damos->migrate_dest field
  mm/damon/sysfs-schemes: implement DAMOS action destinations directory
  mm/damon/sysfs-schemes: set damos->migrate_dest
  Docs/ABI/damon: document schemes dests directory
  Docs/admin-guide/mm/damon/usage: document dests directory

 .../ABI/testing/sysfs-kernel-mm-damon         |  22 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  33 ++-
 include/linux/damon.h                         |  29 +-
 mm/damon/core.c                               |   4 +
 mm/damon/sysfs-schemes.c                      | 253 +++++++++++++++++-
 5 files changed, 333 insertions(+), 8 deletions(-)


base-commit: 8a6d44984fa3076b444a6ddd8a8898b6ba254d25
-- 
2.39.5
