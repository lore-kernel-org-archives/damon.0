Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28324282F31;
	Sat, 21 Mar 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123651; cv=none; b=K5SsZpxB3ZLy9sLZL3rK7s4qLIvFOlnC7h3FsyqPF7aeHlODtMrlD2+Y45W1/+sj4ubGI05aGzZ8HOS90tb+B0K6qmr+bDVBJVQjrg3jK3kX4ZMQD01La2r0Z7RIjleuO+gFWgLiN1T2jd6eS3LFxf10gBkJufKfHJStxT6iykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123651; c=relaxed/simple;
	bh=0MNSbzVZDYdlO97OIWpX8pZ4IYNdLpcfoylYibgIq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRSHyC45NaTPkvgqVttaUYJEGEwN3cccWo7cWZgZDgX4oXDq4V9KPlLifv9+m6JlKdjaORrpKmQdjLZKnbVW/AESbD7NXcw+dPtxhq9eFO3EEo4rv52Pvv2JXd52idB983ZcV1CRm2UZd8pffc1v8yGYP68KG3+TSOGfPepd5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5Up56d0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5Up56d0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEC2C19421;
	Sat, 21 Mar 2026 20:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123650;
	bh=0MNSbzVZDYdlO97OIWpX8pZ4IYNdLpcfoylYibgIq8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5Up56d0Zpao4XkiAbIdKYjt57W+ElFPoy6ODEJOZ++dBPp05k9Ls4q8Z/3CpO8C9
	 NFvp/nP+31hmAzLygzvWicm+18JCX5d+X2f/9XHNS2YOZg9WPZPIZbSgt5HCYaHtYC
	 srSDJgSNGa3jqfN+/Dcv4ilKvGXpvylwWAn/lbFShXkyLQYrWlwbkYRXKyD2RvqrF3
	 tRTsFBa9/PvJLmLe1jytUodREAIwjJyP8VkES1Zro5GHICnBP1vIqD0lDqIkDVVzeQ
	 mirmhCZ8Sds3gKJHrmGk/5aX9sDCgyQc01fNFNECQ86wTRRhC98iNiRdCktEFBJPbi
	 Cm4/kI2HfVlIg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: Re: [PATCH 00/10] mm/damon: let DAMON be paused and resumed
Date: Sat, 21 Mar 2026 13:07:22 -0700
Message-ID: <20260321200723.95520-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260321181343.93971-1-sj@kernel.org

- [PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
  - status: Reviewed
- [PATCH 02/10] mm/damon/sysfs: add pause file under context dir
  - status: Reviewed
  - review: No issues found.
- [PATCH 03/10] Docs/mm/damon/design: update for context pause/resume feature
  - status: Reviewed
  - review: No issues found.
- [PATCH 04/10] Docs/admin-guide/mm/damon/usage: update for pause file
  - status: Reviewed
  - review: No issues found.
- [PATCH 05/10] Docs/ABI/damon: update for pause sysfs file
  - status: Reviewed
  - review: No issues found.
- [PATCH 06/10] mm/damon/tests/core-kunit: test pause commitment
  - status: Reviewed
  - review: No issues found.
- [PATCH 07/10] selftests/damon/_damon_sysfs: support pause file staging
  - status: Reviewed
  - review: No issues found.
- [PATCH 08/10] selftests/damon/drgn_dump_damon_status: dump pause
  - status: Reviewed
  - review: No issues found.
- [PATCH 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
  - status: Reviewed
  - review: No issues found.
- [PATCH 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
  - status: Reviewed

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260321181343.93971-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
