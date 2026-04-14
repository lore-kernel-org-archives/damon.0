Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3C3E8C59;
	Tue, 14 Apr 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211163; cv=none; b=tn/Fq7VsZSTVZ+GeSX9p17lrhhiQKbM5ztNwYgIQdkYCziziMnWLS3I61Hq9Kq8io6B7+OmYx2qyDsYcdEiHVQBsmMMd29I2C7DNLiv+AU9ghnHuhxJ99/yMIbdSppaSpL1X/cTQv3t1k/At7xH42IcIMZNoqzeiBjVmAxGFUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211163; c=relaxed/simple;
	bh=aT2joNhwB38aP+3ueokcrxLbjs3TuKPM6sz/BJoGywc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNAdWpfXnxV1oJx8siz4hnvA6wnRE4jbFqPyPtE/zg1ZP56fi+9i5ItyGQCtq57Wr+FtJrfpL+AqgRaWLJVVyokQE25+tR+YX6eqIjLTZrm2VWTlxRlpQxIY51Daxh42Azv5jS2+5CZXtDNSquZLDAbHFYxVhY5TiNt7dVnueiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8NiXV9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8NiXV9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD20C19425;
	Tue, 14 Apr 2026 23:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211163;
	bh=aT2joNhwB38aP+3ueokcrxLbjs3TuKPM6sz/BJoGywc=;
	h=From:To:Cc:Subject:Date:From;
	b=t8NiXV9W8dHj+xU2joGruNKXvO0/2H8x8+UD6hI61Rbyf0IfGwER4zLs6cs6VuciL
	 u/OVlHWGPZcLEPhiGrOZslOrHnnfsCS58mAVDqaZ6XTUkQqNKtMfpKRgIi/mHmpPbN
	 6tw5vX/d0hBBO20SxZ2MXvRjxCZHrmeN0IVcm+qtxc9gB9Yn67wMUUJXGORwFhbkQX
	 BSuJC6O7F8vOxWVPHzcFMV9wf0K/OnvFOBnIDjQjLKWRAkTytxGmm7sDpA6vt2SG9c
	 Va57uA3o2dIqPBE2qxgjuxNsIONwJOiJZ8o1DSaLMp9N42r64EGc/wP76M7Dao71SK
	 x1qOOP52xgZhg==
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
Subject: [RFC PATCH v1.1 0/2] mm/damon/stat: add kdamond_pid parameter
Date: Tue, 14 Apr 2026 16:59:09 -0700
Message-ID: <20260414235912.98174-1-sj@kernel.org>
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

Changes from RFC
- rfc: https://lore.kernel.org/20260414053742.90296-1-sj@kernel.org
- Fix damon_kdamond_pid() failure handling.

SeongJae Park (2):
  mm/damon/stat: add a parameter for reading kdamond pid
  Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter

 Documentation/admin-guide/mm/damon/stat.rst |  7 +++++++
 mm/damon/stat.c                             | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)


base-commit: 02784c37a710fa3c8c3e7be4f27a5cfa3356dc00
-- 
2.47.3
