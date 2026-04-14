Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69C23FC41;
	Tue, 14 Apr 2026 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142213; cv=none; b=O1T1igdclu/3bbtYUQqCnFYvv/ZH8IM6fXoFgE1sFq2cUQYRKBCj0150aBeTuG7G+DJWYX2aygM+kfTRNze84ZwpPfsjsaEg3ryUs7KElSpvMllLACZpVUD3IsdnRd68WdRTx9kXf66jhIDiMCMeJcrJmyLthTz3DkHFapQvmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142213; c=relaxed/simple;
	bh=5iCWCEKDDPqCsu8fPNYfYCrKYrkHznMpVFlO5/hTiEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSQeW5GL4HEk6HZMiPrsIN6F5GFDkVhOwmnEmIKIv5wpABexYMFV9dMKjriI4Ss3pLxGB16oVhJRyquNazxiYwgTtbpyEe6egor5fuO/iituuN6AJA69jWUK+NP1/JZ1li+2544qsRQp9UPnIQumWjem5Eo/uCCwG9XrdIoTexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig2EsDVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig2EsDVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEF5C19425;
	Tue, 14 Apr 2026 04:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776142213;
	bh=5iCWCEKDDPqCsu8fPNYfYCrKYrkHznMpVFlO5/hTiEM=;
	h=From:To:Cc:Subject:Date:From;
	b=ig2EsDVrV8+izTRy5sFOD53mkrEuyIkC8qHm83mIPXjSfpIzzy8jKzPPxbsQsYCAD
	 CZtZkQMHgW2nHHW/G7Bq1HvWQ7gbrLdTc3cEbOB8VLqo1dAxOfLet2EFFaP9S539WM
	 DQjIBHwAl8EhKQ6sXwKluZzovn8V6CXaY1xgNhkUgKSrT2zLdOhzCvYm1KyQRjngOC
	 FTWOsm/S4FtXx9wjItiZVbRGLHzciK6It931s/BuyhBi20ec92xzKfPYd5A06wKyH5
	 s+cucEE5zQP51jJibAa9mtUNUZyL/LsXWnU3BxhgeQ49nPytIVAxikoNwwAlQLGBNp
	 ROh6jkeuTjKFQ==
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
Subject: [RFC PATCH 0/2] mm/damon/stat: add kdamond_pid parameter
Date: Mon, 13 Apr 2026 21:49:58 -0700
Message-ID: <20260414045002.88110-1-sj@kernel.org>
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

SeongJae Park (2):
  mm/damon/stat: add a parameter for reading kdamond pid
  Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter

 Documentation/admin-guide/mm/damon/stat.rst |  7 +++++++
 mm/damon/stat.c                             | 13 +++++++++++++
 2 files changed, 20 insertions(+)


base-commit: 5262d0a487d50faeefbca2e4ebbdfbed3f69426e
-- 
2.47.3
