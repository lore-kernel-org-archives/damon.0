Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BF2D2496;
	Sun, 22 Mar 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199113; cv=none; b=EGRxu5MheBn0Z+rUeVezOal6rWM5KG+bZDM2LwlUrj7SD1KLlzM+uilMFdcDf1Bo+Qf9ExDfwwyOXgp13uWsPw+7gni+99eTNKsk8Tl8jv05UeKmIV//EI8pWWoBQN8/R+T/phi9fF1ueI42PgInJMZ0AZWchHnoRzh33xmsSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199113; c=relaxed/simple;
	bh=HJoiHpMG28GmRpq531IW9sBKidvKsblBjEBS3EEdba0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRf8eG+63e6VO8S7AOi6vndG5uVFxwIMadWbVVClg5FssCUBBJ3m4B7tpVhZ6Je7s0CwaLtLdqOwWdcxjXRXbcWxl78brZzrHi+0bUM+KrcFiTxmXXx8K+YXTRHHLMkCyJ50PNJ9uFi7p8V7Wk4aEArDKR3v6ZU61RMxpff+6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCbu3oFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCbu3oFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13093C19424;
	Sun, 22 Mar 2026 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199113;
	bh=HJoiHpMG28GmRpq531IW9sBKidvKsblBjEBS3EEdba0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCbu3oFs00BZy4U6YYmrZ95gZnQkmg/QYu21GQI5AKJ3TWQvP16KJvFCDa7ILJzjK
	 qGIkvLizMUBjCg9x7UIS4zHWIaQHU2dpPb8t3p08w8yJqq6lzFzvWi95pcGpQr2ruZ
	 Gut3d8vRgNpKOMGTn5tL5zb8UDTLxjBowGL31FsjB6Ykhd5cQDyPixXqh9C5xuMLwX
	 KDx2WI/GGfBf69gbYXsGNNdMywRkqjkVhDzMG/x70lNvtNNmVA002mn9TRavRBPMiQ
	 aDvoL+KUXuVyLWJK+j91Z22Qt6iJeuqe5rn8Q8/vn9F3niwaZlEtIubn4R+ma3NwgT
	 pL/sAbPW5la5w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH v4 00/10] mm/damon: let DAMON be paused and resumed
Date: Sun, 22 Mar 2026 10:05:05 -0700
Message-ID: <20260322170506.82977-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260322155728.81434-1-sj@kernel.org

- [RFC PATCH v4 01/10] mm/damon/core: introduce damon_ctx->paused
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH v4 02/10] mm/damon/sysfs: add pause file under context dir
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 03/10] Docs/mm/damon/design: update for context pause/resume feature
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 04/10] Docs/admin-guide/mm/damon/usage: update for pause file
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 05/10] Docs/ABI/damon: update for pause sysfs file
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 06/10] mm/damon/tests/core-kunit: test pause commitment
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 07/10] selftests/damon/_damon_sysfs: support pause file staging
  - status: Pending
  - review: ISSUES MAY FOUND
- [RFC PATCH v4 08/10] selftests/damon/drgn_dump_damon_status: dump pause
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v4 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260322155728.81434-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
