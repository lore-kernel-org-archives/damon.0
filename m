Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4A3C00
	for <damon@lists.linux.dev>; Mon, 31 Oct 2022 18:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C70C433C1;
	Mon, 31 Oct 2022 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667240763;
	bh=G91I60Ol4QydHlf0mecqvnzRJ7lAwY37ycd5EgIHiNA=;
	h=From:To:Cc:Subject:Date:From;
	b=mwkrMkEzxQ2aBJiRdepyeP5t5fLzY4CAtpKfH6JMCnHZ/VQ+dYxFX0iCcFO5gFDix
	 02rFZKQTxdKHR/Lv8Jlcv2w+ShC0DPpVcYM2H876SKCw/B5ufMRO9bzaAQsd7iIpzP
	 gUJ5v/jTtpxcpsrk8tH598uGrOb2BpzHxGQZafU/J2/QqS3D8D97kVy+K0Lt9b7Nf2
	 +A3s1Gu6nonRmiA5N7F+dp5FdSau3BRTLg4JaXOLU3PiDRT7bfDa01vdEK+l8oDm5R
	 C8do+DA6t2WbL0Lq3UMSEOopPedqr40+hIGrdo+LpmjTud6HHXLACzH8+00cNo7dMg
	 h14pnuSkhu3rw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix slab-out-of-bounds Write in dbgfs_rm_context_write
Date: Mon, 31 Oct 2022 18:25:52 +0000
Message-Id: <20221031182554.7882-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is for fixing (patch 1) the syzbot-reported
slab-out-of-bounds write in dbgfs_rm_context_write[1], and adding a
selftest for the bug (patch 2).

[1] https://lore.kernel.org/damon/000000000000ede3ac05ec4abf8e@google.com/

SeongJae Park (2):
  mm/damon/dbgfs: check if rm_contexts input is for a real context
  selftests/damon: test non-context inputs to rm_contexts file

 mm/damon/dbgfs.c                              |  7 +++++++
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/debugfs_rm_non_contexts.sh          | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh

-- 
2.25.1

